package com.sixtyfour.cbmnative.crossoptimizer.passes.gosub;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeVisitor;
import com.sixtyfour.cbmnative.crossoptimizer.passes.HighLevelOptimizer;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.Return;
import com.sixtyfour.parser.Line;

import java.util.*;

import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.joinCommands;
import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.splitCommandIntoComponents;
import static com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities.*;

/**
 * This transform inlines a Gosub to a line that at the end has a return
 * statement
 */
public class InlineSimpleGosubBlock implements HighLevelOptimizer {

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

    private static void getCandidateGosubToMapping(OrderedPCode orderedPCode, SortedMap<Integer, String> result, Line line, Command command, SortedSet<Integer> invalidTargetRows) {
        if (!command.isCommand("GOSUB")) {
            return;
        }
        Gosub gosub = (Gosub) command;
        int gosubTargetLineNumber = gosub.getTargetLineNumber();
        if (invalidTargetRows.contains(gosubTargetLineNumber)) {
            return;
        }
        if (result.containsKey(gosubTargetLineNumber)) {
            return;
        }

        Line targetLine = orderedPCode.getLine(gosubTargetLineNumber);

        Command lastTargetCommand = getLineLastCommand(targetLine);

        if (containsIf(targetLine)) {
            invalidTargetRows.add(gosubTargetLineNumber);
            return;
        }
        if (targetLine.countAnyCommandMatching(Gosub.class) > 0) {
            invalidTargetRows.add(gosubTargetLineNumber);
            return;
        }
        if (lastTargetCommand instanceof Return) {
            List<String> lineComponents = splitCommandIntoComponents(targetLine.getLine());
            lineComponents.remove(lineComponents.size() - 1);
            String goSubInlineMethodCode = joinCommands(lineComponents);
            result.put(gosubTargetLineNumber, goSubInlineMethodCode);
        }
    }
    SortedMap<Integer, String> getAllGoSubTargets(OrderedPCode orderedPCode) {
        SortedMap<Integer, String> result = new TreeMap<>();
        SortedSet<Integer> invalidTargetRows = new TreeSet<>();
        PCodeVisitor.accept(orderedPCode, (line, command, index) -> {
            getCandidateGosubToMapping(orderedPCode, result, line, command, invalidTargetRows);

        });

        return result;
    }

    private boolean findLineWithGosubToInline(OrderedPCode orderedPCode, SortedMap<Integer, String> gosubTargets) {

        for (Line l : orderedPCode.getLines()) {
            if (containsIf(l)) {
                continue;
            }
            if (countOfGosub(l) == 0) {
                continue;
            }
            List<Command> commands = l.getCommands();
            for (int i = 0; i < commands.size(); i++) {
                Command command = commands.get(i);
                if (!command.isCommand("GOSUB")) {
                    continue;
                }
                Gosub gosub = (Gosub) command;
                int gosubTargetLineNumber = gosub.getTargetLineNumber();
                if (!gosubTargets.containsKey(gosubTargetLineNumber)) {
                    continue;
                }
                inlineGoSubCommand(orderedPCode, l.getNumber(), i, gosubTargets, gosubTargetLineNumber);
                return true;
            }
        }
        return false;
    }

    private void inlineGoSubCommand(OrderedPCode orderedPCode, int lineNumber, int indexCommand, SortedMap<Integer, String> gosubTargets, int gosubTargetLineNumber) {
        Line line = orderedPCode.getLine(lineNumber);
        String lineCode = line.getLine();
        String goSubLineCode = gosubTargets.get(gosubTargetLineNumber);
        List<String> lineComponents = splitCommandIntoComponents(lineCode);
        lineComponents.remove(indexCommand);
        lineComponents.add(indexCommand, goSubLineCode);
        String finalCode = joinCommands(lineComponents);
        orderedPCode.reset(replaceLineInCode(orderedPCode, line.getNumber(), finalCode));

        Logger.log("After inline Gosub, code is changed from: \n" + lineNumber + " " + lineCode + "\n to: " + lineNumber + " " + finalCode + ".");
    }
}
