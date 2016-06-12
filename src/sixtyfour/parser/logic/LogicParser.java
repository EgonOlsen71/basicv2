package sixtyfour.parser.logic;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;

public class LogicParser {

	public static boolean isLogicTerm(String term) {
		term = replaceStrings(term, ' ');
		return (term.contains("AND") || term.contains("OR") || term.contains("NOT") || term.contains("=") || term.contains(">") || term.contains("<"));
	}

	public static LogicTerm getTerm(String term, Machine machine) {
		Map<String, LogicTerm> blocks = new HashMap<String, LogicTerm>();

		boolean inString = false;
		term = "(" + Parser.removeWhiteSpace(term) + ")";
		Parser.checkBrackets(term);
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
					String part = term.substring(i, end + 1);

					String partS = stripStrings(part);

					//System.out.println("Part: " + part + "/" + partS + "/" + lastPart);

					boolean brackets = partS.contains("(");
					if ((partS.contains("OR") || partS.contains("AND")) && brackets) {
						lastPart = part;
						lastStart = i;
						continue;
					}

					if (!brackets && !(partS.contains("OR") || partS.contains("AND"))) {
						continue;
					}
				} else if (i == term.length() - 1) {
					String toProcess = lastPart;
					int startPos = lastStart;
					String blockName = createLogicBlock(toProcess.substring(1, toProcess.length() - 1), blocks, machine);
					int endy = Math.min(startPos + toProcess.length(), term.length());
					term = term.substring(0, startPos) + blockName + (endy != term.length() ? term.substring(endy, term.length()) : "");
					i = -1;
					inString = false;
					lastPart = term;
					lastStart = 0;

					//System.out.println("TERM: " + term);

					String nbrack = term.replace("(", "").replace(")", "");
					if (blocks.containsKey(nbrack)) {
						return blocks.get(nbrack);
					}
				}
			}
		}
		throw new RuntimeException("Syntax error: " + term);
	}

	public static String replaceStrings(String term, char toReplaceWith) {
		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		for (int i = 0; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
				if (inString) {
					sb.append('"');
				}
			}
			if (!inString) {
				sb.append(c);
			} else {
				sb.append(toReplaceWith);
			}
		}
		return sb.toString().toUpperCase(Locale.ENGLISH);
	}

	private static String createLogicBlock(String toProcess, Map<String, LogicTerm> blocks, Machine machine) {

		//System.out.println("To process: " + toProcess);

		String[] delims = { "OR", "AND" };
		String utp = toProcess.toUpperCase(Locale.ENGLISH);
		int curPos = 0;
		String minOp = null;
		LogicTerm block = new LogicTerm("{l" + blocks.size() + "}");
		do {
			int minPos = 999999999;
			minOp = null;
			for (String delim : delims) {
				int pos = utp.indexOf(delim, curPos);
				if (pos != -1 && pos < minPos) {
					minPos = pos;
					minOp = delim;
				}
			}

			//System.out.println(minPos + "/" + minOp + "/" + curPos);

			String part = toProcess.substring(curPos);
			LogicOp op = new LogicAnd();
			if (minOp != null) {

				if (minOp.equals("OR")) {
					op = new LogicOr();
				}
				part = toProcess.substring(curPos, minPos);
				curPos = minPos + minOp.length();
			}

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
			boolean not = false;

			if (closest != -1) {
				left = part.substring(0, closest);
				right = part.substring(closest);
				comp = Comparator.getComparator(right);
				if (comp == null) {
					throw new RuntimeException("Syntax error: " + part);
				}
				right = right.substring(comp.getTermLength());

				boolean nt = false;
				do {
					nt = left.toUpperCase(Locale.ENGLISH).startsWith("NOT");
					if (nt) {
						left = left.substring(3);
						not = !not;
					}
				} while (nt);

			} else {
				if (part.contains("}")) {
					part = part.replace("(", "").replace(")", "");

					boolean nt = false;
					do {
						nt = part.toUpperCase(Locale.ENGLISH).startsWith("NOT");
						if (nt) {
							part = part.substring(3);
							not = !not;
						}
					} while (nt);
					if (!part.startsWith("{")) {
						throw new RuntimeException("Syntax error: " + part);
					}

					LogicTerm lt = blocks.get(part);
					if (not) {
						lt.not();
					}
					block.add(lt, op);
				} else {
					left = part;
					right = null;
					comp = Comparator.EQUAL;
				}
			}

			//System.out.println("Terms:" + left + " " + comp + " " + right + "/" + not);

			if (left != null) {
				Comparison compy = new Comparison();
				compy.setComparator(comp);

				int bl = getBracketDelta(left);
				if (bl > 0) {
					// This will destroy the term if the brackets are not at the
					// beginning. But then again, the term is wrong that way
					// anyway...
					left = left.substring(bl);
				}
				compy.setLeft(Parser.getTerm(left, machine, false));
				if (right != null) {
					int br = getBracketDelta(right);
					if (br < 0) {
						right = right.substring(0, right.length() + br);
					}
					compy.setRight(Parser.getTerm(right, machine, false));
				}
				if (not) {
					compy.not();
				}

				//System.out.println("Setted: " + left + " - " + right + "/" + not);
				block.add(compy, op);
			}

		} while (minOp != null);
		blocks.put(block.getName(), block);
		return block.getName();
	}

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

	private static String stripStrings(String term) {
		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		for (int i = 1; i < term.length() - 1; i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
				if (inString) {
					sb.append('"');
				}
			}
			if (!inString) {
				sb.append(c);
			}
		}
		return sb.toString().toUpperCase(Locale.ENGLISH);
	}

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
