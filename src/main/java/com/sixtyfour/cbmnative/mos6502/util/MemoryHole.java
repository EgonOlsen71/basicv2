package com.sixtyfour.cbmnative.mos6502.util;

/**
 * Defines a "hole" in memory, i.e. a locked section of memory
 * 
 * @author EgonOlsen
 *
 */
public class MemoryHole {

	private int startAddress;

	private int endAddress;

	public MemoryHole(int start, int end) {
		if (start > end) {
			this.startAddress = end;
			this.endAddress = start;
		} else {
			this.startAddress = start;
			this.endAddress = end;
		}
	}

	public int getStartAddress() {
		return startAddress;
	}

	public void setStartAddress(int startAddress) {
		this.startAddress = startAddress;
	}

	public int getEndAddress() {
		return endAddress;
	}

	public void setEndAddress(int endAddress) {
		this.endAddress = endAddress;
	}

	@Override
	public String toString() {
		return "$" + Integer.toHexString(startAddress) + " - " + "$" + Integer.toHexString(endAddress);
	}

}
