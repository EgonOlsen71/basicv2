package com.sixtyfour.parser;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.CommandList;
import com.sixtyfour.elements.functions.ArrayAccess;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.FunctionList;
import com.sixtyfour.parser.logic.LogicParser;
import com.sixtyfour.parser.logic.LogicTerm;
import com.sixtyfour.parser.optimize.ConstantFolder;
import com.sixtyfour.parser.optimize.TermOptimizer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The Parser. This class does the actual dirty work and parses the BASIC
 * program respectively parts of it.
 */
public class Parser {

	private static TermBuilder builder = new TermBuilder() {
		@Override
		public Term build(CompilerConfig config, Term t, Map<String, Term> termMap, Machine machine) {
			return Parser.build(config, t, termMap, machine);
		}
	};

	private static boolean optimizeConstantExpressions = true;

	/**
	 * If set to true, the parser will automatically try to optimize constant
	 * expression by calculating the actual result beforehand. If false, the
	 * calculation will be done at runtime. Default is true.
	 * 
	 * 
	 * @param optimizeConstantExpressions
	 */
	public static void setOptimizeConstantExpressions(boolean optimizeConstantExpressions) {
		Parser.optimizeConstantExpressions = optimizeConstantExpressions;
	}

	/**
	 * Splits the line into its parts, i.e. into its different command blocks,
	 * usually separated by a colon.
	 * 
	 * @param line
	 *            the line to split
	 * @param machine
	 *            the machine
	 * @return the parts
	 */
	public static String[] getParts(Line line, Machine machine) {
		List<String> parts = new ArrayList<String>();
		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		String term = line.getLine();
		for (int i = 0; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (inString || c != ':') {
				sb.append(c);
			}
			if (!inString) {
				if (c == ':') {
					parts.add(cleanPart(sb));
					sb.setLength(0);
				}
			}
		}
		if (sb.length() > 0) {
			parts.add(cleanPart(sb));
		}
		return parts.toArray(new String[parts.size()]);
	}

	/**
	 * Checks if is a text can be converted into an integer.
	 * 
	 * @param txt
	 *            the txt
	 * @return true, if it's actually an integer
	 */
	public static boolean isInteger(String txt) {
		try {
			Integer.parseInt(txt);
		} catch (NumberFormatException nfe) {
			return false;
		}
		return true;
	}

	/**
	 * Returns the command in that line part. In case that the line part is a
	 * variable assignment, it will return the LET command.
	 * 
	 * @param linePart
	 *            the line part
	 * @return the command
	 */
	public static Command getCommand(String linePart) {
		List<Command> commands = CommandList.getCommands();
		Command com = null;

		for (Command command : commands) {
			if (command.isCommand(linePart)) {
				com = command.clone(linePart);
				break;
			}
		}
		if (com == null) {
			if (linePart.contains("=")) {
				com = CommandList.getLetCommand().clone("LET" + linePart);
			}
		}
		return com;
	}

	/**
	 * Returns the variable of that line part, i.e. the left side of an
	 * assigment if there is any.
	 * 
	 * @param linePart
	 *            the line part
	 * @param machine
	 *            the machine
	 * @return the variable or null, if there is none
	 */
	public static Variable getVariable(String linePart, Machine machine) {
		return getVariable(linePart, machine, true);
	}

	/**
	 * Returns the variable of that line part, i.e. the left side of an
	 * assigment if there is any.
	 * 
	 * @param linePart
	 *            the line part
	 * @param machine
	 *            the machine
	 * @param includingAssignment
	 *            check if this is an actual assignment. If this is false,
	 *            anything at the start will be interpreted as a variable.
	 * @return the variable or null, if there is none
	 */
	public static Variable getVariable(String linePart, Machine machine, boolean includingAssignment) {
		if (includingAssignment) {
			int pos = linePart.indexOf('=');
			if (pos == -1) {
				throw new RuntimeException("Missing assignment: " + linePart);
			}
			linePart = linePart.substring(0, pos);
		}
		String ret = getVariableName(linePart);

		if (!ret.endsWith("[]")) {
			return machine.add(new Variable(ret, null));
		} else {
			return new Variable(ret, null);
		}
	}

