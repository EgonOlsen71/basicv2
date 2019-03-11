package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * A pattern definition that can be used in an optimizer.
 * 
 * @author EgonOlsen
 * 
 */
public class Pattern {
    private List<String> pattern;
    private List<Integer> spacePos;
    private List<Integer> partRightP0;
    private List<Integer> partRightP1;
    private List<String> command;
    private List<String> partP0;
    private List<Boolean> isJump;
    private List<String> partRights;
    private List<String> partRightsReg;
    private List<String> partLefts;
    private int pos = 0;
    private String[] regs = new String[10];
    private String[] mems = new String[10];
    private String[] consts = new String[10];
    private String[] replacement;
    private int index = -1;
    private int end = -1;
    private String name;
    private boolean looseTypes = false;
    private boolean simple = true;
    private int loopCnt = 0;

    /**
     * Creates a new pattern.
     * 
     * @param name
     *            the (descriptive) name of the pattern
     * @param replacement
     *            the replacement code
     * @param parts
     *            the code to be replaced
     */
    public Pattern(String name, String[] replacement, String... parts) {
	pattern = new ArrayList<>(Arrays.asList(parts));
	spacePos = new ArrayList<>();
	command = new ArrayList<>();
	isJump = new ArrayList<>();
	partP0 = new ArrayList<>();
	partRights = new ArrayList<>();
	partRightP0 = new ArrayList<>();
	partRightP1 = new ArrayList<>();
	partLefts = new ArrayList<>();
	partRightsReg = new ArrayList<>();
	for (String part : pattern) {
	    int p0 = part.indexOf(" ");
	    spacePos.add(p0);
	    String ft = part.substring(0, 3);
	    command.add(ft);
	    partP0.add(p0 != -1 ? part.substring(0, p0) : null);
	    String pr = part.substring(p0 + 1).trim();
	    partRights.add(pr);
	    int prP0 = pr.indexOf("{");
	    partRightP0.add(prP0);
	    partLefts.add(prP0 != -1 ? pr.substring(0, prP0) : null);
	    int prP1 = pr.lastIndexOf("}");
	    partRightP1.add(prP1);
	    partRightsReg.add((prP1 != -1 && prP0 != -1) ? pr.substring(prP0 + 1, prP1) : null);
	    isJump.add(ft.equals("JSR") || ft.equals("JMP") || ft.equals("BEQ") || ft.endsWith("JMP")
		    || ft.equals("BNE") || ft.equals("BCC") || ft.equals("BCS"));
	}
	this.replacement = replacement;
	this.name = name;
    }

    /**
     * Creates a new pattern.
     * 
     * @param simple
     *            if true, the pattern will be applied just once
     * @param name
     *            the (descriptive) name of the pattern
     * @param replacement
     *            the replacement code
     * @param parts
     *            the code to be replaced
     */
    public Pattern(boolean simple, String name, String[] replacement, String... parts) {
	this(name, replacement, parts);
	this.simple = simple;
    }

    /**
     * Creates a new pattern.
     * 
     * @param name
     *            the (descriptive) name of the pattern
     * @param looseTypes
     *            if true, the pattern will be applied only if the platform
     *            allows for loose typing
     * @param replacement
     *            the replacement code
     * @param parts
     *            the code to be replaced
     */
    public Pattern(String name, boolean looseTypes, String[] replacement, String... parts) {
	this(name, replacement, parts);
	this.looseTypes = looseTypes;
    }

    /**
     * Returns the current position in the pattern, i.e. up to which command
     * does the pattern match the current code.
     * 
     * @return the position
     */
    public int getPos() {
	return pos;
    }

    /**
     * Returns the name of the pattern.
     * 
     * @return the name
     */
    public String getName() {
	return name;
    }

