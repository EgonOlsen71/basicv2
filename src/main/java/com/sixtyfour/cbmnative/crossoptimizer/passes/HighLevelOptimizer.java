package com.sixtyfour.cbmnative.crossoptimizer.passes;

import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;

public interface HighLevelOptimizer {
    boolean optimize(OrderedPCode orderedPCode);
}
