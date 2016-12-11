package com.sixtyfour.system;

public class ProgramPart {

	private int address;
	private int[] bytes;
	private int[] lineAddresses;

	public int getAddress() {
		return address;
	}

	public void setAddress(int address) {
		this.address = address;
	}

	public int[] getBytes() {
		return bytes;
	}

	public void setBytes(int[] bytes) {
		this.bytes = bytes;
	}

	public int[] getLineAddresses() {
		return lineAddresses;
	}

	public void setLineAddresses(int[] lineAddresses) {
		//System.out.println("Tröt: "+lineAddresses.length+"/"+address);
		this.lineAddresses = lineAddresses;
	}

}
