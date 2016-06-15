package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import sixtyfour.system.DataStore;
import sixtyfour.system.Machine;

public class Data extends AbstractCommand {
	public Data() {
		super("DATA");
	}

	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		List<String> parts = getParts(linePart.substring(4), lastPos);

		DataStore dataStore = machine.getDataStore();
		for (String part : parts) {
			dataStore.add(part);
		}
		return null;
	}

	private List<String> getParts(String line, boolean lastPos) {
		List<String> res = new ArrayList<String>();
		boolean inString = false;
		StringBuilder sb = new StringBuilder();
		boolean hasQuotes = false;
		for (int i = 0; i < line.length(); i++) {
			char c = line.charAt(i);
			if (!inString && c == ' ' && sb.length() == 0) {
				continue;
			}
			if (c == '"') {
				if (sb.length() == 0) {
					inString = true;
					hasQuotes = true;
				} else {
					if (inString) {
						inString = false;
					} else {
						sb.append(c);
					}
				}
			} else {
				if (!inString) {
					if (c == ',') {
						inString = false;
						String txt = getText(sb);
						res.add(txt);
						hasQuotes = false;
					} else {
						if (hasQuotes && c != ' ') {
							throw new RuntimeException("Syntax error: " + this);
						}
						sb.append(c);
					}
				} else {
					sb.append(c);
				}
			}
			if (i == line.length() - 1) {
				inString = false;
				String txt = getText(sb);
				if (lastPos && !hasQuotes) {
					txt = txt.replaceAll("\\s*$", "");
				}
				res.add(txt);
				hasQuotes = false;
			}
		}
		return res;
	}

	private String getText(StringBuilder sb) {
		String txt = sb.toString();
		sb.setLength(0);
		if (txt.isEmpty() || txt.equals(".")) {
			txt = "0";
		}
		return txt;
	}
}
