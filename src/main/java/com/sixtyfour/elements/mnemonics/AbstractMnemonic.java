package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.util.VarUtils;

public abstract class AbstractMnemonic implements Mnemonic {
	private String name;

	public AbstractMnemonic(String name) {
		this.name = VarUtils.toUpper(name);
	}

	@Override
	public boolean isMnemonic(String linePart) {
		return VarUtils.toUpper(linePart.trim()).startsWith(name);
	}

	@Override
	public AbstractMnemonic clone() {
		try {
			AbstractMnemonic clone = this.getClass().newInstance();
			clone.name = name;
			return clone;
		} catch (Exception e) {
			throw new RuntimeException("Unable to instantiate mnemonic: " + name);
		}
	}

	@Override
	public String toString() {
		return name;
	}

	protected int storeByte(int[] ram, int opcode, int value, int addr) {
		ram[addr++] = opcode;
		ram[addr++] = AssemblyParser.getLowByte(value);
		return addr;
	}
	
	protected int store(int[] ram, int opcode, int value, int addr) {
		ram[addr++] = opcode;
		ram[addr++] = AssemblyParser.getLowByte(value);
		ram[addr++] = AssemblyParser.getHighByte(value);
		return addr;
	}

	protected Parameters parseParameters(String pars, ConstantsContainer ccon) {
		pars = Parser.removeWhiteSpace(pars);
		boolean isValue = pars.startsWith("#");
		boolean isIndirect = pars.startsWith("(");
		int indexedPos = pars.indexOf(',');
		boolean indexed = indexedPos != -1;
		pars = pars.replace("#", "");

		String part1 = indexed ? pars.substring(0, indexedPos) : pars;
		String part2 = indexed ? VarUtils.toUpper(pars.substring(indexedPos + 1)) : "";

		if (isIndirect && !((part2.endsWith(")") && part2.startsWith("X")) || (part1.endsWith(")") && part2.startsWith("Y")))) {
			throw new RuntimeException("Invalid indirect addressing: " + pars);
		}

		part1 = removeBrackets(part1);
		part2 = removeBrackets(part2);

		Parameters par = new Parameters();
		par.setX(part2.startsWith("X"));
		par.setY(part2.startsWith("Y"));
		par.setIndirect(isIndirect);

		if (isValue) {
			par.setValue(AssemblyParser.getValue(part1, ccon));
		} else {
			int val = AssemblyParser.getValue(part1, ccon);
			par.setAddr(val);
			if (val < 256) {
				par.setZeropage(true);
			}
		}

		return par;
	}

	private String removeBrackets(String part1) {
		return part1.replace("(", "").replace(")", "");
	}

}
