package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Basic;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Goto;
import com.sixtyfour.parser.Line;

import java.util.List;

public class InlineSimpleOneLineBlock {
    private static void removeLastLineCommand(Line line) {
        String str = line.getLine();
        int index = str.lastIndexOf(':');
        line.getCommands().remove(line.getCommands().size() - 1);
        if (index == -1) {
            line.setLine("");
            return;
        }
        line.setLine(str.substring(0, index - 1));
    }

    private static Line cloneLine(OrderedPCode orderedPCode, int line) {
        Basic basic = new Basic(orderedPCode.getCode());
        basic.compile(new CompilerConfig());
        Line resultLine = basic.getPCode().getLines().get(line);
        return resultLine;
    }

    public boolean optimize(OrderedPCode orderedPCode) {
        boolean result = false;
        List<Line> lines = orderedPCode.getLines();
        for (int i = 0, linesSize = lines.size() - 1; i < linesSize; i++) {
            Line line = lines.get(i);
            int nextLineIndex = lines.get(i + 1).getNumber();
            Goto lineGoto = getLastCommandAsGoto(line);
            if (lineGoto == null)
                continue;
            if (lineGoto.getTargetLineNumber() == line.getNumber())
                continue;
            Line targetLine = orderedPCode.getLine(lineGoto.getTargetLineNumber());
            Goto targetGoto = getLastCommandAsGoto(targetLine);
            if (targetGoto == null)
                continue;
            if (targetGoto.getTargetLineNumber() != nextLineIndex)
                continue;
            inlineRow(line, targetLine, orderedPCode);
            result = true;

        }
        return result;
    }

    private void inlineRow(Line line, Line targetLine, OrderedPCode orderedPCode) {
        Line cloneLine = cloneLine(orderedPCode, targetLine.getNumber());
        List<Command> clonedCommands = cloneLine.getCommands();
        removeLastLineCommand(cloneLine);

        if (!line.getLine().contains(":")) {
            line.setLine(cloneLine.getLine());
        } else {
            removeLastLineCommand(line);
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
        if (last instanceof Goto)
            return (Goto) last;
        return null;
    }
}