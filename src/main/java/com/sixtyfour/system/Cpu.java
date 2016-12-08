package com.sixtyfour.system;

public class Cpu {
	private int acc;
	private int x;
	private int y;
	private int stackPointer = 0xff;
	private int carryFlag;
	private int negFlag;
	private int zeroFlag;
	private int decimalFlag;
	private int breakFlag;
	private int overflowFlag;
	private int interruptFlag;

	public int getAcc() {
		return acc;
	}

	public void setAcc(int acc) {
		this.acc = acc;
	}

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

	public int getCarryFlag() {
		return carryFlag;
	}

	public void setCarryFlag(int carryFlag) {
		this.carryFlag = carryFlag;
	}

	public int getNegFlag() {
		return negFlag;
	}

	public void setNegFlag(int negFlag) {
		this.negFlag = negFlag;
	}

	public int getZeroFlag() {
		return zeroFlag;
	}

	public void setZeroFlag(int zeroFlag) {
		this.zeroFlag = zeroFlag;
	}

	public int getDecimalFlag() {
		return decimalFlag;
	}

	public void setDecimalFlag(int decimalFlag) {
		this.decimalFlag = decimalFlag;
	}

	public int getBreakFlag() {
		return breakFlag;
	}

	public void setBreakFlag(int breakFlag) {
		this.breakFlag = breakFlag;
	}

	public int getOverflowFlag() {
		return overflowFlag;
	}

	public void setOverflowFlag(int overflowFlag) {
		this.overflowFlag = overflowFlag;
	}

	public int getInterruptFlag() {
		return interruptFlag;
	}

	public void setInterruptFlag(int interruptFlag) {
		this.interruptFlag = interruptFlag;
	}

	public int pop(Machine machine) {
		int[] ram = machine.getRam();
		int val = ram[0x100 + stackPointer];
		stackPointer++;
		return val;
	}

	public void push(Machine machine, int value) {
		int[] ram = machine.getRam();
		ram[0x100 + stackPointer] = value;
		stackPointer--;
	}

	public int getStackPointer() {
		return stackPointer;
	}

	public void setStackPointer(int stackPointer) {
		this.stackPointer = stackPointer;
	}

}
