package com.sixtyfour.cbmnative.javascript;

import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;

/**
 * A PlatformProvider implementation for the Javascript target platform.
 * 
 * @author EgonOlsen
 *
 */
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
	return new OptimizerJs();
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

    @Override
    public int getMaxHeaderAddress() {
	return 0;
    }

    @Override
    public int getBaseAddress() {
	return 0;
    }

}
