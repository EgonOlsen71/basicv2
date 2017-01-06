package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.FunctionList;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.plugins.PrintConsumer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The PRINT command.
 */
public class Print extends AbstractCommand {

	/** The parts. */
	protected List<PrintPart> parts = new ArrayList<PrintPart>();

	/**
	 * Instantiates print.
	 */
	public Print() {
		super("PRINT");
	}

	/**
	 * Instantiates print.
	 * 
	 * @param name
	 *            the name
	 */
	protected Print(String name) {
		super(name);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return term.getType();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		List<PrintPart> parts = getParts(linePart.substring(linePart.startsWith("?") ? 1 : 5));
		if (parts.size() == 0) {
			PrintPart newLine = new PrintPart("\"\"", ' ');
			parts.add(newLine);
		}
		for (PrintPart part : parts) {
			part.term = Parser.getTerm(part.part, machine, false, true);
		}
		this.parts = parts;
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		return execute(machine, machine.getOutputChannel(), 0);
	}

	/**
	 * Execute.
	 * 
	 * @param machine
	 *            the machine
	 * @param consumer
	 *            the consumer
	 * @param printId
	 *            the print id
	 * @return the program counter
	 */
	protected BasicProgramCounter execute(Machine machine, PrintConsumer consumer, int printId) {
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
			Object obj = part.term.eval(machine);
			if (VarUtils.isFloat(obj)) {
				float f = (Float) obj;
				if (f == (int) f) {
					obj = (int) f;
				}
			}
			if (obj == null) {
				obj = "";
			}
			String toPrint = obj.toString();
			if (VarUtils.isNumber(obj)) {
				if (VarUtils.getFloat(obj) >= 0) {
					toPrint = " " + toPrint;
				}
			}

			if (("\n").equals(add)) {
				consumer.println(printId, toPrint);
			} else {
				toPrint = toPrint + (add != null ? add : "");
				consumer.print(printId, toPrint);
			}
		}

		return null;
	}

	/**
	 * Gets the parts.
	 * 
	 * @param line
	 *            the line
	 * @return the parts
	 */
	protected List<PrintPart> getParts(String line) {
		line = Parser.removeWhiteSpace(line);
		List<PrintPart> res = new ArrayList<PrintPart>();
		boolean inString = false;
		int brackets = 0;
		StringBuilder sb = new StringBuilder();

		// Crude fix for functions that directly follow vars or constants...
		// Like for example PRINT 1TAB(10)ACHR$(161)B2TAB(23)123TAB(5)..
		// This is quite inefficient and a real crudge, but...anyway...
		List<Function> funs = FunctionList.getFunctions();
		for (int i = 1; i < line.length() - 5; i++) {
			char c = line.charAt(i - 1);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString && Character.isLetterOrDigit(c)) {
				String sub = line.substring(i);
				for (Function fun : funs) {
					if (fun.isFunction(sub)) {
						line = line.substring(0, i) + ";" + line.substring(i);
						i += fun.getName().length() + 1;
						break;
					}
				}
			}
		}

		inString = false;
		for (int i = 0; i < line.length(); i++) {
			char c = line.charAt(i);
			if (c == '"') {
				inString = !inString;
				if (inString && sb.length() > 0) {
					// Some other term is cludged onto a string (like
					// "blah"a"blah")...and that's not
					// some function call
					String part = sb.toString();
					if (!part.endsWith("(") && (part.length() > 0 && !Operator.isOperator(part.charAt(part.length() - 1)))) {
						sb.setLength(0);
						PrintPart pp = new PrintPart(part, ' ');
						res.add(pp);
					}
				}
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

				if (end || (brackets == 0 && (c == '"' || (c == ')' && nc != '=' && nc != '<' && nc != '>') || c == ',' || c == ';' || (c == '$' && nc != '(') || c == '%'))) {
					if (end || !Operator.isRealOperator(nc) || c == ';' || c == ',') {
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
						if (end && VarUtils.toUpper(part).contains("SPC(") && part.endsWith(")")) {
							// Special case: SPC(...) at the end of the line act
							// like a ;
							line += ";";
						}
						// System.out.println("State: " + i + "/" + c + "/" +
						// nc);

						continue;
					}
				}
			}
			// System.out.print(c);
			sb.append(c);
		}
		return res;
	}

	/**
	 * The Class PrintPart.
	 */
	protected static class PrintPart {

		/** The part. */
		public String part;

		/** The delimiter. */
		public char delimiter;

		/** The term. */
		public Term term;

		/**
		 * Instantiates a new prints the part.
		 * 
		 * @param part
		 *            the part
		 * @param delimiter
		 *            the delimiter
		 */
		public PrintPart(String part, char delimiter) {
			this.part = part;
			this.delimiter = delimiter;
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString() {
			return part + "/" + delimiter + "/" + term;
		}
	}

	/**
	 * Clean.
	 * 
	 * @param txt
	 *            the txt
	 * @return the string
	 */
	protected String clean(String txt) {
		return txt.replace("\n", "").replace("\r", "");
	}

}
