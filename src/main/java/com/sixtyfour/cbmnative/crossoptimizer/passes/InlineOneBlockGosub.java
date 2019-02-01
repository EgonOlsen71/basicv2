package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.PCodeOptimizer;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeVisitor;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.Goto;
import com.sixtyfour.elements.commands.Return;
import com.sixtyfour.parser.Line;

import java.util.*;


/**
 * This code transform makes the following transformation if gosub to N is unique:
 *
 * L: gosub N
 * L+1: ...
 * (...)
 * N: ...
 * return
 *
 * Code is transformed to:
 *
 * L: goto N
 * L+1: ...
 * (...)
 * N: (...)
 * goto L+1
 *
 *
 */
public class InlineOneBlockGosub implements HighLevelOptimizer {

    private void addCount(Map<Integer, Integer> countedGoSubs, int targetLine) {
        Integer getTargetCount = countedGoSubs.get(targetLine);
        if (getTargetCount == null) {
            countedGoSubs.put(targetLine, 1);
        } else {
            countedGoSubs.put(targetLine, 1 + getTargetCount);
        }
    }

    public boolean optimize(OrderedPCode orderedPCode) {
        List<Integer> linesWithSingleGosub = getInlinableGosubs(orderedPCode);

        for (int lineWithGosub : linesWithSingleGosub) {
            Line line = orderedPCode.getLine(lineWithGosub);
            Gosub gosub = line.getFirstCommand();
            Goto replaceGoto = new Goto();
            replaceGoto.setTargetLineNumber(gosub.getTargetLineNumber());
            PCodeOptimizer.replaceLastCommandInLine(line, replaceGoto, "goto "+gosub.getTargetLineNumber());
            int targetGosubStart = orderedPCode.getLineIndex(gosub.getTargetLineNumber());
            for (int targetReturn = targetGosubStart; ; targetReturn++) {
                Line candidateReturnLine = orderedPCode.getLineDirect(targetReturn);
                Return retCommand = candidateReturnLine.getAnyCommand(Return.class);
                if (retCommand == null)
                    continue;
                InlineCall(orderedPCode, lineWithGosub, gosub, candidateReturnLine);


                break;
            }
        }
        final int countReplacements = linesWithSingleGosub.size();
        if (countReplacements > 0) {
            Logger.log("Inline gosub count: " + countReplacements);
        }
        return countReplacements != 0;
    }

    private void InlineCall(OrderedPCode orderedPCode, int lineWithGosub, Gosub gosub, Line returnLine) {
        int gosubIndex = orderedPCode.getLineIndex(lineWithGosub);
        Goto gotoNext = new Goto();
        int nextLineIndex = orderedPCode.getLineDirect(gosubIndex + 1).getNumber();
        gotoNext.setTargetLineNumber(nextLineIndex);
        PCodeOptimizer.replaceLastCommandInLine(returnLine, gotoNext, "goto "+nextLineIndex);

        Logger.log(lineWithGosub+": GOSUB " + gosub.getTargetLineNumber() + "' is converted to 'Goto' and method is inlined from range: (" + gosub.getTargetLineNumber() + ".."
                + returnLine.getNumber() + ")");
    }

    private List<Integer> getInlinableGosubs(OrderedPCode orderedPCode) {
        Map<Integer, Integer> countedGoSubs = new HashMap<>();
        Set<Integer> excludedCandidates = new HashSet<>();
        List<Integer> linesWithSingleGoSub = new ArrayList<>();
        PCodeVisitor pCodeVisitor = new PCodeVisitor(orderedPCode);
        PCodeVisitor.IVisitor visitor = (Line l, Command command, int idx) -> {
            Gosub gosub = (Gosub) command;
            int target = gosub.getTargetLineNumber();

            addCount(countedGoSubs, target);
            if (l.getCommands().size() != 1) {
                excludedCandidates.add(target);
            } else {
                linesWithSingleGoSub.add(l.getNumber());
            }
        };
        pCodeVisitor.accept("gosub", visitor);
        List<Integer> singleGosubs = new ArrayList<>();
        for (int lineIndex : linesWithSingleGoSub) {
            Line line = orderedPCode.getLine(lineIndex);
            Gosub gosub = line.getFirstCommand();
            int gosubTarget = gosub.getTargetLineNumber();
            int gosubCount = countedGoSubs.get(gosubTarget);
            if (gosubCount != 1)
                continue;
            if (excludedCandidates.contains(gosubTarget))
                continue;
            singleGosubs.add(lineIndex);
        }
        return singleGosubs;
    }
}
