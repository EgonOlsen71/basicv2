package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.elements.commands.*;
import com.sixtyfour.parser.Line;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * This transform inlines a Gosub to a line that at the end has a return statement
 */
public class InlineSimpleGosubBlock implements HighLevelOptimizer {

    boolean findGosubToInline(OrderedPCode orderedPCode) {
        for (Line l : orderedPCode.getLines()) {
            List<Command> commands = l.getCommands();
            if (l.getAnyCommand(If.class) != null)
                continue;
            for (int i = 0; i < commands.size(); i++) {
                Command c = commands.get(i);
                if (!(c instanceof Gosub)) {
                    continue;
                }
                Gosub gosub = (Gosub) c;
                Line targetLine = orderedPCode.getLine(gosub.getTargetLineNumber());
                List<Command> targetCommands = targetLine.getCommands();
                Command lastTargetCommand = targetCommands.get(targetCommands.size() - 1);
                if (lastTargetCommand instanceof Return) {
                    inlineRow(l, i, targetLine, orderedPCode);
                    return true;
                }
            }
        }
        return false;

    }

    public boolean optimize(OrderedPCode orderedPCode) {
        boolean result = false;
        boolean found;
        do {
            found = findGosubToInline(orderedPCode);
            result |= found;
        } while (found);
        return result;
    }


    public String joinStrings(List<String> items, String delimiter) {
        final String result = items.stream()
                .collect(Collectors.joining(delimiter));
        return result;
    }

    private List<String> getCommandItemsAsStrings(Line line) {
        String[] parts = line.getLine().split(":");
        List<String> partsList = new ArrayList<>();
        partsList.addAll(Arrays.stream(parts).collect(Collectors.toList()));
        return partsList;
    }

    private void inlineRow(Line line, int indexGosub, Line targetLine, OrderedPCode orderedPCode) {
        Logger.log("Inline final GOSUB line:" + line.getNumber() + " at index: " + indexGosub + " and the code looks like this now: " +
                line.getLine());
        List<String> finalParts = extractParts(line, indexGosub, targetLine);
        String newLine = joinStrings(finalParts, ":");

        OrderedPCode newPcode = orderedPCode.cloneInstanceWithLineReplaced(line.getNumber(), newLine);
        orderedPCode.reset(newPcode);
    }

    private List<String> extractParts(Line line, int indexGosub, Line targetLine) {
        List<String> lineParts = getCommandItemsAsStrings(line);
        List<String> targetParts = getCommandItemsAsStrings(targetLine);
        targetParts.remove(targetParts.size() - 1);
        List<String> finalParts = new ArrayList<>();
        for (int i = 0; i < indexGosub; i++) {
            finalParts.add(lineParts.get(i));
        }
        finalParts.addAll(targetParts);
        lineParts.remove(indexGosub);
        for (int i = indexGosub; i < lineParts.size(); i++) {
            finalParts.add(lineParts.get(i));
        }

        return finalParts;
    }

    private Goto getLastCommandAsGoto(Line line) {
        List<Command> cmds = line.getCommands();
        Command last = cmds.get(cmds.size() - 1);
        if (last instanceof Gosub)
            return (Goto) last;
        return null;
    }
}
