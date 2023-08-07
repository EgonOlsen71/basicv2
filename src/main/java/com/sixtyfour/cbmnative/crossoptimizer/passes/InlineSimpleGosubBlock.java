package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.elements.commands.Return;
import com.sixtyfour.parser.Line;

import java.util.List;

import static com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities.getLineLastCommand;

/**
 * This transform inlines a Gosub to a line that at the end has a return
 * statement
 */
public class InlineSimpleGosubBlock implements HighLevelOptimizer {

    static boolean containsIf(Line line) {
        If anyIfInTarget = line.getAnyCommand(If.class);
        return (anyIfInTarget != null);
    }

    static int countOfGosub(Line line) {
        return line.countAnyCommandMatching(Gosub.class);

    }

    private static String removeLastCmd(String fullLine) {
        int lastIndex = fullLine.lastIndexOf(":");
        if (lastIndex == -1) {
            return "";
        }
        String bodyWithoutReturn = fullLine.substring(0, lastIndex);
        return bodyWithoutReturn;
    }

    private static String inlineMethodCode(Line line, Line targetLine) {
        String methodBody = removeLastCmd(targetLine.getLine());

        String lineCode = line.getLine();
        String gosubText = "GOSUB" + targetLine.getNumber();
        if (line.getLine().equals(gosubText)) {
            return methodBody;
        }
        lineCode = replaceInlineGosub(methodBody, lineCode, gosubText);
        gosubText = "GOSUB " + targetLine.getNumber();
        if (line.getLine().equals(gosubText)) {
            return methodBody;
        }
        lineCode = replaceInlineGosub(methodBody, lineCode, gosubText);
        return lineCode;
    }

    private static String replaceInlineGosub(String methodBody, String lineCode, String gosubText) {
        lineCode = lineCode.replaceAll(gosubText + ":", methodBody + ":");
        if (lineCode.endsWith(gosubText)) {
            lineCode = lineCode.substring(0, lineCode.length() - gosubText.length());
            lineCode = lineCode + methodBody;
        }
        return lineCode;
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


    private boolean findGosubToInline(OrderedPCode orderedPCode) {
        for (Line l : orderedPCode.getLines()) {
            if (containsIf(l)) {
                continue;
            }
            if (countOfGosub(l) != 1) {
                continue;
            }
            List<Command> commands = l.getCommands();
            int i = commands.size() - 1;
            Command c = commands.get(i);
            if (!(c instanceof Gosub)) {
                continue;
            }
            Gosub gosub = (Gosub) c;
            Line targetLine = orderedPCode.getLine(gosub.getTargetLineNumber());

            if (containsIf(targetLine)) {
                continue;
            }

            Command lastTargetCommand = getLineLastCommand(targetLine);
            if (lastTargetCommand instanceof Return) {
                inlineRow(l, i, targetLine, orderedPCode);
                return true;
            }
        }
        return false;
    }

    private void inlineRow(Line line, int indexGosub, Line targetLine, OrderedPCode orderedPCode) {
        String newLine = inlineMethodCode(line, targetLine);
        Logger.log("Inline final GOSUB line:" + line.getNumber() + " at index: " + indexGosub
                + " and the code looks like this now: " + newLine);

        OrderedPCode newPcode = orderedPCode.cloneInstanceWithLineReplaced(line.getNumber(), newLine);
        orderedPCode.reset(newPcode);
    }
}