    /**
     * Applies the pattern, i.e. the matching parts in the code will be replaced
     * by the replacement code.
     * 
     * @param code
     *            the input code
     * @return the optimized code
     */
    public List<String> apply(List<String> code) {
	if (pos == pattern.size()) {
	    List<String> first = code.subList(0, index);
	    List<String> last = code.subList(end + 1, code.size());
	    String[] replacement = null;
	    boolean cntInc = false;
	    if (this.replacement != null) {
		replacement = Arrays.copyOf(this.replacement, this.replacement.length);
		List<String> sub = new ArrayList<String>();
		for (String subline : code.subList(index, end + 1)) {
		    if (!subline.startsWith(";")) {
			sub.add(subline);
		    }
		}
		for (int i = 0; i < replacement.length; i++) {
		    if (replacement[i].startsWith("{LINE")) {
			String postFix = "";
			if (!replacement[i].endsWith("}")) {
			    int pos = replacement[i].indexOf("}");
			    postFix = replacement[i].substring(pos + 1);
			    replacement[i] = replacement[i].substring(0, pos + 1);
			}
			int num = Integer.parseInt(replacement[i].substring(5, replacement[i].length() - 1));
			replacement[i] = sub.get(num) + postFix;
		    } else {
			int pos = replacement[i].indexOf("{REG");
			if (pos != -1) {
			    replace(replacement, i, pos, 4, regs);
			} else {
			    pos = replacement[i].indexOf("{CONST");
			    if (pos != -1) {
				replace(replacement, i, pos, 6, consts);
			    } else {
				pos = replacement[i].indexOf("{MEM");
				if (pos != -1) {
				    replace(replacement, i, pos, 4, mems);
				} else {
				    pos = replacement[i].indexOf("{cnt}");
				    if (pos != -1) {
					if (!cntInc) {
					    cntInc = true;
					    loopCnt++;
					}
					replacement[i] = replacement[i].replace("{cnt}", "" + loopCnt);
				    }
				}
			    }
			}
		    }
		}
	    }
	    List<String> eternity = replacement != null ? new ArrayList<String>(Arrays.asList(replacement))
		    : new ArrayList<String>();
	    eternity.add("; Optimizer rule: " + name + "/" + (replacement == null ? 0 : replacement.length));
	    List<String> res = new ArrayList<>(first);
	    res.addAll(eternity);
	    res.addAll(last);
	    resetPattern();
	    return res;
	}
	resetPattern();
	return code;
    }

