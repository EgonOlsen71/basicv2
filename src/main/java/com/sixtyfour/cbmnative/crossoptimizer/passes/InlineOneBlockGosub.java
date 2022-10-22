package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
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
        SortedMap<Integer, Integer> linesEndingWithGoSub = getLinesEndingWithGoSub(orderedPCode);
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

    SortedMap<Integer, Integer> getLinesEndingWithGoSub(OrderedPCode orderedPCode) {
        SortedMap<Integer, Integer> result = new TreeMap<>();
        for (Line l : orderedPCode.getLines()) {
            if (containsIf(l)) {
                continue;
            }
            Command c = getLineLastCommand(l);
            if (!(c instanceof Gosub)) {
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
            Command prevToLastGoSubCommand = getPreviousToLastCommand(goSubLine);
            if (prevToLastGoSubCommand instanceof If) {
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
                    if (targets == 1) {
                        resultSet.add(goSubTarget);
                    }
                });
        return resultSet;
    }


}
