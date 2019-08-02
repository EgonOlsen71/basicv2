package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.elements.mnemonics.MnemonicList;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * A parser for parsing assembler programs.
 * 
 * @author EgonOlsen
 */
public class AssemblyParser {
	/**
	 * Gets the mnemonic for a line or null if there is no such thing.
	 * 
	 * @param linePart the line
	 * @return the mnemonic or null
	 */
	public static Mnemonic getMnemonic(String linePart) {
		if (linePart.startsWith(".")) {
			return null;
		}

		List<Mnemonic> mnemonics = MnemonicList.getMnemonics();
		Mnemonic mne = null;

		for (Mnemonic mnee : mnemonics) {
			if (mnee.isMnemonic(linePart)) {
				mne = mnee;
				break;
			}
		}

		return mne;
	}

	/**
	 * Removes comments from a line. Comments are marked as ";"
	 * 
	 * @param linePart the line
	 * @return the line without the comments
	 */
	public static String truncateComments(String linePart) {
		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		int pos = linePart.indexOf("}");
		if (pos == -1) {
			pos = 0;
		}
		for (int i = 0; i < linePart.length(); i++) {
			char c = linePart.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString && c == ';' && i > pos) {
				return sb.toString();
			}
			sb.append(c);
		}
		return sb.toString().trim();
	}

	/**
	 * Gets the label (and code) of a line. If a line contains a label and a
	 * mnemonic, getMnemonic() above will return null. This method will return the
	 * label and rest of the line, so that the rest can be used to call
	 * getMnemonic() again.
	 * 
	 * @param linePart the line
	 * @return the label and code or null if there is no such thing
	 */
	public static LabelAndCode getLabel(String linePart) {
		if (linePart.startsWith(".")) {
			return null;
		}
		String linePart2 = Parser.replaceStrings(linePart, '_').trim();
		int pos = linePart2.indexOf(" ");
		if (pos != -1) {
			return new LabelAndCode(linePart.substring(0, pos).replace(":", ""), linePart.substring(pos + 1).trim());
		} else {
			return new LabelAndCode(linePart.replace(":", ""), "");
		}
	}

	/**
	 * Returns the value of an expression in the code. If the expression can't be
	 * evaluated to a number, an exception will occur. If the number is actually a
	 * label that hasn't been defined yet, the current address will be returned
	 * instead and an information will be added to the LabelsContainer that
	 * indicates that additional work has to be done once the label is known later
	 * in the parsing process.
	 * 
	 * @param number     the number
	 * @param addr       the current address
	 * @param ccon       a container for constants
	 * @param lcon       a container for labels
	 * @param low        do we want the low byte only?
	 * @param high       do we want the high byte only?
	 * @param isDataLine does the line contain an actual command or is it some data
	 *                   like .BYTE
	 * @return the number
	 */
	public static int getValue(CompilerConfig config, String number, int addr, ConstantsContainer ccon,
			LabelsContainer lcon, boolean low, boolean high, int addrAdd, boolean isDataLine) {
		number = number.trim();
		if (number.endsWith("\\")) {
			number = number.substring(0, number.length() - 1);
		}

		if (number.startsWith("{") && number.endsWith("}")) {
			// It's a formular...
			number = number.substring(1, number.length() - 1);
			if (isDataLine) {
				ConstantValue cv = getConstantParsed(config, "___", number, ccon, false);
				if (cv instanceof ConstantDynamic) {
					ccon.addData(new DelayedData() {
						private int addy;
						{
							addy = addr+1;
						}

						@Override
						public void apply(Machine machine, ConstantsContainer ccon) {
							if (low) {
								// .byte
								int val = getLowByte(cv.getValue());
								machine.getRam()[addy] = val;
								//System.out.println("addy: "+addy+"/"+val);
							} else {
								// .word
								int vally = cv.getValue();
								machine.getRam()[addy++] = getLowByteSigned(vally);
								machine.getRam()[addy] = getHighByteSigned(vally);
							}
						}
					});
					return 0; // Just for now, the actual value will be set later
				}
			}
		}

		if (!number.startsWith("$") && !number.startsWith("%") && !Character.isDigit(number.charAt(0))
				&& !(number.startsWith("-"))) {
			ConstantValue cv = ccon.get(number);
			if (cv != null) {
				// System.out.println("Assigned: "+cv.getValue());
				return cv.getValue();
			} else {
				if (!number.startsWith("*")) {
					cv = getConstantParsed(config, "___", number, ccon, false);
					if (cv != null && cv.getValue() != 0) {
						// System.out.println("Calculated: "+cv.getValue());
						return cv.getValue();
					}
				}
				cv = null;
			}

			if (number.startsWith("*")) {
				number = number.replace("*", String.valueOf(addr));
				return getConstantParsed(config, "", number, ccon, true).getValue();
			} else {
				if (number != null && number.contains("+")) {
					number = number.substring(0, number.indexOf("+"));
				}
				Integer labelAddr = lcon.get(number);
				if (labelAddr != null) {
					return labelAddr + addrAdd;
				}
			}
			
			// No constant and no label found...might be a delayed label..
			lcon.addDelayedLabelRef(addr, number, low, high, addrAdd, isDataLine);
			return addr;

		}

		return getValue(number);
	}

	/**
	 * Returns the low byte of a value.
	 * 
	 * @param val the value
	 * @return the low byte
	 */
	public static int getLowByte(int val) {
		return val % 256;
	}

	/**
	 * Returns the high byte of a value.
	 * 
	 * @param val the value
	 * @return the high byte
	 */
	public static int getHighByte(int val) {
		return val / 256;
	}

	/**
	 * @param val
	 * @return
	 */
	public static int getLowByteSigned(int val) {
		if (val >= 0) {
			return val % 256;
		} else {
			return val & 0xff;
		}
	}

	/**
	 * @param val
	 * @return
	 */
	public static int getHighByteSigned(int val) {
		if (val >= 0) {
			return val / 256;
		} else {
			val = val & 0x7fff;
			return (val >> 8) | 128;
		}
	}

	/**
	 * Returns an array containing the binary data defined in the code. Binary data
	 * can be defined by either .text, .strg, .byte, .word, .real or .array
	 * 
	 * @param addr the current address
	 * @param data the data to be parsed
	 * @param lcon
	 * @param ccon
	 * @return the actual data
	 */
	public static int[] getBinaryData(CompilerConfig config, int addr, String data, ConstantsContainer ccon,
			LabelsContainer lcon) {
		List<Integer> ram = new ArrayList<Integer>();
		data = data.trim();
		String datupper = VarUtils.toUpper(data);

		int addrAdd = 0;
		if (!data.contains("{")) {
			int posy = data.lastIndexOf("+");
			if (posy != -1 && posy >= data.lastIndexOf("\"")) {
				try {
					addrAdd = Integer.parseInt(data.substring(posy + 1));
				} catch (Exception e) {
					throw new RuntimeException("Parse error in " + data + "/" + addr);
				}
			}
		}

		if (datupper.startsWith(".TEXT") || datupper.startsWith(".STRG")) {
			data = data.substring(5).trim();
			if (data.startsWith("\"") && data.endsWith("\"")) {
				data = data.substring(1, data.length() - 1);
				int pos = 0;

				if (data.length() > 0) {
					do {
						char c = data.charAt(pos);
						if (c == '{') {
							int pos2 = data.indexOf("}", pos);
							if (pos2 != -1) {
								String part = data.substring(pos, pos2 + 1);
								pos = pos2;
								int mul = 1;
								if (part.contains("*")) {
									String opart = part;
									String smul = part.substring(opart.indexOf("*") + 1).replace("}", "");
									part = opart.substring(0, opart.indexOf("*")) + "}";
									if (smul.length() > 0) {
										if (!Character.isDigit(smul.charAt(0))) {
											smul = opart.substring(1, opart.indexOf("*"));
											part = opart.substring(opart.indexOf("*") + 1).replace("}", "");
										}
										mul = Integer.parseInt(smul);
									} else {
										part = opart;
									}
								}
								for (int i = 0; i < mul; i++) {
									int code = ControlCodes.getCode(part);
									if (code == -1) {
										addToRam(ram, part);
									} else {
										ram.add(code);
									}
								}
							} else {
								addToRam(ram, String.valueOf(c));
							}
						} else {
							addToRam(ram, String.valueOf(c));
						}
						pos++;
					} while (pos < data.length());
				}
			} else {
				throw new RuntimeException("Invalid text data: " + data);
			}
		} else if (datupper.startsWith(".BYTE")) {
			String[] parts = strip(data.substring(5)).split(" ");
			for (String part : parts) {
				int val = getLowByte(getValue(config, part, addr - 1, ccon, lcon, true, false, addrAdd, true));
				addr++;
				ram.add(val);
			}
		} else if (datupper.startsWith(".WORD")) {
			String[] parts = strip(data.substring(5)).split(" ");
			for (String part : parts) {
				int val = getValue(config, part, addr - 1, ccon, lcon, false, false, addrAdd, true);
				addr += 2;
				ram.add(getLowByteSigned(val));
				ram.add(getHighByteSigned(val));
			}
		} else if (datupper.startsWith(".REAL")) {
			String[] parts = strip(data.substring(5)).split(" ");
			for (String part : parts) {
				double val = getRealValue(part);
				int[] res = Conversions.compactFloat(Conversions.convertDouble(val));
				for (int r : res) {
					ram.add(getLowByte(r));
				}
			}
		} else if (datupper.startsWith(".ARRAY")) {
			String[] parts = data.substring(6).trim().split(" ");
			for (String part : parts) {
				int val = getValue(config, part, addr - 1, ccon, lcon, false, false, addrAdd, true);
				if (val < 0) {
					throw new RuntimeException("Value out of range: " + val);
				}
				for (int i = 0; i < val; i++) {
					ram.add(0);
				}
			}
		} else {
			throw new RuntimeException("Invalid data definition: " + data);
		}

		int[] res = new int[ram.size()];
		int cnt = 0;
		for (Integer rv : ram) {
			res[cnt++] = rv;
		}
		return res;
	}

	private static String strip(String txt) {
		boolean inForm = false;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < txt.length(); i++) {
			char c = txt.charAt(i);
			if (c == '{') {
				inForm = true;
			} else if (c == '}') {
				inForm = false;
			}
			if (c != ' ' || !inForm) {
				sb.append(c);
			}
		}
		return sb.toString().trim();
	}

	private static void addToRam(List<Integer> ram, String part) {
		for (int i = 0; i < part.length(); i++) {
			int val = getLowByte((int) part.charAt(i));
			ram.add(getConvertedChar(val));
		}
	}

	/**
	 * Returns the constant that is defined in the given line. It's possible to do
	 * calculations in the right hand side of the assignment as well.
	 * 
	 * @param linePart the constant definition
	 * @param ccon     a container for constants
	 * @return the new constant or null if there is none
	 */
	public static ConstantValue getConstant(CompilerConfig config, String linePart, ConstantsContainer ccon) {
		String linePart2 = Parser.replaceStrings(linePart, '_').trim();
		int pos = linePart2.indexOf("=");
		if (pos != -1) {
			String left = linePart.substring(0, pos).trim();
			String right = linePart.substring(pos + 1).trim();

			if (ccon != null
					&& (right.contains("+") || right.contains("-") || right.contains("*") || right.contains("/")
							|| right.contains("^") || right.contains(")") || ccon.get(right) != null)
					|| Character.isLetter(right.charAt(0))) {
				return getConstantParsed(config, left, right, ccon, true);
			}

			int val = getValue(right);

			if (val < 256) {
				return new ConstantByte(left, val);
			}
			return new ConstantInt(left, val);
		}
		return null;
	}

	/**
	 * Uses the Basic interpreter to parse the right hand side of a constant's
	 * assignment.
	 * 
	 * @param left       the left hand side of the assignment
	 * @param right      the right hand side of the assignment
	 * @param ccon       a container for constants
	 * @param raiseError if true, an error will be raised if a constant can't be
	 *                   found. Otherwise, null will be returned
	 * @return the new constant
	 */
	public static ConstantValue getConstantParsed(CompilerConfig config, String left, String right,
			ConstantsContainer ccon, boolean raiseError) {
		// Uses the Basic parser's term parsing method to evaluate the
		// constant's assignment.
		// Due to limitations in Basic V2, we have to convert the variable names
		// before.
		Map<String, String> names2vars = new HashMap<String, String>();
		StringBuilder sb = new StringBuilder();
		StringBuilder res = new StringBuilder();
		boolean inName = false;
		char varName = 'A';
		right += ";";
		for (int i = 0; i < right.length(); i++) {
			char c = right.charAt(i);
			boolean ended = false;
			if (Character.isLetter(c)) {
				inName = true;
			}
			if (inName && Character.isLetterOrDigit(c) || c == '_') {
				sb.append(c);
			} else {
				ended = true;
			}

			if (ended || i == right.length() - 1) {
				inName = false;
				if (sb.length() > 0) {
					String name = sb.toString();
					sb.setLength(0);
					if (!Parser.isFunction(name)) {
						String var = names2vars.get(name);
						if (var == null) {
							var = "" + (varName++);
							names2vars.put(name, var);
						}
						res.append(var);
					} else {
						res.append(name);
					}
				}
				if (c != ';') {
					res.append(c);
				}
			}

			if (c == ';') {
				break;
			}
		}

		Machine machine = new Machine();

		for (String name : names2vars.keySet()) {
			ConstantValue cv = ccon.get(name);
			if (cv == null) {
				/*
				 * if (raiseError) { throw new RuntimeException("Undefined constant: " + name);
				 * }
				 */
				return new ConstantDynamic(left, right, config, ccon);
			}
			machine.add(new Variable(names2vars.get(name), ccon.get(name).getValue()));
		}

		Term ressy = null;
		try {
			ressy = Parser.getTerm(config, res.toString(), machine, true, true);
		} catch (Throwable nfe) {
			if (raiseError) {
				throw nfe;
			}
			return null;
		}
		int resultValue = ((Number) ressy.eval(machine)).intValue();

		//System.out.println("TRÖT: " + res.toString() + " / res: " + resultValue);

		if (resultValue < 256) {
			return new ConstantByte(left, resultValue);
		}
		return new ConstantInt(left, resultValue);
	}

	private static int getValue(String number) {
		number = number.trim();
		int val = 0;
		try {
			if (number.startsWith("$")) {
				val = Integer.parseInt(number.substring(1), 16);
			} else {
				if (number.startsWith("%")) {
					val = Integer.parseInt(number.substring(1), 2);
				} else {
					val = Integer.parseInt(number);
				}
			}

			if (val < -32768 || val > 65535) {
				throw new RuntimeException("Value out of range: " + val);
			}

			return val;
		} catch (Exception e) {
			throw new RuntimeException("Invalid number: " + number, e);
		}
	}

	private static double getRealValue(String number) {
		number = number.trim();
		try {
			return Double.parseDouble(number);
		} catch (Exception e) {
			throw new RuntimeException("Invalid number: " + number, e);
		}
	}

	private static int getConvertedChar(int c) {
		if (c >= 'a' && c <= 'z') {
			c = (char) ((int) c - 32);
		} else if (c >= 'A' && c <= 'Z') {
			c = (char) ((int) c + 32);
		}
		return c;
	}
}