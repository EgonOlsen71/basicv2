package com.sixtyfour.cbmnative.crossoptimizer;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.passes.GenerateBasicBlocks;
import com.sixtyfour.cbmnative.crossoptimizer.passes.InlineOneBlockGosub;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.parser.Line;

import java.util.List;
import java.util.stream.Collectors;

public class PCodeOptimizer {

    public static void replaceLastCommandInLine(Line line, Command command, String code) {
        List<Command> originalRowCommands = line.getCommands();
        int lastIndex = originalRowCommands.size()-1;
        originalRowCommands.set(lastIndex, command);
        line.setLine(code);
    }

    static boolean DEBUG_PCODE_OPTIMIZER = true;

    public static boolean optimize(PCode pCode) {
        OrderedPCode orderedPCode = new OrderedPCode(pCode);
        boolean result = false;
        InlineOneBlockGosub onlyOneMethodCallInliner = new InlineOneBlockGosub();
        result |= onlyOneMethodCallInliner.optimize(orderedPCode);
        if (result) {
            updatePcode(pCode, orderedPCode);
        }
        GenerateBasicBlocks generateBasicBlocks = new GenerateBasicBlocks();
        result |= generateBasicBlocks.optimize(orderedPCode);

        if (DEBUG_PCODE_OPTIMIZER) {
            String fullCode = orderedPCode.getLines().stream()
                    .map(line -> line.getNumber() + " " + line.getLine())
                    .collect(Collectors.joining("\n"));
            Logger.log(fullCode);
        }

        return result;
    }

    private static void updatePcode(PCode pCode, OrderedPCode orderedPCode) {
        pCode.getLines().clear();
        pCode.getLineNumbers().clear();
        for(Line line: orderedPCode.getLines()){
            pCode.getLineNumbers().add(line.getNumber());
            pCode.getLines().put(line.getNumber(), line);
        }
    }
}
