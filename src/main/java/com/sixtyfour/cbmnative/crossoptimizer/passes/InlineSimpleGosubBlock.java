package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeVisitor;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.Goto;
import com.sixtyfour.parser.Line;

import java.util.List;

public class InlineSimpleGosubBlock implements HighLevelOptimizer {

    public boolean optimize(OrderedPCode orderedPCode) {
        boolean result = false;
        PCodeVisitor pCodeVisitor = new PCodeVisitor(orderedPCode);
        pCodeVisitor.accept((l, c, i) -> {

        });
        return result;
    }

    private void inlineRow(Line line, Line targetLine, OrderedPCode orderedPCode) {
        Line cloneLine = PCodeUtilities.cloneLine(orderedPCode, targetLine.getNumber());
        List<Command> clonedCommands = cloneLine.getCommands();
        PCodeUtilities.removeLastLineCommand(cloneLine);

        if (!line.getLine().contains(":")) {
            line.setLine(cloneLine.getLine());
        } else {
            PCodeUtilities.removeLastLineCommand(line);
            String injectedInlinedCode = line.getLine() + ":" + cloneLine.getLine();
            line.setLine(injectedInlinedCode);
        }

        line.getCommands().addAll(clonedCommands);
        Logger.log("Inline final goto of line: " + line.getNumber() + " and the code looks like this now: " +
                line.getLine());
    }

    private Goto getLastCommandAsGoto(Line line) {
        List<Command> cmds = line.getCommands();
        Command last = cmds.get(cmds.size() - 1);
        if (last instanceof Gosub)
            return (Goto) last;
        return null;
    }
}
