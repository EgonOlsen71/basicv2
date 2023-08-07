package com.sixtyfour.cbmnative.crossoptimizer.passes.gosub;

import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeVisitor;
import com.sixtyfour.cbmnative.crossoptimizer.passes.HighLevelOptimizer;
import com.sixtyfour.elements.commands.*;
import com.sixtyfour.parser.Line;

import java.util.*;

import static com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities.*;

/**
 * This code transform makes the following transformation if gosub to N is
 * unique:
 * <p>
 * L: gosub N L+1: ... (...) N: ... return
 * <p>
 * Code is transformed to:
 * <p>
 * L: goto N L+1: ... (...) N: (...) goto L+1
 */
public class InlineOneBlockGosub implements HighLevelOptimizer {
    public boolean optimize(OrderedPCode orderedPCode) {
        SortedSet<Integer> gosubTargets = getGosubTargets(orderedPCode);
        SortedMap<Integer, Integer> linesEndingWithGoSub = getLinesEndingWithGoSub(orderedPCode, gosubTargets);
        if (linesEndingWithGoSub.isEmpty()) {
            return false;
        }
        boolean result = false;
        SortedSet<Integer> targetGoSubCandidates = calculateGoSubTargets(orderedPCode);
        for (int lineIndex : linesEndingWithGoSub.keySet()) {
            int targetGoSub = linesEndingWithGoSub.get(lineIndex);
            if (targetGoSubCandidates.contains(targetGoSub)) {
                replaceGoSubToGotoCall(orderedPCode, lineIndex, targetGoSub);
                result = true;
            }
        }

        return result;
    }

    private SortedSet<Integer> getGosubTargets(OrderedPCode orderedPCode) {
        SortedSet<Integer> result = new TreeSet<>();
        PCodeVisitor.accept(orderedPCode, (line, cmd, index)->{
            if (!cmd.getName().equals("GOSUB")){
                return;
            }
            Gosub gosub = (Gosub) cmd;
            result.add(gosub.getTargetLineNumber());
        });
        return result;
    }


    private static void updateCountOfGoSub(Map<Integer, Integer> result, Gosub gosub) {
        int targetGoSub = gosub.getTargetLineNumber();
        int alreadyTargeted = result.getOrDefault(targetGoSub, 0);
        result.put(targetGoSub, alreadyTargeted + 1);
    }

    private static void replaceGoSubToGotoCall(OrderedPCode orderedPCode, int lineIndex, int targetGoSub) {
        Line sourceLine = orderedPCode.getLine(lineIndex);
        Line nextSourceLine = nextPcodeLine(orderedPCode, sourceLine);
        int nextLineNumber = nextSourceLine.getNumber();

        Line goSubLine = orderedPCode.getLine(targetGoSub);

        replaceLastCommandInLine(sourceLine, new Goto(targetGoSub));
        replaceCommandStringComponent(sourceLine, sourceLine.getCommands().size() - 1, "GOTO " + targetGoSub);

        replaceLastCommandInLine(goSubLine, new Goto(nextLineNumber));
        replaceCommandStringComponent(goSubLine, goSubLine.getCommands().size() - 1, "GOTO " + nextLineNumber);
    }
    boolean targetGoSubLineCanBePassTrough(OrderedPCode pCode, int targetLine) {
        int lineIndex = pCode.getLineIndex(targetLine);

        Line prevLine = pCode.getLineDirect(lineIndex-1);
        if (prevLine.getAnyCommand(If.class) != null){
            return true;
        }
        Command lastCommand = getLineLastCommand(prevLine);
        switch (lastCommand.getName()){
            case "GOTO":
            case "RUN":
            case "RETURN":
                return false;
            case "END":
                return false;

            default:
                return true;
        }
    }
    SortedMap<Integer, Integer> getLinesEndingWithGoSub(OrderedPCode orderedPCode, SortedSet<Integer> gosubTargets) {
        SortedMap<Integer, Integer> result = new TreeMap<>();
        for (Line l : orderedPCode.getLines()) {

            if (containsIf(l)) {
                continue;
            }
            Command c = getLineLastCommand(l);
            if (!(c instanceof Gosub)) {
                continue;
            }
            if (gosubTargets.contains(l.getNumber())){
                continue;
            }
            if (countOfGosub(l) != 1) {
                continue;
            }

            Command previousToLastCommand = getPreviousToLastCommand(l);
            if (previousToLastCommand instanceof If) {
                continue;
            }

            Gosub gosub = (Gosub) c;
            int goSubTarget = gosub.getTargetLineNumber();
            Line goSubLine = orderedPCode.getLine(goSubTarget);
            Command goSubLastCommand = getLineLastCommand(goSubLine);
            if (!(goSubLastCommand instanceof Return)) {
                continue;
            }
            if (goSubLine.countAnyCommandMatching(If.class)>0){
                continue;
            }
            if (goSubLine.countAnyCommandMatching(Gosub.class)>0){
                continue;
            }
            if (targetGoSubLineCanBePassTrough(orderedPCode, goSubTarget)){
                continue;
            }

            result.put(l.getNumber(), goSubTarget);
        }
        return result;
    }

    SortedSet<Integer> calculateGoSubTargets(OrderedPCode orderedPCode) {
        Map<Integer, Integer> result = new TreeMap<>();
        orderedPCode.getLines()
                .forEach(l -> {
                    l.getCommands().forEach(c -> {
                        if (!(c instanceof Gosub)) {
                            return;
                        }
                        Gosub gosub = (Gosub) c;
                        updateCountOfGoSub(result, gosub);
                    });
                });

        SortedSet<Integer> resultSet = new TreeSet<>();
        result.keySet()
                .forEach(goSubTarget -> {
                    int targets = result.get(goSubTarget);
                    Line gosubLine = orderedPCode.getLine(goSubTarget);
                    if (containsIf(gosubLine)) {
                        //fixed bug seen in Expresso.bas
                        return;
                    }
                    if (targets == 1) {
                        resultSet.add(goSubTarget);
                    }
                });

        return resultSet;
    }


}
