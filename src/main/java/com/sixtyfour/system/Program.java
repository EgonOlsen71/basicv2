package com.sixtyfour.system;

public class Program {

	private int address;
	private int[] code;
	private int[] opcodeAddresses;

	public Program() {
		//
	}

	public Program(int address, int[] code, int[] opcodeAddresses) {
		this.address = address;
		this.code = code;
		this.opcodeAddresses = opcodeAddresses;
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

	public int[] getOpcodeAddresses() {
		return opcodeAddresses;
	}

	public void setOpcodeAddresses(int[] opcodeAddresses) {
		this.opcodeAddresses = opcodeAddresses;
	}

}
