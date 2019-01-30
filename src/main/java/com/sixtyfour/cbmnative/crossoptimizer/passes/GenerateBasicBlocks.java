package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeVisitor;
import com.sixtyfour.elements.commands.*;
import com.sixtyfour.parser.Line;

import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 * This transformation will join lines that are not targeted by GOTOs
 *
 * The main benefit is that if you have a line with many commands and there is no loop in them, a constant propagator would be safe to apply.
 *
 * Code transforms from:
 * 10 PRINT "A"
 * 20 GOTO 50
 * 50 ....
 *
 * 150 GOTO 10
 *
 * To:
 *
 * 10 PRINT "A": GOTO 50
 * 50 ...
 * 150 GOTO 10
 *
 */
public class GenerateBasicBlocks {

    private static class Analysis {
        public SortedSet<Integer> rowsWithGotoTarget = new TreeSet<>();
        public SortedSet<Integer> rowsWithJumps = new TreeSet<>();

        public void addRow(int row) {
            rowsWithGotoTarget.add(row);
        }

        public void clear() {
            rowsWithGotoTarget.clear();
        }

        public void addStatement(Goto gotoStatement) {
            addRow(gotoStatement.getTargetLineNumber());
        }

        public void addStatement(Gosub gotoStatement) {
            addRow(gotoStatement.getTargetLineNumber());
        }

        public void addCommand(Command command) {
            if (command instanceof Gosub) {
                addStatement((Gosub) command);
            } else if (command instanceof Goto) {
                addStatement((Goto) command);
            } else {
                //command with no goto
                return;
            }
        }

        public void checkForJumps(int lineNumber, Command command) {
            if (isJumpCommand(command)) {
                rowsWithJumps.add(lineNumber);
            }
        }

        public static boolean isLineContainingJumps(Line line) {
            for (Command c : line.getCommands()) {
                if (isJumpCommand(c)) {
                    return true;
                }
            }
            return false;
        }

        private static boolean isJumpCommand(Command command) {
            if (command instanceof Gosub) {
                return true;
            }
            if (command instanceof Goto) {
                return true;
            }
            if (command instanceof Return) {
                return true;
            }
            return false;
        }

        public boolean isLineWithJumps(Line line) {
            return rowsWithJumps.contains(line.getNumber());
        }

        public boolean isLineTargetedByJump(Line line) {
            return rowsWithGotoTarget.contains(line.getNumber());
        }
    }

    private Analysis analysis = new Analysis();

    public boolean optimize(OrderedPCode orderedPCode) {
        boolean result = false;
        analyze(orderedPCode);
        List<Line> allLines = orderedPCode.getLines();
        for (int rowIndex = 0; rowIndex < allLines.size() - 1; rowIndex++) {
            Line currentRow = orderedPCode.getLineDirect(rowIndex);
            if (analysis.isLineWithJumps(currentRow)) {
                continue;
            }
            boolean found = true;

            while (found && (rowIndex + 1 < allLines.size())) {
                found = false;
                Line nextRow = orderedPCode.getLineDirect(rowIndex + 1);
                if (analysis.isLineTargetedByJump(nextRow)) {
                    continue;
                }
                result = true;
                found = true;
                joinTwoLines(orderedPCode, rowIndex);
                if (Analysis.isLineContainingJumps(currentRow))
                    break;
            }
        }
        return result;
    }

    private void joinTwoLines(OrderedPCode orderedPCode, int rowIndex) {
        assert orderedPCode.getLines().size() > rowIndex + 1;
        Line currentRow = orderedPCode.getLineDirect(rowIndex);
        Line nextRow = orderedPCode.getLineDirect(rowIndex + 1);
        currentRow.getCommands().addAll(nextRow.getCommands());
        currentRow.setLine(currentRow.getLine() + ":" + nextRow.getLine());
        Logger.log("Rows: " + currentRow.getNumber() + " and " + nextRow.getNumber()
                + " were merged as: '" + currentRow.getLine() + "'");
        orderedPCode.removeRow(nextRow.getNumber());
    }

    private void analyze(OrderedPCode orderedPCode) {
        PCodeVisitor visitor = new PCodeVisitor();
        visitor.accept(orderedPCode, (line, command, index) -> {
            analysis.addCommand(command);
            analysis.checkForJumps(line.getNumber(), command);
        });
    }
}

