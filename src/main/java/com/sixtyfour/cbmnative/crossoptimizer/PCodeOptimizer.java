package com.sixtyfour.cbmnative.crossoptimizer;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.passes.*;
import com.sixtyfour.cbmnative.crossoptimizer.passes.gosub.InlineOneBlockGosub;
import com.sixtyfour.cbmnative.crossoptimizer.passes.gosub.InlineSimpleGosubBlock;
import com.sixtyfour.parser.Line;

import java.util.ArrayList;
import java.util.List;

public class PCodeOptimizer {

	private final static List<HighLevelOptimizer> Optimizers = new ArrayList<>();

	public static void setup(boolean goSubOptimizations) {
		Optimizers.clear();
		Optimizers.add(new GenerateBasicBlocks());
		if (goSubOptimizations) {
			Optimizers.add(new InlineOneBlockGosub());
			Optimizers.add(new InlineSimpleGosubBlock());
		}
		Optimizers.add(new InlineSimpleOneLineBlock());
		Optimizers.add(new InlineSimpleGotoBlock());
	}
	static boolean DEBUG_PCODE_OPTIMIZER = true;

	public static boolean optimize(PCode pCode) {
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
