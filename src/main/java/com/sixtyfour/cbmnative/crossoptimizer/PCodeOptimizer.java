package com.sixtyfour.cbmnative.crossoptimizer;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.passes.GenerateBasicBlocks;
import com.sixtyfour.cbmnative.crossoptimizer.passes.HighLevelOptimizer;
import com.sixtyfour.cbmnative.crossoptimizer.passes.InlineSimpleGotoBlock;
import com.sixtyfour.cbmnative.crossoptimizer.passes.InlineSimpleOneLineBlock;
import com.sixtyfour.cbmnative.crossoptimizer.passes.gosub.InlineOneBlockGosub;
import com.sixtyfour.cbmnative.crossoptimizer.passes.gosub.InlineSimpleGosubBlock;
import com.sixtyfour.cbmnative.crossoptimizer.passes.lineconstantpropagator.PCodeConstantPropagator;
import com.sixtyfour.parser.Line;

import java.util.ArrayList;
import java.util.List;

public class PCodeOptimizer {

    private final static List<HighLevelOptimizer> Optimizers = new ArrayList<>();
    static boolean DEBUG_PCODE_OPTIMIZER = true;

    public static void setup(String optionFlags) {
    	Optimizers.clear();
    	if (optionFlags==null || optionFlags.isBlank()) {
    		return;
    	}
        boolean goSubOptimizations = true;
        List<String> flagList = CommandsRowSplitter.splitCommandIntoComponents(optionFlags);
        if (flagList.contains("no:gosub")) {
            goSubOptimizations = false;
        }
        if (optionFlags.equals("off") || optionFlags.equals("")) {
            return;
        }
        Optimizers.add(new GenerateBasicBlocks());
        if (goSubOptimizations) {
            Optimizers.add(new InlineOneBlockGosub());
            Optimizers.add(new InlineSimpleGosubBlock());
        }
        Optimizers.add(new InlineSimpleOneLineBlock());
        Optimizers.add(new InlineSimpleGotoBlock());
        Optimizers.add(new PCodeConstantPropagator());
    }

    public static boolean optimize(PCode pCode) {
    	if (Optimizers.isEmpty()) {
    		return true;
    	}
        OrderedPCode orderedPCode = new OrderedPCode(pCode);

        String originalCode = orderedPCode.getCode();
        boolean result = false;
        boolean found;
        do {
            found = false;
            for (HighLevelOptimizer optimizer : Optimizers) {
                found |= optimizer.optimize(orderedPCode);
                result |= found;

            }
        } while (found);
        if (result) {
            updatePcode(pCode, orderedPCode);
            if (DEBUG_PCODE_OPTIMIZER) {
                String fullCode = orderedPCode.getCode();
                Logger.log("Code before PCode optimizations: \n" + originalCode);

                Logger.log("Code after PCode optimizations: \n" + fullCode);
            }
        }
        return result;
    }

    private static void updatePcode(PCode pCode, OrderedPCode orderedPCode) {
        pCode.getLines().clear();
        pCode.getLineNumbers().clear();
        for (Line line : orderedPCode.getLines()) {
            pCode.getLineNumbers().add(line.getNumber());
            pCode.getLines().put(line.getNumber(), line);
        }
    }
}
