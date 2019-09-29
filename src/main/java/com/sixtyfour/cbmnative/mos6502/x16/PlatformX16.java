package com.sixtyfour.cbmnative.mos6502.x16;

import com.sixtyfour.Basic;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;
import com.sixtyfour.cbmnative.mos6502.Optimizer6502;
import com.sixtyfour.cbmnative.mos6502.Unlinker6502;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.extensions.x16.X16Extensions;

/**
 * A PlatformProvider implementation for the C64 target platform.
 * 
 * @author EgonOlsen
 *
 */
public class PlatformX16 implements PlatformProvider {

	@Override
	public int getStackSize() {
		return 20;
	}

	@Override
	public int getForStackSize() {
		return 20;
	}

	@Override
	public Optimizer getOptimizer() {
		return new Optimizer6502();
	}

	@Override
	public Transformer getTransformer() {
		return new TransformerX16();
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
		return 2100;
	}

	@Override
	public int getBaseAddress() {
		return 2049;
	}

	@Override
	public void overrideConfig(CompilerConfig conf) {
		conf.setNonDecimalNumbersAware(true);
		conf.setExtendedLoad(true);
		Basic.registerExtension(new X16Extensions());
	}
}
