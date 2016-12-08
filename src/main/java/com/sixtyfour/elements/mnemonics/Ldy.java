package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;

public class Ldy extends AbstractMnemonic {
	public Ldy() {
		super("LDY");
	}

	@Override
	public int parse(String linePart, int addr, Machine machine, ConstantsContainer ccon, LabelsContainer lcon) {
		linePart = linePart.trim().substring(3);
		Parameters pars = this.parseParameters(linePart, ccon);

		int[] ram = machine.getRam();
		if (pars.getValue() != null) {
			// Value
			addr = store(ram, 0xA0, pars.getValue(), addr);
		} else {
			if (!pars.isIndirect()) {
				if (pars.isY()) {
					// ,Y
					throw new RuntimeException("Address mode not supported: " + linePart);
				} else if (pars.isX()) {
					// ,X
					if (pars.isZeropage()) {
						// Direct/Zeropage
						addr = storeByte(ram, 0xB4, pars.getAddr(), addr);
					} else {
						// Direct/Memory
						addr = store(ram, 0xBC, pars.getAddr(), addr);
					}
				} else {
					// Direct
					if (pars.isZeropage()) {
						// Direct/Zeropage
						addr = storeByte(ram, 0xA4, pars.getAddr(), addr);
					} else {
						// Direct/Memory
						addr = store(ram, 0xAC, pars.getAddr(), addr);
					}
				}
			} else {
				throw new RuntimeException("Address mode not supported: " + linePart);
			}
		}

		return addr;
	}
}
