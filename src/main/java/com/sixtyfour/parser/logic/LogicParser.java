/*
 * 
 */
package com.sixtyfour.parser.logic;

import java.util.HashMap;
import java.util.Map;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.Checker;

/**
 * A parser for logic terms.
 */
public class LogicParser {

	/**
	 * Checks if a term is a logic term.
	 * 
	 * @param term the term
	 * @return true, if it's a logic term
	 */
	public static boolean isLogicTerm(String term) {
		term = Parser.replaceStrings(term, ' ');
		return term.contains("=") || term.contains(">") || term.contains("<");
	}

	/**
	 * Returns the logic term that represents the term in the text.
	 * 
	 * @param term    the term as text
	 * @param machine the machine
	 * @param termMap the term map
	 * @return the logic term
	 */
	public static LogicTerm getTerm(CompilerConfig config, String term, Machine machine, Map<String, Term> termMap) {
		Map<String, LogicTerm> blocks = new HashMap<String, LogicTerm>();
		term = processLogicOperations(term);
		boolean inString = false;
		term = "(" + TermEnhancer.removeWhiteSpace(term) + ")";
		TermEnhancer.checkBrackets(term);
		String lastPart = term;
		int lastStart = 0;

		for (int i = 0; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '(') {
					int end = findEndBracket(term, i);
					if (end <= i + 1) {
						throw new RuntimeException("Syntax error: " + term);
					}
					/*
					 * String part = term.substring(i, end + 1);
					 * 
					 * String partS = stripStrings(part);
					 * 
					 * boolean brackets = partS.contains("("); if ((partS.contains("OR") ||
					 * partS.contains("AND")) && brackets) { lastPart = part; lastStart = i;
					 * continue; }
					 * 
					 * if (!brackets && !(partS.contains("OR") || partS.contains("AND"))) {
					 * continue; }
					 */
				} else if (i == term.length() - 1) {
					String toProcess = lastPart;
					int startPos = lastStart;
					String subt = toProcess.substring(1, toProcess.length() - 1);
					String blockName = createLogicBlock(config, subt, blocks, machine, termMap);
					int endy = Math.min(startPos + toProcess.length(), term.length());
					term = term.substring(0, startPos) + blockName
							+ (endy != term.length() ? term.substring(endy, term.length()) : "");
					i = -1;
					inString = false;
					lastPart = term;
					lastStart = 0;

					String nbrack = term.replace("(", "").replace(")", "");
					if (blocks.containsKey(nbrack)) {
						return blocks.get(nbrack);
					}
				}
			}
		}
		throw new RuntimeException("Syntax error: " + term);
	}

	/**
	 * Processes logic operations.
	 * 
	 * @param term the term
	 * @return the string
	 */
	private static String processLogicOperations(String term) {
		// Try to replace logic operations in brackets by placeholders to avoid
		// parser confusion...

		// TODO Replace by something more sophisticated...
		// To the left...
		String[] reps = { ")=", ")>", ")<" };
		for (String rep : reps) {
			int pos = 0;
			do {
				pos = term.indexOf(rep, pos);
				if (pos != -1) {
					boolean inString = false;
					int brackets = 0;
					for (int i = pos; i >= 0; i--) {
						char c = term.charAt(i);
						if (c == '"') {
							inString = !inString;
						}
						if (!inString) {
							if (c == ')') {
								brackets--;
							} else if (c == '(') {
								brackets++;
								if (brackets == 0) {
									String part = term.substring(i, pos + 1);
									String partn = TermEnhancer.replaceLogicOperators(part);
									term = term.substring(0, i) + partn + term.substring(pos + 1);
									pos = pos - (part.length() - partn.length());
									break;
								}
							}
						}
					}
					pos += 2;
				}
			} while (pos != -1);
		}

		// And to the right...
		reps = new String[] { "=(", ">(", "<(" };
		for (String rep : reps) {
			int pos = 0;
			do {
				pos = term.indexOf(rep, pos);
				if (pos != -1) {
					boolean inString = false;
					int brackets = 0;
					for (int i = pos; i < term.length(); i++) {
						char c = term.charAt(i);
						if (c == '"') {
							inString = !inString;
						}
						if (!inString) {
							if (c == ')') {
								brackets--;
								if (brackets == 0) {
									String part = term.substring(pos, i + 1);
									String partn = TermEnhancer.replaceLogicOperators(part);
									term = term.substring(0, pos) + partn + term.substring(i + 1);
									pos = pos - (part.length() - partn.length());
									break;
								}
							} else if (c == '(') {
								brackets++;
							}
						}
					}
					pos += 2;
				}
			} while (pos != -1);
		}

		return term;
	}

	/**
	 * Creates a logic block. A logic block is similar to a Term but for logic
	 * operations.
	 * 
	 * @param toProcess the text to process
	 * @param blocks    the current blocks
	 * @param machine   the machine
	 * @param termMap   the term map
	 * @return the name of the block
	 */

	private static String createLogicBlock(CompilerConfig config, String toProcess, Map<String, LogicTerm> blocks,
			Machine machine, Map<String, Term> termMap) {
		// This has been greatly modified to handle not(a<2 and a>3) and similar code.
		// In that processs, I've noticed that only the IF-Parser used this method
		// directly.
		// All other calls are for much more simpler terms like i>5 or z=z...nothing
		// complex anymore
		// because that will be handled earlier by adding proper brackets. So I removed
		// most of the old stuff from this method and hope for the best.
		LogicTerm block = new LogicTerm("{l" + blocks.size() + "}");
		String part = toProcess;

		boolean inString = false;
		int closest = -1;
		for (int i = 0; i < part.length(); i++) {
			char c = part.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '<' || c == '>' || c == '=') {
					closest = i;
					break;
				}
			}
		}

		String left = null;
		String right = null;
		Comparator comp = null;

		if (closest != -1) {
			left = part.substring(0, closest);
			right = part.substring(closest);

			comp = Comparator.getComparator(right);
			if (comp == null) {
				throw new RuntimeException("Syntax error: " + part);
			}
			right = right.substring(comp.getTermLength());
		} else {
			throw new RuntimeException("Syntax error: " + part);
		}

		if (left != null) {
			block.setComparator(comp);
			int bl = getBracketDelta(left);
			// This should not happen anymore...well, anyway...
			if (bl > 0) {
				left = left.substring(bl);
			} else if (bl < 0) {
				left = left.substring(0, left.length() + bl);
			}
			block.setLeft(Parser.getTerm(config, left, machine, false, true, termMap));
			if (right != null) {
				int br = getBracketDelta(right);
				// This should not happen anymore...well, anyway...
				if (br < 0) {
					right = right.substring(0, right.length() + br);
				}
				block.setRight(Parser.getTerm(config, right, machine, false, true, termMap));
				checkTypeMismatch(block);
			}
		}
		blocks.put(block.getName(), block);
		return block.getName();
	}

	private static void checkTypeMismatch(LogicTerm compy) {
		if (Checker.isTypeMismatch(compy)) {
			Type lt = compy.getLeft().getType(true);
			Type rt = compy.getRight().getType(true);
			throw new RuntimeException(
					"Type mismatch error: " + lt + " | " + rt + " --- " + compy.getLeft() + " --- " + compy.getRight());
		}
	}

	/**
	 * Calculates the difference in the number of opening and closing brackets.
	 * 
	 * @param term the term
	 * @return the difference
	 */
	private static int getBracketDelta(String term) {
		int brackets = 0;
		boolean inString = false;
		for (int i = 0; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '(') {
					brackets++;
				} else if (c == ')') {
					brackets--;
				}
			}
		}
		return brackets;
	}

	/**
	 * Finds the end bracket starting at the current position.
	 * 
	 * @param term the term
	 * @param pos  the current position
	 * @return the position of the end bracket
	 */
	private static int findEndBracket(String term, int pos) {
		int brackets = 0;
		boolean inString = false;
		for (int i = pos; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '(') {
					brackets++;
				} else if (c == ')') {
					brackets--;
					if (brackets == 0) {
						return i;
					}
				}
			}
		}
		if (brackets == 0) {
			return term.length();
		}
		throw new RuntimeException("Syntax error: " + term);

	}

}
