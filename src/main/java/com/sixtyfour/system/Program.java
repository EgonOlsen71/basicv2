package com.sixtyfour.system;

public class Program {

	private int address;
	private int[] code;

	public Program() {
		//
	}

	public Program(int address, int[] code) {
		this.address = address;
		this.code = code;
	}

	public int getAddress() {
		return address;
	}

	public void setAddress(int address) {
		this.address = address;
	}

	public int[] getCode() {
		return code;
	}

	public void setCode(int[] code) {
		this.code = code;
	}

}
