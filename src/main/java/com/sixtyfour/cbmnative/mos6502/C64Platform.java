package com.sixtyfour.cbmnative.mos6502;

import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;

public class C64Platform implements PlatformProvider {
	private int startAddress = 2072;

	@Override
	public int getStartAddress() {
		return startAddress;
	}

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
		return new Optimizer64();
	}

	@Override
	public Transformer getTransformer() {
		return new Transformer6502();
	}

	@Override
	public Unlinker getUnlinker() {
		return new Unlinker64();
	}

	@Override
	public boolean useLooseTypes() {
		return true;
	}

	@Override
	public int getStringMemoryEnd() {
		return 0xa000;
	}

	@Override
	public int getGarbageCollectionBufferSize() {
		return 	1200;
	}

}