	/**
	 * Returns the array variable of that line part including the terms used for
	 * sizing it.
	 * 
	 * @param linePart
	 *            the line part
	 * @param machine
	 *            the machine
	 * @return the array variable and its terms
	 */
	public static List<VariableAndTerms> getArrayVariables(CompilerConfig config, String linePart, Machine machine) {
		if (!linePart.contains("(") && !linePart.contains(")")) {
			return null;
		}
		List<VariableAndTerms> vars = new ArrayList<VariableAndTerms>();
		linePart = linePart.substring(3).trim();
		StringBuilder sb = new StringBuilder();
		int brackets = 0;
		for (int i = 0; i < linePart.length(); i++) {
			char c = linePart.charAt(i);
			if (c == '(') {
				brackets++;
			}
			if (c == ')') {
				brackets--;
			}
			if (c == ',' && brackets == 0) {
				sb.append(';');
			} else {
				sb.append(c);
			}
		}
		linePart = sb.toString();

		String[] parts = linePart.split(";");
		for (String part : parts) {
			part = part.trim();
			if (!part.endsWith(")")) {
				part = part + "(10)";
			}
			int pos = part.indexOf('(');
			int pos2 = part.lastIndexOf(')');
			if (pos != -1 && pos2 != -1) {
				String var = VarUtils.toUpper(part.substring(0, pos).trim());
				Term params = Parser.getTerm(config, part.substring(pos + 1, pos2), machine, false, true);
				List<Atom> pars = getParameters(params);
				if (pars.size() == 0) {
					throw new RuntimeException("No array size specified: " + part + "/" + params);
				}
				VariableAndTerms vat = new VariableAndTerms(var, pars);
				vars.add(vat);
			} else {
				throw new RuntimeException("Syntax error: " + linePart);
			}
		}
		return vars;
	}

	/**
	 * Returns the name of the variable in the line part.
	 * 
	 * @param linePart
	 *            the line part
	 * @return the variable name or an empty string if there is none
	 */
	public static String getVariableName(String linePart) {
		linePart = VarUtils.toUpper(linePart.trim());
		int pos = linePart.indexOf('(');
		boolean isArray = false;
		if (pos != -1) {
			linePart = linePart.substring(0, pos);
			isArray = true;
		}

		for (int i = 0; i < linePart.length(); i++) {
			char c = linePart.charAt(i);
			if (i == 0 && !Character.isLetter(c)) {
				throw new RuntimeException("Invalid variable name: " + linePart);
			}
			if (!Character.isLetter(c) && ((i > 0) && (!Character.isDigit(c) && c != '%' && c != '$'))) {
				throw new RuntimeException("Invalid variable name: " + linePart);
			}
			if ((c == '%' || c == '$') && i != linePart.length() - 1) {
				throw new RuntimeException("Invalid variable name: " + linePart);
			}
		}

		String ret = "";
		if (linePart.length() > 0) {
			char c = linePart.charAt(linePart.length() - 1);
			ret = linePart.substring(0, Math.min(2, linePart.length()));
			if (c == '%' || c == '$') {
				if (!ret.endsWith(Character.toString(c))) {
					ret += c;
				}
			}
		}
		if (isArray && !ret.endsWith("[]")) {
			ret += "[]";
		}
		return ret;
	}

