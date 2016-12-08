package com.sixtyfour;

import java.util.Arrays;

import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantValue;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelAndCode;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;

/**
 * WIP
 */
public class Assembler {
	private String[] code = null;
	private Machine machine;
	private int start = 0;
	private int end = 0;

	public Assembler(String code) {
		this(code.split("\n"));
	}

	public Assembler(String[] code) {
		this.code = Arrays.copyOf(code, code.length);
		machine = new Machine();
	}

	public Program compile() {
		ConstantsContainer ccon = new ConstantsContainer();
		LabelsContainer lcon = new LabelsContainer(machine);
		int addr = 0;
		int cnt = 0;

		for (String line : code) {
			cnt++;
			line = line.trim();
			if (line.startsWith(";")) {
				// Ignore comment lines
				continue;
			}

			line = AssemblyParser.truncateComments(line);

			if (line.length() == 0) {
				continue;
			}

			ConstantValue cv = AssemblyParser.getConstant(line);
			if (cv != null) {
				ccon.put(cv);
				if (cv.getName().equals("*")) {
					addr = cv.getValue();
					if (start == 0) {
						start = addr;
					} else {
						throw new RuntimeException("Multiple program start definitions given!");
					}
				}
				continue;
			}

			Mnemonic mne = AssemblyParser.getMnemonic(line);
			if (mne == null) {
				LabelAndCode lac = AssemblyParser.getLabel(line);
				if (lac != null) {
					mne = AssemblyParser.getMnemonic(lac.getCode());
					lcon.put(lac.getLabel(), addr);
				} else {
					throw new RuntimeException("Syntax error at: " + line + "/" + addr);
				}
			}

			if (mne != null) {
				try {
					addr = mne.parse(line, addr, machine, ccon, lcon);
				} catch (RuntimeException re) {
					throw new RuntimeException("Error at line " + cnt, re);
				}
			}
		}

		end = addr;
		return new Program(start, Arrays.copyOfRange(machine.getRam(), start, end));
	}
}
