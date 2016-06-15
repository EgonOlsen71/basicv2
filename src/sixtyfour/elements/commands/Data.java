package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import sixtyfour.parser.Operator;
import sixtyfour.parser.Parser;
import sixtyfour.system.DataStore;
import sixtyfour.system.Machine;


public class Data
extends AbstractCommand
{
  public Data()
  {
    super("DATA");
  }
  
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		List<String> parts = getParts(linePart.substring(4));
		
		DataStore dataStore=machine.getData();
		for (String part : parts) {
			dataStore.add(part);
		}
		return null;
	}
  
  private List<String> getParts(String line, boolean lastPos) {
		line = Parser.removeWhiteSpace(line);
		List<String> res = new ArrayList<String>();
		boolean inString = false;
		int brackets = 0;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < line.length(); i++) {
			char c = line.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				char nc = ' ';
				if (i < line.length() - 1) {
					nc = line.charAt(i + 1);
				}
				if (c == '(') {
					brackets++;
				}
				if (c == ')') {
					brackets--;
				}

				boolean end = i == line.length() - 1;

				if (end || (brackets == 0 && (c == '"' || (c == ')' && nc!='=' && nc!='<' && nc!='>') || c == ',' || c == ';' || (c == '$' && nc != '(') || c == '%'))) {
					if (end || !Operator.isRealOperator(nc)) {
						if (end || c == '"' || c == ')' || c == '%' || c == '$') {
							if (end) {
								nc = ' ';
							}
							if (c != ',' && c != ';') {
								nc = ' ';
								sb.append(c);
							} else {
								nc = c;
							}
						} else {
							nc = c;
						}
						String part = sb.toString();
						sb.setLength(0);
						if (part.length() == 0) {
							part = "\"\"";
						}
						PrintPart pp = new PrintPart(part, nc);
						res.add(pp);
						if (end && part.toUpperCase(Locale.ENGLISH).contains("SPC(") && part.endsWith(")")) {
							// Special case: SPC(...) at the end of the line act
							// like a ;
							line += ";";
						}

						continue;
					}
				}
			}
			sb.append(c);
		}
		return res;
	}
  

}
