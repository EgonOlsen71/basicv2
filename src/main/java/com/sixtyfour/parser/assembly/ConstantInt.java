package com.sixtyfour.parser.assembly;

import com.sixtyfour.system.Machine;

/**
 * An integer constant (i.e. a 16bit value)
 * 
 * @author EgonOlsen
 * 
 */
public class ConstantInt implements ConstantValue {
	private String name;
	private int value;

	public ConstantInt(String name, int value) {
		this.name = name;
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public int getValue() {
		return value;
	}

	@Override
	public String toString() {
		return name + "=" + value;
	}

	@Override
	public int apply(Machine machine, int address) {
		int[] ram = machine.getRam();
		ram[address++] = AssemblyParser.getLowByte(value);
		ram[address++] = AssemblyParser.getHighByte(value);
		return address;

	}

}
