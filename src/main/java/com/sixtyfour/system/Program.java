package com.sixtyfour.system;

public class Program {

	private int address;
	private int codeStart;
	private int[] code;
	private int[] opcodeAddresses;

	public Program() {
		//
	}

	public Program(int address, int codeStart, int[] code, int[] opcodeAddresses) {
		this.address = address;
		this.code = code;
		this.codeStart = codeStart;
		this.opcodeAddresses = opcodeAddresses;
	}

	public int getStartAddress() {
		return address;
	}

	public void setStartAddress(int address) {
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

	public int getCodeStart() {
		return codeStart;
	}

	public void setCodeStart(int codeStart) {
		this.codeStart = codeStart;
	}

}
