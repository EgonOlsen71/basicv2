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
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.CompilerException;
import com.sixtyfour.util.VarUtils;

/**
 * The PRINT command.
 */
public class Print extends AbstractCommand {

	/** The parts. */
	protected List<PrintPart> parts = new ArrayList<PrintPart>();
	protected String orgLine = null;

	/**
	 * Instantiates print.
	 */
	public Print() {
		super("PRINT");
	}

	/**
	 * Instantiates print.
	 * 
	 * @param name the name
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

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		return parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, true);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int,
	 * int, int, boolean, sixtyfour.system.Machine)
	 */
	protected String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine, boolean optimizeChars) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		orgLine = linePart;
		String aLine = linePart.substring(linePart.startsWith("?") ? 1 : 5);
		List<PrintPart> parts = getParts(aLine, config);
		if (parts.size() == 0) {
			PrintPart newLine = new PrintPart("\"\"", ' ');
			parts.add(newLine);
		}

		for (PrintPart part : parts) {
			// If possible, replace printing of a single char string with a PRINT
			// CHR$(<value>) instead...
			String txt = part.part;
			if (optimizeChars && txt != null && txt.length() == 3 && txt.startsWith("\"") && txt.endsWith("\"")) {
				// Disabled for PRINT#x, until I'm sure it's safe to do this...
				part.part = "chr$(" + (int) (Conversions.convertAscii2Petscii(txt.charAt(1))) + ")";
			}
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

	
	/**
	 * Modifies the strings in a PRINT
	 * 
	 * @param config
	 * @param machine
	 * @param old
	 * @param newy
	 * @param oldPos
	 */
	public int update(CompilerConfig config, Machine machine, String old, String newy, String leftOver, int oldPos) {
		
		old = fix(old);
		newy = fix(newy);
		leftOver = fix(leftOver);
		
		PrintPart part = parts.get(oldPos);
		char oldDel = part.delimiter;
		part.part = old;
		part.delimiter=';';
		part.term = Parser.getTerm(config, old, machine, false, true, true);
		
		int ret = 0;
		if (newy!=null) {
			part = new PrintPart(newy, oldDel);
			part.term = Parser.getTerm(config, newy, machine, false, true, true);
			if (oldPos+1>parts.size()) {
				parts.add(part);
			} else {
				parts.add(oldPos+1, part);
			}
			ret = 1;
		}
		
		if (leftOver!=null && !leftOver.isEmpty()) {
			part.delimiter = ';';
			part = new PrintPart(newy, oldDel);
			part.term = Parser.getTerm(config, leftOver, machine, false, true, true);
			if (oldPos+2>parts.size()) {
				parts.add(part);
			} else {
				parts.add(oldPos+2, part);
			}
			ret=2;
		}
		return ret;
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		return execute(machine, machine.getOutputChannel(), 0);
	}

	/**
	 * Execute.
	 * 
	 * @param machine  the machine
	 * @param consumer the consumer
	 * @param printId  the print id
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
			} else if (VarUtils.isDouble(obj)) {
				double f = (Double) obj;
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
		try {

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

						if (isFileWrite(appendix)) {
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

						if (isFileWrite(appendix)) {
							expr.add("PUSH C");
						}

					}
				}

				if (del == ';' || del == ' ') {
					if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
						if (isFileWrite(appendix)) {
							// file
							add = " ";
						} else {
							// screen
							add = "{right}";
						}
					}
					if (del == ' ' && i == parts.size() - 1) {
						add = "\n";
					}
				} else if (del == ',') {
					add = "\t";
				}

				if (isFileWrite(appendix)) {
					expr = saveC(expr);
				}

				if (("\n").equals(add)) {
					if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
						if (isFileWrite(appendix)) {
							// After a number and before a break, there's an
							// additional blank when writing to a file for some
							// strange reason...
							expr.add("MOV A,# {STRING}");
							expr.add("JSR STROUT" + appendix);
						} else {
							expr.add("JSR CHECKCMD");
						}
					}
					expr.add("JSR LINEBREAK" + appendix);
				} else {
					if (add != null) {
						if (add.equals("\t")) {
							if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
								if (isFileWrite(appendix)) {
									// file...actually, CRSRRIGHT would handle this case as well, but I'm not
									// convinced that
									// the runtime initializes the required value in $13 in all cases (albeit it
									// should...), so
									// we'll keep it this way for now...
									expr.add("JSR STROUT" + appendix);
								} else {
									// screen
									expr.add("JSR CRSRRIGHT");
								}
							}
							expr.add("JSR TABOUT" + appendix);
						} else {
							if (add.equals("{right}")) {
								expr.add("JSR CRSRRIGHT");
							} else {
								expr.add("MOV A,#" + add + "{STRING}");
								expr.add("JSR STROUT" + appendix);
							}
						}
					}
				}

				if (isFileWrite(appendix) && i != parts.size() - 1) {
					expr.add("PUSH C");
				}
			}

		} catch (CompilerException e) {
			throw new RuntimeException("Syntax error: " + orgLine);
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

	private boolean isFileWrite(String appendix) {
		return !appendix.isEmpty();
	}

	/**
	 * Gets the parts.
	 * 
	 * @param line   the line
	 * @param config the compiler config
	 * @return the parts
	 */
	protected List<PrintPart> getParts(String line, CompilerConfig config) {
		line = TermEnhancer.removeWhiteSpace(line);
		List<PrintPart> res = new ArrayList<PrintPart>();
		boolean inString = false;
		int brackets = 0;
		StringBuilder sb = new StringBuilder();

		if (config.isNonDecimalNumbersAware()) {
			// handle hex and bin numbers in print statements, so that fixKludges() doesn't
			// destroy them...YIKES!
			line = TermEnhancer.handleNonDecimalNumbers(config, line);
		}
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
					if (!part.endsWith("(")
							&& (part.length() > 0 && !Operator.isOperator(part.charAt(part.length() - 1)))) {
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
				boolean booleanFollows = false;
				if (i < line.length() - 1) {
					nc = line.charAt(i + 1);
				}
				if (i < line.length() - 3) {
					String ns = line.substring(i + 1, i + 4).toLowerCase(Locale.ENGLISH);
					booleanFollows = ns.equals("and") || ns.startsWith("or");
				}
				if (c == '(') {
					brackets++;
				}
				if (c == ')') {
					brackets--;
				}

				boolean end = i == line.length() - 1;

				if (end || (brackets == 0
						&& (c == '"' || (c == ')' && nc != '=' && nc != '<' && nc != '>' && !booleanFollows) || c == ','
								|| c == ';' || (c == '$' && nc != '(') || (c == '%' && nc != '(')))) {
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
						String upart = VarUtils.toUpper(part);
						if (end && (upart.contains("SPC(") || upart.contains("TAB(")) && part.endsWith(")")) {
							// Special case: SPC(...) and TAB(...) at the end of
							// the line
							// act like a ;
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
				String subSub = line.substring(i - 1);
				boolean splitted = false;
				boolean subSubOk = true;
				for (Function fun : funs) {
					// Fixes vpeek vs. peek
					if (fun.isFunction(subSub)) {
						subSubOk = false;
						break;
					}
				}

				if (subSubOk) {
					for (Function fun : funs) {
						if (fun.isFunction(sub)) {
							line = line.substring(0, i) + ";" + line.substring(i);
							i += fun.getName().length() + 1;
							splitted = true;
							hadLetter = false;
							break;
						}
					}
				}
				// Special case where a variable (or some other term) directly
				// follows something else...except for a logical operation
				if (!splitted) {
					sub = sub.toLowerCase(Locale.ENGLISH);
					char cn = line.charAt(i);
					if ((Character.isDigit(c) || c == '.' || c == ')')
							&& ((!hadLetter && cn == '(') || Character.isLetter(cn) || (c == '.' && cn == '.')
									|| (c == ')' && Character.isLetterOrDigit(cn)))
							&& cn != 'e' && !sub.startsWith("and") && !sub.startsWith("or")) {
						line = line.substring(0, i) + ";" + line.substring(i);
						i++;
						hadLetter = false;
					}
				}
			}
		}
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
		 * @param part      the part
		 * @param delimiter the delimiter
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
	 * @param txt the txt
	 * @return the string
	 */
	protected String clean(String txt) {
		return txt.replace("\n", "").replace("\r", "");
	}

	
	/**
	 * Ensures the a string starts and ends with "
	 * @param txt
	 * @return
	 */
	private String fix(String txt) {
		if (txt==null) {
			return null;
		}
		if (txt.isBlank()) {
			return "";
		}
		if (!txt.startsWith("\"")) {
			txt = "\""+txt;
		}
		if (!txt.endsWith("\"")) {
			txt+="\"";
		}
		return txt;
	}
}
