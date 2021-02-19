package com.sixtyfour.cbmnative.mos6502.c64;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;
import com.sixtyfour.cbmnative.mos6502.Optimizer6502;
import com.sixtyfour.cbmnative.mos6502.Unlinker6502;
import com.sixtyfour.config.CompilerConfig;

/**
 * A PlatformProvider implementation for the C64 target platform.
 * 
 * @author EgonOlsen
 *
 */
public class Platform64 implements PlatformProvider {

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
		return new Transformer64();
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
	public int getBasicMemoryEndAddress() {
		return 40959;
	}

	@Override
	public void overrideConfig(CompilerConfig conf) {
		// TODO Auto-generated method stub

	}

	@Override
	public Generator getGenerator(String orgLine) {
		return null;
	}
	
	@Override
	public int getBasicBufferAddress() {
		return 820;
	}
	
	@Override
	public boolean supportsCompression() {
		return true;
	}
	
	@Override
	public boolean supportsBigRam() {
		return true;
	}
}
