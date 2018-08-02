package com.sixtyfour.cbmnative.javascript;

import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;

public class PlatformJs implements PlatformProvider {

    @Override
    public int getStackSize() {
	return 100;
    }

    @Override
    public int getForStackSize() {
	return 100;
    }

    @Override
    public Optimizer getOptimizer() {
	return null;
    }

    @Override
    public Transformer getTransformer() {
	return new TransformerJs();
    }

    @Override
    public Unlinker getUnlinker() {
	return null;
    }

    @Override
    public boolean useLooseTypes() {
	return true;
    }

}
