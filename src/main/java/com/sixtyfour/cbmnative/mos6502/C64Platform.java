package com.sixtyfour.cbmnative.mos6502;

import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;

public class C64Platform implements PlatformProvider {
	private int startAddress = 2065;

	@Override
	public String getCall(String line) {
		return null;
	}

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
		return null;//new Optimizer64();
	}

	@Override
	public Transformer getTransformer() {
		return new Transformer6502();
	}

}
