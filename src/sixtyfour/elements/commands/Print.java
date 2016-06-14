package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.parser.Operator;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Print extends AbstractCommand {
	private List<PrintPart> parts = new ArrayList<PrintPart>();

	public Print() {
		super("PRINT");
	}

	@Override
	public Type getType() {
		return term.getType();
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, memory);
		List<PrintPart> parts = getParts(linePart.substring(5));
		if (parts.size()==0) {
			PrintPart newLine=new PrintPart("\"\"", ' ');
			parts.add(newLine);
		}
		for (PrintPart part : parts) {
			part.term = Parser.getTerm(part.part, memory, false, true);
		}
		this.parts = parts;
		return null;
	}

	@Override
	public ProgramCounter execute(Machine memory) {
		for (int i = 0; i < parts.size(); i++) {
			PrintPart part = parts.get(i);
			char del = part.delimiter;
			// System.out.println("Del: " + del);
			String add = null;
			// System.out.println(part.term+" - "+part.term.getLeft());
			Type type = part.term.getType();
			if (del == ';' || del == ' ') {
				if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
					add = " ";
				}
				if (del == ' ' && i == parts.size() - 1) {
					add = "\n";
				}
			} else if (del == ',') {
				add = "\t";
			}
			Object obj = part.term.eval(memory);
			if (obj instanceof Float) {
				float f = (Float) obj;
				if (f == (int) f) {
					obj = (int) f;
				}
			}
			String toPrint = obj.toString();
			if (("\n").equals(add)) {
				memory.getOutputChannel().println(toPrint, obj instanceof String);
			} else {
				memory.getOutputChannel().print(toPrint + (add != null ? add : ""), obj instanceof String);
			}
		}

		return null;
	}

	private List<PrintPart> getParts(String line) {
		line = Parser.removeWhiteSpace(line);
		List<PrintPart> res = new ArrayList<PrintPart>();
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

	private static class PrintPart {
		public String part;
		public char delimiter;
		public Term term;

		public PrintPart(String part, char delimiter) {
			this.part = part;
			this.delimiter = delimiter;
		}

		@Override
		public String toString() {
			return part + "/" + delimiter + "/" + term;
		}
	}

}
