package com.sixtyfour.cbmnative.powerscript;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;
import com.sixtyfour.config.CompilerConfig;

/**
 * A PlatformProvider implementation for the Powerscript target platform.
 * 
 * @author EgonOlsen
 *
 */
public class PlatformPs implements PlatformProvider {

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
		return new OptimizerPs();
	}

	@Override
	public Transformer getTransformer() {
		return new TransformerPs();
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

	@Override
	public void overrideConfig(CompilerConfig conf) {
		conf.setLoopOptimizations(false);
		conf.setIntOptimizations(false);
		conf.setShiftOptimizations(false);
	}

	@Override
	public Generator getGenerator(String orgLine) {
		return null;
	}

	@Override
	public int getBasicMemoryEndAddress() {
		return 0;
	}

	@Override
	public int getBasicBufferAddress() {
		return 0;
	}

	@Override
	public boolean supportsCompression() {
		return false;
	}

	@Override
	public boolean supportsBigRam() {
		return false;
	}

}
