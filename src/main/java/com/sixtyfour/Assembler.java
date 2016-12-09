package com.sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
		List<Integer> lineBreaks = new ArrayList<Integer>();

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

			ConstantValue cv = AssemblyParser.getConstant(line, ccon);
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

			boolean isData = line.startsWith(".");
			if (!isData) {
				Mnemonic mne = AssemblyParser.getMnemonic(line);
				if (mne == null) {
					LabelAndCode lac = AssemblyParser.getLabel(line);

					if (lac != null) {
						if (lac.getCode().startsWith(".")) {
							isData = true;
						} else {
							mne = AssemblyParser.getMnemonic(lac.getCode());
						}
						lcon.put(lac.getLabel(), addr);
						line = lac.getCode();
					} else {
						throw new RuntimeException("Syntax error at: " + line + "/" + addr);
					}
				}
				if (!isData) {
					if (mne != null) {
						try {
							lineBreaks.add(addr);
							addr = mne.parse(line, addr, machine, ccon, lcon);
						} catch (RuntimeException re) {
							throw new RuntimeException("Error at line " + cnt + ": " + line, re);
						}
					} else {
						if (!line.trim().isEmpty()) {
							throw new RuntimeException("Unknown mnemonic in: " + line);
						}
					}
				}
			}
			if (isData) {
				int[] data = AssemblyParser.getBinaryData(addr, line);
				lineBreaks.add(addr);
				System.arraycopy(data, 0, machine.getRam(), addr, data.length);
				addr += data.length;
			}

		}

		if (lcon.hasDelayedLabels()) {
			throw new RuntimeException("Jump to undefined label: " + lcon.getFirstDelayedLabel());
		}

		end = addr;

		int[] opas = new int[lineBreaks.size()];
		int c = 0;
		for (Integer i : lineBreaks) {
			opas[c++] = i;
		}

		return new Program(start, Arrays.copyOfRange(machine.getRam(), start, end), opas);
	}

	public static String toString(Program prg) {
		StringBuilder sb = new StringBuilder();
		int start = prg.getAddress();
		int lineIndex = 0;
		for (int i = start; i < start + prg.getCode().length; i++) {
			if (i == prg.getOpcodeAddresses()[lineIndex]) {
				lineIndex++;
				if (sb.length() > 0) {
					sb.append("\n");
				}
				sb.append("." + Integer.toString(i, 16));
				sb.append("\t");
			}

			int val = AssemblyParser.getLowByte(prg.getCode()[i - start]);
			String num = Integer.toString(val, 16);
			if (num.length() == 1) {
				num = "0" + num;
			}
			sb.append(num).append(" ");
		}
		return sb.toString();
	}
}
