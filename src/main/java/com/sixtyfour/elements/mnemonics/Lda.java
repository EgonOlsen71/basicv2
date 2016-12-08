package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;

public class Lda extends AbstractMnemonic {
	public Lda() {
		super("LDA");
	}

	@Override
	public int parse(String linePart, int addr, Machine machine, ConstantsContainer ccon, LabelsContainer lcon) {
		linePart = linePart.trim().substring(3);
		Parameters pars = this.parseParameters(linePart, ccon);

		int[] ram = machine.getRam();
		if (pars.getValue() != null) {
			// Value
			addr = store(ram, 0xA9, pars.getValue(), addr);
		} else {
			if (!pars.isIndirect()) {
				if (pars.isX()) {
					// ,X
					if (pars.isZeropage()) {
						// Direct/Zeropage
						addr = storeByte(ram, 0xB5, pars.getAddr(), addr);
					} else {
						// Direct/Memory
						addr = store(ram, 0xBD, pars.getAddr(), addr);
					}
				} else if (pars.isY()) {
					// ,Y
					if (pars.isZeropage()) {
						throw new RuntimeException("Address mode not supported: " + linePart);
					} else {
						// Direct/Memory
						addr = store(ram, 0xB9, pars.getAddr(), addr);
					}
				} else {
					// Direct
					if (pars.isZeropage()) {
						// Direct/Zeropage
						addr = storeByte(ram, 0xA5, pars.getAddr(), addr);
					} else {
						// Direct/Memory
						addr = store(ram, 0xAD, pars.getAddr(), addr);
					}
				}
			} else {
				// Indirect
				if (!pars.isZeropage()) {
					throw new RuntimeException("Address mode not supported: " + linePart);
				}
				if (pars.isX()) {
					// ,X
					addr = storeByte(ram, 0xA1, pars.getAddr(), addr);
				} else if (pars.isY()) {
					// ,Y
					addr = storeByte(ram, 0xB1, pars.getAddr(), addr);
				} else {
					throw new RuntimeException("Address mode not supported: " + linePart);
				}
			}
		}

		return addr;
	}

}
