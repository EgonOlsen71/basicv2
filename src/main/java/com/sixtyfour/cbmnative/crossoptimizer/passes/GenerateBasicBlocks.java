package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeVisitor;
import com.sixtyfour.elements.commands.*;
import com.sixtyfour.parser.Line;

import java.util.ArrayList;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.stream.Collectors;

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
public class GenerateBasicBlocks implements HighLevelOptimizer {

    private static class Analysis {
        public SortedSet<Integer> rowsWithGotoTarget = new TreeSet<>();
        public SortedSet<Integer> rowsWithJumps = new TreeSet<>();

        public void clear() {
            rowsWithGotoTarget.clear();
        }

        public void addStatement(Goto gotoStatement) {
            rowsWithGotoTarget.add(gotoStatement.getTargetLineNumber());
        }
        public void addStatement(On onStatement) {
            for (int jumpTarget : onStatement.getLineNumbers()) {
                rowsWithGotoTarget.add(jumpTarget);
            }
        }

        public void addStatement(Gosub gotoStatement) {
            rowsWithGotoTarget.add(gotoStatement.getTargetLineNumber());
        }

        public void addCommand(Command command) {
            if (command instanceof Gosub) {
                addStatement((Gosub) command);
            } else if (command instanceof Goto) {
                addStatement((Goto) command);
            } else if (command instanceof On) {
                addStatement((On) command);
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
            if (command instanceof On) {
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
        analyze(orderedPCode);
        return applyOptimization(orderedPCode);
    }

    private boolean applyOptimization(OrderedPCode orderedPCode) {
        boolean result = false;
        List<Line> allLines = orderedPCode.getLines();
        List<Integer> rowsMerged = new ArrayList<>();
        for (int rowIndex = 0; rowIndex < allLines.size() - 1; rowIndex++) {
            Line currentRow = orderedPCode.getLineDirect(rowIndex);
            if (analysis.isLineWithJumps(currentRow)) {
                continue;
            }
            rowsMerged.clear();
            rowsMerged.add(currentRow.getNumber());
            while (rowIndex + 1 < allLines.size()) {
                Line nextRow = orderedPCode.getLineDirect(rowIndex + 1);
                if (analysis.isLineTargetedByJump(nextRow)) {
                    break;
                }
                result = true;
                joinTwoLines(orderedPCode, rowIndex, rowsMerged);
                if (Analysis.isLineContainingJumps(currentRow)) {
                    break;
                }
            }
            if (rowsMerged.size() > 1) {
                final String joinedRowsStr = rowsMerged.stream().map(Object::toString)
                        .collect(Collectors.joining(", "));
                final String logMessage = "Rows: " + joinedRowsStr + " were merged as: '" + currentRow.getLine() + "'";
                Logger.log(logMessage);
            }
        }
        return result;
    }

    private void joinTwoLines(OrderedPCode orderedPCode, int rowIndex, List<Integer> rowsMerged) {
        assert orderedPCode.getLines().size() > rowIndex + 1;
        Line currentRow = orderedPCode.getLineDirect(rowIndex);
        Line nextRow = orderedPCode.getLineDirect(rowIndex + 1);
        currentRow.getCommands().addAll(nextRow.getCommands());
        currentRow.setLine(currentRow.getLine() + ":" + nextRow.getLine());
        rowsMerged.add(nextRow.getNumber());
        orderedPCode.removeRow(nextRow.getNumber());
    }

    private void analyze(OrderedPCode orderedPCode) {
        PCodeVisitor visitor = new PCodeVisitor(orderedPCode);
        visitor.accept((line, command, index) -> {
            if (command instanceof End) {
                analysis.rowsWithJumps.add(line.getNumber());
                return;
            }
            if (command instanceof Run) {
                analysis.rowsWithJumps.add(line.getNumber());
                return;
            }
            if (command instanceof If) {
                analysis.rowsWithJumps.add(line.getNumber());
                return;
            }
            analysis.addCommand(command);
            analysis.checkForJumps(line.getNumber(), command);
        });
    }
}

