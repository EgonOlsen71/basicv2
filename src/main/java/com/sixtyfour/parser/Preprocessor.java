package com.sixtyfour.parser;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.Goto;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.elements.commands.On;

/**
 * This class can be used to convert a BASIC program that uses labels and no
 * line numbers to proper BASIC V2 style with line numbers only. For example:
 * 
 * <pre>
 * a=3
 * output:
 * print"hallo":a=a+1
 * if a<100 then output
 * goto terminate
 * print "should not see this!"
 * terminate:end
 * </pre>
 * 
 * will be converted to this:
 * 
 * <pre>
 * 100 a=3
 * 110 rem jump target
 * 120 print"hallo":a=a+1
 * 130 if a<100 then 110
 * 140 goto 160
 * 150 print "should not see this!"
 * 160 end
 * </pre>
 * 
 * This doesn't happen automatically. If one wants to use labels instead of line
 * numbers, he/she has to trigger this conversion in Java code.
 * 
 * @author EgonOlsen
 * 
 */
public class Preprocessor {
	private final static int INC = 10;
	private final static int START = 100;

	/**
	 * Converts a BASIC program with labels and without line numbers into one with
	 * line numbers only. If the code can't be converted properly, this method will
	 * throw an exception.
	 * 
	 * @param code the code with labels
	 * @return the code with line numbers
	 */
	public static String[] convertToLineNumbers(String[] code) {
		List<String> res = new ArrayList<String>();
		List<String> tmp = new ArrayList<String>();
		Map<String, Integer> label2line = new HashMap<String, Integer>();
		int ln = START;
		for (String line : code) {
			if (!line.isEmpty()) {
				char c = line.charAt(0);
				if (Character.isDigit(c)) {
					throw new RuntimeException("Code already contains line numbers: " + Arrays.toString(code));
				}
				int pos = line.indexOf(":");
				if (pos != -1) {
					String label = line.substring(0, pos).trim();
					Command com = Parser.getCommand(label);
					if (com == null || (label.length() > com.getName().length()
							&& label.charAt(com.getName().length()) == '_')) {
						label2line.put(label, ln);
						// System.out.println("Adding: " + label + "/" + ln);
						line = line.substring(pos + 1).trim();
						if (line.isEmpty()) {
							line = "rem jump target";
						}
					}
				}
				tmp.add(line);
				ln += INC;
			}
		}

		ln = START;
		for (String line : tmp) {
			String[] parts = line.split(":");
			StringBuilder sb = new StringBuilder();
			if (parts.length > 0) {
				for (String part : parts) {
					if (sb.length() > 0) {
						sb.append(":");
					}
					Command com = Parser.getCommand(part.trim());
					if (com instanceof If) {
						String lp = Parser.replaceStrings(part, '_').toLowerCase(Locale.ENGLISH);
						int pos = lp.indexOf("then");
						int pos2 = lp.indexOf("goto");
						boolean got = true;
						if (pos2 == -1) {
							pos2 = lp.indexOf("gosub");
							if (pos2 != -1) {
								got = false;
							}
						}
						if (pos == -1) {
							pos = pos2;
						}
						if (pos2 > pos) {
							pos = pos2;
						}
						if (pos != -1) {
							sb.append(part.substring(0, pos + (got ? 4 : 5))).append(" ");
							String op = part.substring(pos + (got ? 4 : 5));
							Integer lineNum = label2line.get(op.trim());
							if (lineNum != null) {
								sb.append(lineNum);
							} else {
								sb.append(op);
							}
						} else {
							sb.append(part);
						}
					} else {
						if (com instanceof Goto || com instanceof Gosub || com instanceof On) {
							String pl = part.toLowerCase(Locale.ENGLISH);
							int pos = pl.indexOf("goto");
							boolean got = true;
							if (pos == -1) {
								pos = pl.indexOf("gosub");
								got = false;
							}
							if (pos != -1) {
								sb.append(part.substring(0, pos + (got ? 4 : 5))).append(" ");
								String op = part.substring(pos + (got ? 4 : 5));
								String[] targets = op.split(",");
								int cnt = 0;
								for (String target : targets) {
									Integer lineNum = label2line.get(target.trim());
									if (lineNum == null) {
										throw new RuntimeException("Label '" + target.trim() + "' not found: " + line);
									}
									sb.append((cnt++) == 0 ? "" : ",");
									sb.append(lineNum);
								}
							}
						} else {
							sb.append(part);
						}
					}
				}
				res.add(ln + " " + sb.toString());
			} else {
				res.add(ln + " " + line);
			}
			ln += INC;
		}

		return res.toArray(new String[res.size()]);
	}

	/**
	 * Converts pound and pi in strings into something usable.
	 * 
	 * @param code
	 * @return
	 */
	public static String[] convertSpecialChars(String[] code) {
		List<String> res = new ArrayList<String>();

		Map<Character, String> replacements = new HashMap<>();
		replacements.put('£', "{pound}");
		replacements.put('π', "{pi}");
		replacements.put('Π', "{pi}");

		StringBuilder sb = new StringBuilder();
		for (String line : code) {
			int brackets = 0;
			boolean inString = false;
			for (int i = 0; i < line.length(); i++) {
				char c = line.charAt(i);
				if (c == '"') {
					inString = !inString;
				}
				if (c == '{') {
					brackets++;
				} else if (c == '}') {
					brackets--;
				}
				if (inString && replacements.containsKey(c)) {
					String rep = replacements.get(c);
					if (brackets > 0) {
						// We are in curly braches already...don't add another layer of them...
						rep = rep.substring(1, rep.length() - 1);
					}
					sb.append(rep);
				} else {
					sb.append(c);
				}
			}
			res.add(sb.toString());
			sb.setLength(0);
		}

		return res.toArray(new String[res.size()]);
	}

}
