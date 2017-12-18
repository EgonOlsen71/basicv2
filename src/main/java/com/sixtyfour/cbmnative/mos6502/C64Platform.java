package com.sixtyfour.cbmnative.mos6502;

import com.sixtyfour.cbmnative.PlatformProvider;

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

}
