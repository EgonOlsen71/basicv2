package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.parser.Line;

import java.util.List;

import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.joinCommands;
import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.splitCommandIntoComponents;

public class PCodeUtilities {
    public static void removeLastLineCommand(Line line) {
        String str = line.getLine();
        int index = str.lastIndexOf(':');
        line.getCommands().remove(line.getCommands().size() - 1);
        if (index == -1) {
            line.setLine("");
            return;
        }
        line.setLine(str.substring(0, index - 1));
    }

    public static Command getLineLastCommand(Line line) {
        List<Command> commands = line.getCommands();
        return commands.get(commands.size() - 1);
    }

    public static Command getPreviousToLastCommand(Line line) {
        List<Command> commands = line.getCommands();
        if (commands.size() == 1) {
            return null;
        }
        return commands.get(commands.size() - 2);
    }

    public static void replaceLastCommandInLine(Line line, Command command) {
        List<Command> originalRowCommands = line.getCommands();
        int lastIndex = originalRowCommands.size() - 1;
        originalRowCommands.set(lastIndex, command);
    }

    public static void replaceCommandStringComponent(Line line, int indexCommand, String newString) {
        List<String> sourceLineTextComponents = splitCommandIntoComponents(line.getLine());
        sourceLineTextComponents.set(indexCommand, newString);
        String updatedLineCommand = joinCommands(sourceLineTextComponents);
        line.setLine(updatedLineCommand);
    }

    public static boolean containsIf(Line line) {
        If anyIfInTarget = line.getAnyCommand(If.class);
        return (anyIfInTarget != null);
    }

    public static int countOfGosub(Line line) {
        return line.countAnyCommandMatching(Gosub.class);
    }

    public static Line nextPcodeLine(OrderedPCode pCode, Line currentLine) {
        int currentLineNumber = currentLine.getNumber();
        int currentLineIndex = pCode.getLineIndex(currentLineNumber);
        if (currentLineIndex == pCode.getLines().size() - 1) {
            return null;
        }
        return pCode.getLineDirect(currentLineIndex + 1);
    }
}
