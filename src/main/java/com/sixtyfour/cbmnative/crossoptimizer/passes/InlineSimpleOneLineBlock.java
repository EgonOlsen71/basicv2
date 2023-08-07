package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Goto;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.parser.Line;

import java.util.List;

import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.joinCommands;
import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.splitCommandIntoComponents;
import static com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities.getPreviousToLastCommand;
import static com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities.nextPcodeLine;

/**
 * This transformation will inline a GOTO which returns back to the next line
 * <p>
 * Code transforms from: 10 PRINT "B": GOTO 150 20 ... 50 ....
 * <p>
 * 150 PRINT "A": GOTO 20
 * <p>
 * To:
 * <p>
 * 10 PRINT "B": PRINT "A" 20 ... 50 .... 150 PRINT "A": GOTO 20
 */
public class InlineSimpleOneLineBlock implements HighLevelOptimizer {

    private static Goto getLastCommandAsGoto(Line line) {
        List<Command> cmds = line.getCommands();
        Command last = cmds.get(cmds.size() - 1);
        if (last instanceof Goto)
            return (Goto) last;
        return null;
    }

    public boolean optimize(OrderedPCode orderedPCode) {
        boolean result = false;
        for (Line sourceLine : orderedPCode.getLines()) {
            Goto lineGoto = getLastCommandAsGoto(sourceLine);
            if (lineGoto == null) {
                continue;
            }
            Command previousToLast = getPreviousToLastCommand(sourceLine);
            if (previousToLast instanceof If) {
                continue;
            }
            Line nextSourceLine = nextPcodeLine(orderedPCode, sourceLine);
            if (nextSourceLine == null) {
                continue;
            }
            int nextSourceLineNumber = nextSourceLine.getNumber();
            int currentLineTargetLineNumber = lineGoto.getTargetLineNumber();
            if (currentLineTargetLineNumber != nextSourceLineNumber) {
                continue;
            }
            inlineRow(sourceLine);
            result = true;
        }
        return result;
    }

    private void inlineRow(Line line) {
        List<String> components = splitCommandIntoComponents(line.getLine());
        PCodeUtilities.removeLastLineCommand(line);
        components.remove(components.size() - 1);
        String updatedLine = joinCommands(components);
        line.setLine(updatedLine);

        Logger.log("Remove last Goto that is redundant: " + line.getNumber() + " and the code looks like this now: "
                + line.getLine());
    }
}