    /**
     * Returns true, if the pattern matches with code at the current position.
     * 
     * @param line
     *            the line of code to test against
     * @param ix
     *            the index into the code
     * @param const2Value
     *            a mapping from constants to their values
     * @return does it match?
     */
    public boolean matches(String line, int ix, Map<String, Number> const2Value) {
	if (line.startsWith(";")) {
	    return false;
	}

	String part = pattern.get(pos);

	int p0 = spacePos.get(pos);
	int p1 = line.indexOf(" ");
	if (p0 == -1 && p1 == -1 && part.equalsIgnoreCase(line)) {
	    return inc(ix);
	}
	if (part.equals("{LABEL}") && line.endsWith(":")) {
	    return inc(ix);
	}

	String ft = command.get(pos);
	if (isJump.get(pos)) {
	    if (part.endsWith("{*}") && line.startsWith(ft)) {
		String stripped = part.replaceFirst(ft, "").trim().replace("{*}", "").trim();
		String sline = line.replaceFirst(ft, "").trim();
		if (stripped.isEmpty() || sline.startsWith(stripped)) {
		    return inc(ix);
		}
	    }
	}

	if (p0 != -1 && p1 != -1 && !line.contains("SKIP")) {
	    if (partP0.get(pos).equalsIgnoreCase(line.substring(0, p1))) {
		String partRight = partRights.get(pos);
		String lineRight = line.substring(p1 + 1).trim();
		if (partRight.equalsIgnoreCase(lineRight)) {
		    return inc(ix);
		} else {
		    p0 = partRightP0.get(pos);
		    if (p0 != -1) {
			String leftPart = partLefts.get(pos);
			if (lineRight.startsWith(leftPart)) {
			    p1 = partRightP1.get(pos);
			    String reg = partRightsReg.get(pos);
			    if (reg.equals("*")) {
				return inc(ix);
			    } else {
				if (reg.startsWith("#")) {
				    String num = reg.substring(1);
				    boolean isReal = num.contains(".");
				    float val = Float.parseFloat(num);
				    if (!isReal) {
					val = (int) val;
				    }
				    int pos = lineRight.indexOf("CONST_");
				    if (lineRight.equals(reg)
					    || (pos != -1 && const2Value.containsKey(lineRight.substring(pos))
						    && const2Value.get(lineRight.substring(pos)).floatValue() == val)) {
					return inc(ix);
				    }
				    return resetPattern();
				} else {
				    String value = lineRight.substring(p0);
				    if (reg.startsWith("REG") && lineRight.contains("_REG")) {
					int num = Integer.parseInt(reg.substring(3));
					int pv = value.lastIndexOf("+");
					if (pv != -1) {
					    value = value.substring(0, pv);
					}
					if (regs[num] == null) {
					    regs[num] = value;
					    return inc(ix);
					} else {
					    if (regs[num].equalsIgnoreCase(value)) {
						return inc(ix);
					    } else {
						return resetPattern();
					    }
					}
				    } else {
					if (reg.startsWith("MEM") && (lineRight.contains("VAR_")
						|| lineRight.contains("CONST_") || isNumber(lineRight))) {
					    int pv = value.lastIndexOf("+");
					    if (pv != -1) {
						value = value.substring(0, pv);
					    }
					    int num = Integer.parseInt(reg.substring(3));
					    if (mems[num] == null) {
						mems[num] = value;
						return inc(ix);
					    } else {
						if (mems[num].equalsIgnoreCase(value)) {
						    return inc(ix);
						} else {
						    return resetPattern();
						}
					    }
					} else if (reg.startsWith("CONST") && lineRight.contains("CONST_")) {
					    int pv = value.lastIndexOf("+");
					    if (pv != -1) {
						value = value.substring(0, pv);
					    }
					    int num = Integer.parseInt(reg.substring(5));
					    if (consts[num] == null) {
						consts[num] = value;
						return inc(ix);
					    } else {
						if (consts[num].equalsIgnoreCase(value)) {
						    return inc(ix);
						} else {
						    return resetPattern();
						}
					    }
					} else {
					    return resetPattern();
					}
				    }
				}
			    }
			} else {
			    return resetPattern();
			}
		    } else {
			return resetPattern();
		    }
		}
	    }
	}
	return resetPattern();
    }

    private void replace(String[] replacement, int i, int pos, int offset, String[] values) {
	int endi = replacement[i].indexOf("}");
	int posi = Integer.parseInt(replacement[i].substring(pos + offset, endi));
	String fp = replacement[i].substring(0, pos);
	if (!fp.endsWith("#<") && !fp.endsWith("#>")) {
	    fp = fp + " ";
	}
	replacement[i] = fp + values[posi]
		+ ((endi < replacement[i].length() - 1) ? replacement[i].substring(endi + 1) : "");
    }

    private boolean isNumber(String lineRight) {
	for (int i = 0; i < lineRight.length(); i++) {
	    char c = lineRight.charAt(i);
	    if (c < '0' || c > '9') {
		return false;
	    }
	}
	return true;
    }

    private boolean resetPattern() {
	pos = 0;
	index = -1;
	end = -1;
	clearArray(regs);
	clearArray(mems);
	clearArray(consts);
	return false;
    }

    private void clearArray(String[] array) {
	for (int i = 0; i < array.length; i++) {
	    array[i] = null;
	}
    }

    private boolean inc(int ix) {
	pos++;
	if (index == -1) {
	    index = ix;
	}
	end = ix;
	return pos == pattern.size();
    }

    public boolean isLooseTypes() {
	return looseTypes;
    }

    public void setLooseTypes(boolean looseTypes) {
	this.looseTypes = looseTypes;
    }

    public boolean isSimple() {
	return simple;
    }

    public void setSimple(boolean simple) {
	this.simple = simple;
    }

    public int getSourceSize() {
	return pattern.size();
    }

}
