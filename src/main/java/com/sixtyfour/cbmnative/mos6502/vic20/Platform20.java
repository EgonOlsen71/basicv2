package com.sixtyfour.cbmnative.mos6502.vic20;

import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;
import com.sixtyfour.cbmnative.mos6502.Optimizer6502;
import com.sixtyfour.cbmnative.mos6502.Unlinker6502;

/**
 * A PlatformProvider implementation for the VIC20 target platform.
 * 
 * @author EgonOlsen
 *
 */
public class Platform20 implements PlatformProvider {

	@Override
	public int getStackSize() {
		return 10;
	}

	@Override
	public int getForStackSize() {
		return 10;
	}

	@Override
	public Optimizer getOptimizer() {
		return new Optimizer6502();
	}

	@Override
	public Transformer getTransformer() {
		return new Transformer20();
	}

	@Override
	public Unlinker getUnlinker() {
		return new Unlinker6502();
	}

	@Override
	public boolean useLooseTypes() {
		return true;
	}

	@Override
	public int getMaxHeaderAddress() {
	    return 4660;
	}

	@Override
	public int getBaseAddress() {
	    return 4609;
	}
}
