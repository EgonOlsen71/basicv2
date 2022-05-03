package com.sixtyfour.cbmnative.mos6502.vic20;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;
import com.sixtyfour.cbmnative.mos6502.Optimizer6502;
import com.sixtyfour.cbmnative.mos6502.Unlinker6502;
import com.sixtyfour.config.CompilerConfig;

/**
 * A PlatformProvider implementation for the VIC20 target platform.
 * 
 * @author EgonOlsen
 *
 */
public class Platform20 implements PlatformProvider {

	private int maxHeaderAddr = 4660;
	private int baseAddr = 4609;
	private int basicEnd = 32767;

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
		Transformer trans = new Transformer20();
		trans.setStartAddress(baseAddr + 23);
		return trans;
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
		return maxHeaderAddr;
	}

	@Override
	public int getBaseAddress() {
		return baseAddr;
	}

	@Override
	public int getBasicMemoryEndAddress() {
		return basicEnd;
	}

	@Override
	public void overrideConfig(CompilerConfig conf) {
		// TODO Auto-generated method stub
	}

	public void setBasicMemoryEndAddress(int addr) {
		basicEnd = addr;
	}

	public void setNewBaseAddress(int addr) {
		baseAddr = addr;
		maxHeaderAddr = addr + 51;
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
		return false;
	}
	
	@Override
	public boolean supportsBigRam() {
		return false;
	}
}
