package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeVisitor;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Goto;
import com.sixtyfour.parser.Line;

import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;

import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.joinCommands;
import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.splitCommandIntoComponents;
import static com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode.cloneInstanceWithLineReplaced;
import static com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities.*;

public class InlineSimpleGotoBlock implements HighLevelOptimizer {
    public boolean optimize(OrderedPCode orderedPCode) {
        SortedMap<Integer, String> gosubTargets = getAllGoSubTargets(orderedPCode);
        if (gosubTargets.isEmpty()) {
            return false;
        }
        boolean result = false;
        boolean found;
        do {
            found = findLineWithGosubToInline(orderedPCode, gosubTargets);
            result |= found;
        } while (found);
        return result;
    }


    SortedMap<Integer, String> getAllGoSubTargets(OrderedPCode orderedPCode) {
        SortedMap<Integer, String> result = new TreeMap<>();
        PCodeVisitor.accept(orderedPCode, (line, command, index) -> {
            getCandidateGotoToMapping(orderedPCode, result, command);
        });

        return result;
    }

    private static void getCandidateGotoToMapping(OrderedPCode orderedPCode, SortedMap<Integer, String> result, Command command) {
        if (!command.isCommand("GOTO")) {
            return;
        }
        Goto gosub = (Goto) command;
        int gosubTargetLineNumber = gosub.getTargetLineNumber();
        if (result.containsKey(gosubTargetLineNumber)) {
            return;
        }

        Line targetLine = orderedPCode.getLine(gosubTargetLineNumber);

        Command lastTargetCommand = getLineLastCommand(targetLine);

        if (containsIf(targetLine)) {
            return;
        }
        if (lastTargetCommand instanceof Goto) {
            result.put(gosubTargetLineNumber, targetLine.getLine());
        }
    }


    private boolean findLineWithGosubToInline(OrderedPCode orderedPCode, SortedMap<Integer, String> gosubTargets) {
        for (Line l : orderedPCode.getLines()) {
            if (containsIf(l)) {
                continue;
            }
            List<Command> commands = l.getCommands();
            for (int i = 0; i < commands.size(); i++) {
                Command command = commands.get(i);
                if (!command.isCommand("GOTO")) {
                    continue;
                }
                Goto aGoto = (Goto) command;
                int gosubTargetLineNumber = aGoto.getTargetLineNumber();
                if (!gosubTargets.containsKey(gosubTargetLineNumber)) {
                    continue;
                }
                if (gosubTargetLineNumber == l.getNumber()) {
                    continue;
                }
                inlineGotoCommand(orderedPCode, l.getNumber(), i, gosubTargets, gosubTargetLineNumber);
                return true;
            }
        }
        return false;
    }

    private void inlineGotoCommand(OrderedPCode orderedPCode, int lineNumber, int indexCommand, SortedMap<Integer, String> gotoTargets, int gotoLineNumber) {
        Line line = orderedPCode.getLine(lineNumber);
        String lineCode = line.getLine();
        String gotoCodeLine = gotoTargets.get(gotoLineNumber);
        List<String> lineComponents = splitCommandIntoComponents(lineCode);
        lineComponents.remove(indexCommand);
        lineComponents.add(indexCommand, gotoCodeLine);
        String finalCode = joinCommands(lineComponents);
        orderedPCode.reset(cloneInstanceWithLineReplaced(orderedPCode, line.getNumber(), finalCode));

        Logger.log("After inline GOTO, code is changed from: \n" + lineNumber + " " + lineCode + "\n to: " + lineNumber + " " + finalCode + ".");
    }
}