	/**
	 * Replaces all strings (everything wrapped in ") with the given char. The
	 * length of the term will stay the same. This is used to ease parsing in
	 * some cases.
	 * 
	 * @param term
	 *            the term
	 * @param toReplaceWith
	 *            the char to replace with
	 * @return the resulting string
	 */
	public static String replaceStrings(String term, char toReplaceWith) {
		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		for (int i = 0; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
				sb.append('"');
				continue;
			}
			if (!inString) {
				sb.append(c);
			} else {
				sb.append(toReplaceWith);
			}
		}
		return VarUtils.toUpper(sb.toString());
	}

	/**
	 * Returns an index term for accesing an array's element.
	 * 
	 * @param var
	 *            the array variable
	 * @param linePart
	 *            the line part
	 * @param machine
	 *            the machine
	 * @param checkForAssignment
	 *            if true, only the left part of an assignment will be taken
	 *            into account. If false, the whole string will.
	 * @return the variable with its index term
	 */
	public static VariableAndIndex getIndexTerm(CompilerConfig config, Variable var, String linePart, Machine machine, boolean checkForAssignment) {
		if (var.getName().endsWith("[]")) {
			// array
			if (checkForAssignment) {
				int pos = linePart.indexOf('=');
				if (pos != -1) {
					linePart = linePart.substring(0, pos);
				}
			}
			int pos = linePart.indexOf('(');
			int pos2 = linePart.lastIndexOf(')');
			if (pos != -1 && pos2 != -1) {
				Term params = Parser.getTerm(config, linePart.substring(pos + 1, pos2), machine, false, true);
				List<Atom> pars = Parser.getParameters(params);
				boolean dimed = machine.getVariable(var.getName()) != null;
				if (!dimed) {
					int[] pis = new int[pars.size()];
					for (int i = 0; i < pis.length; i++) {
						pis[i] = 10;
					}
					var = new Variable(var.getName(), null, pis);
					var.clear();
				}
				return new VariableAndIndex(var, params);
			} else {
				throw new RuntimeException("Array index out of bounds error: " + linePart);
			}
		}
		return new VariableAndIndex(var, null);
	}

	/**
	 * Returns a function that accesses the element of an array. Internally,
	 * array access is handled as a function call on that array that returns an
	 * element.
	 * 
	 * @param linePart
	 *            the line part
	 * @param var
	 *            the array variable
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @return the variable and its array access function
	 */
	public static Function getArrayAccessFunction(CompilerConfig config, String linePart, Variable var, Map<String, Term> termMap, Machine machine) {
		ArrayAccess fun = new ArrayAccess();
		int pos = linePart.indexOf('(');
		int pos2 = linePart.lastIndexOf(')');
		if (pos == -1 || pos2 < pos) {
			pos = linePart.indexOf('{');
			pos2 = linePart.indexOf('}');
			if (termMap == null || pos == -1 || pos2 < pos) {
				throw new RuntimeException("Invalid function call: " + linePart);
			} else {
				fun.setTerm(Parser.createTerm(config, linePart.substring(pos, pos2 + 1), termMap, machine));
			}
		} else {
			fun.parse(config, linePart.substring(pos + 1, pos2), machine);
		}
		fun.setVariable(var);
		return fun;
	}

	/**
	 * Returns the term that represents the term in the text. The result will be
	 * a binary tree build out of terms with the returned term being the root
	 * element.
	 * 
	 * @param term
	 *            the term as text
	 * @param machine
	 *            the machine
	 * @param stripAssignment
	 *            if true, assignments will be stripped
	 * @param checkForLogicTerm
	 *            if true, logic terms will be checked for as well
	 * @return the resulting term
	 */
	public static Term getTerm(CompilerConfig config, String term, Machine machine, boolean stripAssignment, boolean checkForLogicTerm) {
		checkForInvalidChars(term);
		Term ret = getTerm(config, term, machine, stripAssignment, checkForLogicTerm, null);
		ret.setInitial(TermEnhancer.stripAssignment(term, stripAssignment));
		return ret;
	}

	/**
	 * Similar to getTerm() but omits some additional syntax checks. Used
	 * internally only!
	 * 
	 * @param term
	 *            the term as text
	 * @param machine
	 *            the machine
	 * @param stripAssignment
	 *            if true, assignments will be stripped
	 * @param checkForLogicTerm
	 *            if true, logic terms will be checked for as well
	 * @return the resulting term
	 */
	public static Term getTermWithoutChecks(CompilerConfig config, String term, Machine machine, boolean stripAssignment, boolean checkForLogicTerm) {
		Term ret = getTerm(config, term, machine, stripAssignment, checkForLogicTerm, null);
		ret.setInitial(TermEnhancer.stripAssignment(term, stripAssignment));
		return ret;
	}

	/**
	 * Returns the term that represents the term in the text. The result will be
	 * a binary tree build out of terms with the returned term being the root
	 * element.
	 * 
	 * @param config
	 *            teh compiler's config
	 * @param term
	 *            the term as text
	 * @param machine
	 *            the machine
	 * @param stripAssignment
	 *            if true, assignments will be stripped
	 * @param checkForLogicTerm
	 *            if true, logic terms will be checked for as well
	 * @param termMap
	 *            the term map
	 * @return the resulting term
	 */
	public static Term getTerm(CompilerConfig config, String term, Machine machine, boolean stripAssignment, boolean checkForLogicTerm, Map<String, Term> termMap) {
		if (termMap == null) {
			termMap = new HashMap<String, Term>();
		}
		term = TermEnhancer.stripAssignment(term, stripAssignment);
		term = TermEnhancer.replaceScientificNotation(term);
		term = TermEnhancer.addBrackets(term);
		Term ret = createTerms(config, term, termMap, machine, checkForLogicTerm);
		if (Parser.optimizeConstantExpressions) {
			ret = TermOptimizer.optimizeTerm(config, machine, ret, termMap, builder);
		}
		ret.setInitial(term, termMap);
		return ret;
	}

	/**
	 * Returns the term that represents the term in the text minus the command
	 * at the start of it. The result will be a binary tree build out of terms
	 * with the returned term being the root element.
	 * 
	 * @param command
	 *            the command
	 * @param term
	 *            the term as text
	 * @param machine
	 *            the machine
	 * @param checkForLogicTerm
	 *            if true, logic terms will be checked for as well
	 * @return the term
	 */
	public static Term getTerm(CompilerConfig config, Command command, String term, Machine machine, boolean checkForLogicTerm) {
		checkForInvalidChars(term);
		term = TermEnhancer.removeWhiteSpace(term.substring(command.getName().length()));
		term = TermEnhancer.replaceScientificNotation(term);
		term = TermEnhancer.addBrackets(term);
		Term ret = createTerms(config, term, new HashMap<String, Term>(), machine, checkForLogicTerm);
		ret.setInitial(term);
		return ret;
	}

	/**
	 * Creates a term based on an array index.
	 * 
	 * @param machine
	 *            the machine
	 * @param pars
	 *            the parameter list (i.e. the array indices)
	 * @param dimensions
	 *            the dimension of the array
	 * @return the term
	 */
	public static Term createIndexTerm(CompilerConfig config, Machine machine, List<Atom> pars, int[] dimensions) {
		int m = 1;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < pars.size(); i++) {
			if (sb.length() > 0) {
				sb.append("+");
			}
			if (pars.size() > 1) {
				sb.append("int(");
			} else {
				// Not needed for one-dimensional arrays, the value should be
				// rounded in the compiled code anyway
				sb.append("(");
			}
			Atom atom = pars.get(i);
			// System.out.println("Atom: "+atom+"             ## "+sb.toString()+"/"+atom.getClass());
			if (!(atom instanceof Term)) {
				if (atom instanceof Variable) {
					sb.append(((Variable) atom).getUpperCaseName());
				} else {
					if (atom instanceof Function) {
						Function fun = (Function) atom;
						String call = fun.getInitialCall();
						sb.append(call);
					} else {
						// Constants...
						sb.append(atom.eval(machine));
					}
				}
			} else {
				// For the first array index term, the initial value is the
				// whole term (i.e. all parameters).
				// This hack truncates it properly...not nice, but just pretend
				// that you haven't seen this.
				String ini = ((Term) atom).getInitial();
				if (i == 0) {
					ini = ((Term) atom).getTruncatedInitial();
				}
				sb.append(ini);
			}
			if (m == 1) {
				sb.append(")");
			} else {
				sb.append(")*(").append(m).append(")");
			}
			m *= dimensions[i] + 1;
		}

		// System.out.println("Index term: "+sb.toString());

		Term t = Parser.getTermWithoutChecks(config, sb.toString(), machine, false, true);
		return t;
	}

	/**
	 * Removes multiple occurances of + from a String concatenation.
	 * 
	 * @param line
	 *            the term
	 * @return the cleaned up term
	 */
	public static String cleanStringConcats(String line) {
		if (!line.contains("\"") && !line.contains("$")) {
			return line;
		}
		if (line.startsWith("+")) {
			line = "\"\"" + line;
		}
		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		int cnt = 0;
		for (int i = 0; i < line.length(); i++) {
			char c = line.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '+') {
					cnt++;
				} else {
					cnt = 0;
				}
				if (cnt <= 1) {
					sb.append(c);
				}
			} else {
				sb.append(c);
				cnt = 0;
			}
		}
		return sb.toString();
	}

	/**
	 * A term doesn't always represent an actual term to calculate. It can be
	 * used as a wrapper for a set of parameters as well. This method returns
	 * all parameters stored in a term tree in the correct order.
	 * 
	 * @param term
	 *            the term
	 * @return the parameters
	 */
	public static List<Atom> getParameters(Term term) {
		List<Atom> results = new ArrayList<Atom>();
		if (term.getLeft() != null) {
			getParameters(term, results);
			if (results.size() == 0) {
				results.add(term);
			}
			Collections.reverse(results);
		}
		return results;
	}

	/**
	 * Checks if an Atom is a number type.
	 * 
	 * @param atom
	 *            the atom
	 * @return true, if it's a number type
	 */
	public static boolean isNumberType(Atom atom) {
		return atom.getType().equals(Type.INTEGER) || atom.getType().equals(Type.REAL);
	}

	/**
	 * Returns the parameters.
	 * 
	 * @param atom
	 *            the atom
	 * @param results
	 *            the results
	 * @return the parameters
	 */
	private static void getParameters(Atom atom, List<Atom> results) {
		if (atom.isTerm()) {
			Term term = (Term) atom;
			boolean addLeft = toAdd(term.getLeft());
			boolean addRight = toAdd(term.getRight());

			if (term.getOperator().isDelimiter()) {
				if (addRight) {
					results.add(term.getRight());
				}
				if (addLeft) {
					results.add(term.getLeft());
				}
			}
			getParameters(term.getLeft(), results);
			getParameters(term.getRight(), results);
		}
	}

	/**
	 * Returns true, if a part of a Term is a parameter and false otherwise.
	 * 
	 * @param atom
	 *            the atom
	 * @return true, if its a parameter
	 */
	private static boolean toAdd(Atom atom) {
		if (atom == null) {
			throw new RuntimeException("Parameter missing!");
		}
		return (!atom.isTerm() || !((Term) atom).getOperator().isDelimiter());
	}

	/**
	 * Creates the terms.
	 * 
	 * @param term
	 *            the term as text
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @param checkForLogicTerm
	 *            if true, logic terms will be checked for as well
	 * @return the term
	 */
	private static Term createTerms(CompilerConfig config, String term, Map<String, Term> termMap, Machine machine, boolean checkForLogicTerm) {
		try {
			int start = 0;
			boolean open = false;
			boolean inString = false;

			for (int i = 0; i < term.length(); i++) {
				char c = term.charAt(i);
				if (c == '"') {
					inString = !inString;
				}
				if (!inString || i == term.length() - 1) {
					if (c == '(') {
						open = true;
						start = i;
					}

					if (c == ')') {
						// Sadly, it's allowed in CBM Basic that Strings aren't
						// terminated
						// properly. This deals with this by adding an artifical
						// quote to where it belongs.
						if (inString) {
							c = '"';
							term = term.substring(0, i) + c + term.substring(i);
							inString = false;
							continue;
						}

						if (open) {
							String sub = term.substring(start + 1, i);
							boolean logic = checkForLogicTerm && LogicParser.isLogicTerm(sub);
							Term res = null;
							if (!logic) {
								res = createTerm(config, sub, termMap, machine);
							} else {
								res = createLogicTerm(config, sub, termMap, machine);
							}
							if (res != null) {
								String termKey = null;
								int index = termMap.size();
								if (res.getKey() == null) {
									termKey = "{t" + index + "}";
								} else {
									termKey = res.getKey();
								}
								res.setKey(termKey);
								termMap.put(termKey, res);
								term = term.substring(0, start) + termKey + term.substring(i + 1);
								if (term.equals(termKey)) {
									break;
								}
							}
							open = false;
							i = -1;
						} else {
							throw new RuntimeException("Parse error in: " + term + "/" + start + "/" + i);
						}
					}
				}
			}

			Term finalTerm = new Term(term, termMap);
			termMap.put("final", finalTerm);
			finalTerm = build(config, finalTerm, termMap, machine);
			finalTerm.setKey("final");
			if (!finalTerm.isComplete()) {
				// System.out.println("Completing: "+finalTerm.getLeft()+"/"+finalTerm.getOperator());
				finalTerm.setOperator(Operator.NOP);
				finalTerm.setRight(new Constant<Integer>(0));
			}
			finalTerm = ConstantFolder.foldConstants(config, TermOptimizer.optimizeTermTree(finalTerm, machine), machine);
			return finalTerm;
		} catch (NumberFormatException nfe) {
			nfe.printStackTrace();
			throw new RuntimeException("Syntax error: " + term);
		}
	}

	/**
	 * Creates a logic term.
	 * 
	 * @param term
	 *            the term as text
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @return the logic term
	 */
	private static Term createLogicTerm(CompilerConfig config, String term, Map<String, Term> termMap, Machine machine) {
		String termWoBrackets = term.replace("(", "").replace(")", "");
		if (isTermPlaceholder(termWoBrackets)) {
			return termMap.get(termWoBrackets);
		}
		String sterm = Parser.replaceStrings(term, '_');
		if (!sterm.contains("(") && !sterm.contains(")")) {
			Term t = new Term(term, termMap);
			LogicTerm logicTerm = LogicParser.getTerm(config, term, machine, termMap);
			t.setLeft(logicTerm);
			if (!t.isComplete()) {
				t.setOperator(Operator.NOP);
				t.setRight(new Constant<Integer>(0));
			}
			return t;
		}
		return null;
	}

	/**
	 * Creates a term.
	 * 
	 * @param term
	 *            the term as text
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @return the term
	 */
	private static Term createTerm(CompilerConfig config, String term, Map<String, Term> termMap, Machine machine) {
		// Check if it's only a wrapped placeholder. In this case, brackets in
		// Strings will be replaced as well, but that doesn't matter here.
		String termWoBrackets = term.replace("(", "").replace(")", "");
		if (isTermPlaceholder(termWoBrackets)) {
			return termMap.get(termWoBrackets);
		}
		String mTerm = Parser.replaceStrings(term, '.');
		if (!mTerm.contains("(") && !mTerm.contains(")")) {
			term = cleanStringConcats(term);
			Term t = new Term(term, termMap);
			t = build(config, t, termMap, machine);
			// System.out.println(term+": "+t.getLeft()+" # "+t.getOperator() +
			// " # "+t.getRight());
			if (!t.isComplete()) {
				t.setOperator(Operator.NOP);
				t.setRight(new Constant<Integer>(0));
			}
			return t;
		}
		return null;
	}

	/**
	 * Builds the actual term content of a prefilled term.
	 * 
	 * @param t
	 *            the prefilled term
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @return the final term
	 */
	private static Term build(CompilerConfig config, Term t, Map<String, Term> termMap, Machine machine) {
		String exp = t.getExpression();
		StringBuilder part = new StringBuilder();
		char lastC = '(';
		boolean inString = false;
		for (int i = 0; i < exp.length(); i++) {
			char c = exp.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			boolean isOp = !inString && Operator.isOperator(c);
			boolean appended = false;
			if (!isOp || (c == '-' && (lastC == '(' || Operator.isOperator(lastC)))) {
				part.append(c);
				appended = true;
			}
			if (!appended || (i >= exp.length() - 1)) {
				Atom atom = createAtom(config, part.toString(), termMap, machine);
				part.setLength(0);
				if (t.getLeft() == null) {
					t.setLeft(atom);
				} else if (t.getRight() == null) {
					t.setRight(atom);
				}
			}
			if (isOp && !appended) {
				part.setLength(0);
				if (t.isComplete()) {
					Term nt = new Term(t.getExpression(), termMap);
					nt.setLeft(t);
					t = nt;
				}
				t.setOperator(new Operator(c));
			}

			lastC = c;
		}
		return t;
	}

	/**
	 * Creates an atom from the part of a term. The result can be a constant, a
	 * variable, a function or another term.
	 * 
	 * @param part
	 *            the part
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @return the atom
	 */
	private static Atom createAtom(CompilerConfig config, String part, Map<String, Term> termMap, Machine machine) {
		// Identify functions
		Function function = Parser.getFunction(config, part, termMap, machine);

		// Identify commands
		String strippedPart = Parser.replaceStrings(part, ' ');
		Command command = Parser.getCommand(strippedPart);
		if (command != null && function == null) {
			throw new RuntimeException("Syntax error: " + part + "/" + command.getName());
		}

		if (function != null) {
			return function;
		}

		// String constants
		if (part.startsWith("\"")) {
			if (part.endsWith("\"")) {
				String ct = part.replaceAll("\"", "");
				Atom str = new Constant<String>(ct);
				return str;
			} else {
				throw new RuntimeException("String not terminated: " + part);
			}
		}
		if (part.endsWith("\"")) {
			throw new RuntimeException("String not open: " + part);
		}

		// Numbers
		boolean number = true;
		boolean real = false;
		for (int i = 0; i < part.length(); i++) {
			char c = part.charAt(i);
			if (!Character.isDigit(c) && c != '-' && c != '.') {
				number = false;
				break;
			}
			if (c == '.') {
				real = true;
			}
		}

		if (number) {
			if (real) {
				if (part.equals(".")) {
					part = "0.0";
				}
				Atom fl = new Constant<Float>(Float.valueOf(part));
				return fl;
			} else {
				if (part.isEmpty()) {
					// Actually, this isn't correct. We might as well throw a
					// syntax error here, but it's handled on another location
					// anyway with better error reporting, so...
					part = "0";
				}
				Atom in = new Constant<Integer>(Integer.valueOf(part));
				return in;
			}
		}

		// Terms
		if (part.startsWith("{") && part.endsWith("}")) {
			Term t = termMap.get(part);
			if (t == null) {
				throw new RuntimeException("Unknown term: " + part);
			}
			if (!t.isComplete()) {
				t = build(config, t, termMap, machine);
			}
			return t;
		}

		// Array variables
		if (Character.isLetter(part.charAt(0)) && (part.endsWith("}") || part.endsWith(")"))) {
			String var = VarUtils.toUpper(part);
			int pos = var.replace('{', '(').indexOf("(");
			if (pos == -1) {
				throw new RuntimeException("Invalid array index: " + part);
			}
			String pvar = var.substring(0, pos) + "[]";
			Variable vary = new Variable(pvar, null); // Placeholder
			return Parser.getArrayAccessFunction(config, part, vary, termMap, machine);
		}

		// Variables
		String var = VarUtils.toUpper(part);
		Variable vary = machine.getVariable(var);
		if (vary == null) {
			vary = new Variable(var, (Term) null);
			vary = machine.add(vary);
		}
		return vary;
	}

	/**
	 * Checks if a part of a term is a term placeholder. Placeholders are
	 * inserted at parse time. They represent parts of the term that have
	 * already been evaluated to sub terms.
	 * 
	 * @param txt
	 *            the txt
	 * @return true, if its a term placeholder
	 */
	private static boolean isTermPlaceholder(String txt) {
		return txt.startsWith("{") && txt.indexOf('}') == (txt.length() - 1);
	}

	/**
	 * Sets the postfix if the function has one. This applies to DEF FN
	 * functions only.
	 * 
	 * @param linePart
	 *            the line part
	 * @param fun
	 *            the fun
	 * @param pos
	 *            the pos
	 */
	private static void setPostfix(String linePart, Function fun, int pos) {
		if (fun.hasPostfix()) {
			String funcName = VarUtils.toUpper(linePart.substring(fun.getName().length(), pos));
			if (funcName.length() > 2) {
				funcName = funcName.substring(0, 2);
			}
			fun.setFunctionName(funcName);
		} else {
			if (pos != fun.getName().length()) {
				throw new RuntimeException("Syntax error: " + linePart);
			}
		}
	}

	/**
	 * Cleans the right part of a text from white space, but only if it's not a
	 * DATA command line.
	 * 
	 * @param sb
	 * @return
	 */
	private static String cleanPart(StringBuilder sb) {
		String ret = sb.toString();
		if (VarUtils.toUpper(ret).trim().startsWith("DATA")) {
			// Don't rtrim data lines
			return ret.replaceAll("^\\s*", "");
		}
		return ret.trim();
	}

	/**
	 * Returns the function of that line part.
	 * 
	 * @param linePart
	 *            the line part
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @return the function
	 */
	private static Function getFunction(CompilerConfig config, String linePart, Map<String, Term> termMap, Machine machine) {
		List<Function> functions = FunctionList.getFunctions();
		Function fun = null;

		for (Function function : functions) {
			// System.out.println(linePart);
			if (function.isFunction(linePart)) {
				fun = function.clone();
				int pos = linePart.indexOf('(');
				int pos2 = linePart.lastIndexOf(')');
				if (pos == -1 || pos2 < pos) {
					pos = linePart.indexOf('{');
					pos2 = linePart.indexOf('}');
					if (termMap == null || pos == -1 || pos2 < pos) {
						throw new RuntimeException("Invalid function call: " + linePart);
					} else {
						setPostfix(linePart, fun, pos);
						fun.setTerm(Parser.createTerm(config, linePart.substring(pos, pos2 + 1), termMap, machine));
					}
				} else {
					setPostfix(linePart, fun, pos);
					fun.parse(config, linePart.substring(pos + 1, pos2), machine);
				}
				break;
			}
		}

		return fun;
	}

	private static void checkForInvalidChars(String term) {
		boolean inString = false;
		for (int i = 0; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if ("&!|~?'§{}[]°".indexOf(c) != -1) {
					throw new RuntimeException("Syntax error: " + term + "/" + c);
				}
			}
		}
	}
}
