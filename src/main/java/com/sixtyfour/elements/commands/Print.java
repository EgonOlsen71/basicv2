package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.FunctionList;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.cbmnative.CodeContainer;
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
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		List<PrintPart> parts = getParts(linePart.substring(linePart.startsWith("?") ? 1 : 5));
		if (parts.size() == 0) {
			PrintPart newLine = new PrintPart("\"\"", ' ');
			parts.add(newLine);
		}
		for (PrintPart part : parts) {
			part.term = Parser.getTerm(config, part.part, machine, false, true);
		}
		this.parts = parts;
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.commands.Command#getAllTerms()
	 */
	@Override
	public List<Term> getAllTerms() {
		List<Term> ret = new ArrayList<Term>();
		ret.add(term);
		for (PrintPart part : parts) {
			ret.add(part.term);
		}
		return ret;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
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
			String add = null;
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
				if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
					add = " " + add;
				}
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

	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return evalToCode(config, machine, "");
	}

	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine, String appendix) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();
		List<String> before = null;

		for (int i = 0; i < parts.size(); i++) {
			PrintPart part = parts.get(i);
			char del = part.delimiter;
			String add = null;
			Type type = part.term.getType();

			if (!part.part.replace("\"", "").isEmpty()) {
				List<String> exprPart = compiler.compileToPseudoCode(config, machine, part.term);
				if (!exprPart.isEmpty()) {
					String expPush = getPushRegister(exprPart.get(exprPart.size() - 1));
					exprPart = exprPart.subList(0, exprPart.size() - 1);

					expr.addAll(exprPart);

					if (expPush.equals("Y")) {
						expr.add("MOV X,Y");
					} else if (expPush.equals("B")) {
						expr.add("MOV A,B");
					}

					String lastCmd = expr.get(expr.size() - 1);

					if (!appendix.isEmpty()) {
						expr = saveC(expr);
					}

					if (!lastCmd.startsWith("JSR TAB") && !lastCmd.startsWith("JSR SPC")) {
						if (type.equals(Type.INTEGER)) {
							expr.add("JSR INTOUT" + appendix);
						} else if (type.equals(Type.REAL)) {
							expr.add("JSR REALOUT" + appendix);
						} else {
							expr.add("JSR STROUT" + appendix);
						}
					}

					if (!appendix.isEmpty()) {
						expr.add("PUSH C");
					}

				}
			}

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

			if (!appendix.isEmpty()) {
				expr = saveC(expr);
			}

			if (("\n").equals(add)) {
				expr.add("JSR LINEBREAK" + appendix);
			} else {
				if (add != null) {
					if (add.equals("\t")) {
						if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
							expr.add("MOV A,# {STRING}");
							expr.add("JSR STROUT" + appendix);
						}
						expr.add("JSR TABOUT" + appendix);
					} else {
						expr.add("MOV A,#" + add + "{STRING}");
						expr.add("JSR STROUT" + appendix);
					}
				}
			}

			if (!appendix.isEmpty() && i != parts.size() - 1) {
				expr.add("PUSH C");
			}
		}

		// Just to be sure...
		if (expr.size() > 0 && expr.get(expr.size() - 1).equals("PUSH C")) {
			expr = expr.subList(0, expr.size() - 1);
		}

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

	/**
	 * Gets the parts.
	 * 
	 * @param line
	 *            the line
	 * @return the parts
	 */
	protected List<PrintPart> getParts(String line) {
		line = TermEnhancer.removeWhiteSpace(line);
		List<PrintPart> res = new ArrayList<PrintPart>();
		boolean inString = false;
		int brackets = 0;
		StringBuilder sb = new StringBuilder();

		line = fixKludges(line);

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

			if (inString && i == line.length() - 1) {
				// String isn't properly terminated...we'll accept it anyway.
				inString = false;
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

				if (end
						|| (brackets == 0 && (c == '"' || (c == ')' && nc != '=' && nc != '<' && nc != '>') || c == ',' || c == ';' || (c == '$' && nc != '(') || (c == '%' && nc != '(')))) {
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
							// Special case: SPC(...) at the end of the line
							// acts like a ;
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

	private String fixKludges(String line) {
		// Crude fix for functions/vars/constants that directly follow
		// functions/vars/constants...
		// Like for example PRINT 1TAB(10)ACHR$(161)B2TAB(23)123TAB(5)..or PRINT
		// 3(3)a(a(3))3
		// This is quite inefficient and a real crudge, but...anyway...
		boolean inString = false;
		boolean hadLetter = false;
		List<Function> funs = FunctionList.getFunctions();

		for (int i = 1; i < line.length(); i++) {
			char c = line.charAt(i - 1);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString && (Character.isLetterOrDigit(c) || c == '.')) {
				hadLetter |= Character.isLetter(c);
				String sub = line.substring(i);
				boolean splitted = false;
				for (Function fun : funs) {
					if (fun.isFunction(sub)) {
						line = line.substring(0, i) + ";" + line.substring(i);
						i += fun.getName().length() + 1;
						splitted = true;
						hadLetter = false;
						break;
					}
				}
				// Special case where a variable (or some other term) directly
				// follows something else...except for a logical operation
				if (!splitted) {
					sub = sub.toLowerCase(Locale.ENGLISH);
					char cn = line.charAt(i);
					if ((Character.isDigit(c) || c == '.' || c == ')')
							&& ((!hadLetter && cn == '(') || Character.isLetter(cn) || (c == '.' && cn == '.') || (c == ')' && Character.isLetterOrDigit(cn))) && cn != 'e'
							&& !sub.startsWith("and") && !sub.startsWith("or")) {
						line = line.substring(0, i) + ";" + line.substring(i);
						i++;
						hadLetter = false;
					}
				}
			}
		}
		// System.out.println(line);
		return line;
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
