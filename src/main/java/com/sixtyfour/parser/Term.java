package com.sixtyfour.parser;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.Checker;
import com.sixtyfour.util.Jitted;

/**
 * A Term is a (part of a) calculation or a logical operation. Terms have two
 * children (left and right) and an operator that connects the two.
 */
public class Term implements Atom {

	private static int termId;

	/** The left child */
	private Atom left;

	/** The right child */
	private Atom right;

	/** The operator that connects the two children */
	private Operator operator;

	/** The expression that created this Term */
	private String expression;

	/** The initial expression that this term was based on */
	private String initial;

	/** The key for term replacement while parsing */
	private String key;

	/** The type that the Term returns */
	private Type type;

	private int id = termId++;

	private int callCount = 0;

	private Method jittedMethod = null;

	private Jitted jittedInstance = null;

	private boolean jitRun = false;

	private boolean constant = false;
	
	// If true, the term is valid and doesn't have to be checked for unwanted chars anymore.
	// Should be true only for array index terms
	private boolean sealed = false;

	/**
	 * Instantiates a new term based on the given expression.
	 * 
	 * @param expression the expression
	 * @param termMap    the current term mapping
	 */
	public Term(String expression, Map<String, Term> termMap) {
		this.setExpression(expression);
		this.setInitial(expression, termMap);
	}

	/**
	 * Instantiates a new term with an Atom as left child and a 0 as the right
	 * child. The operator is a NOP.
	 * 
	 * @param left the left child
	 */
	public Term(Atom left) {
		this.left = left;
		this.operator = Operator.NOP;
		this.right = new Constant<Integer>(0);
	}

	/**
	 * Checks if the Term is complete. A complete term has two children and an
	 * operator.
	 * 
	 * @return true, if it's complete
	 */
	public boolean isComplete() {
		return left != null && right != null && operator != null;
	}

	/**
	 * Checks if the term is empty.
	 * 
	 * @return true, if it's empty
	 */
	public boolean isEmpty() {
		return left == null || (left.isTerm() && ((Term) left).isEmpty());
	}

	/**
	 * Returns the left child.
	 * 
	 * @return the left child
	 */
	public Atom getLeft() {
		return left;
	}

	/**
	 * Sets the left child.
	 * 
	 * @param left the new left child
	 */
	public void setLeft(Atom left) {
		this.left = left;
	}

	/**
	 * Returns the right child.
	 * 
	 * @return the right child
	 */
	public Atom getRight() {
		return right;
	}

	/**
	 * Sets the right child.
	 * 
	 * @param right the new right child
	 */
	public void setRight(Atom right) {
		this.right = right;
	}

	/**
	 * Returns the operator.
	 * 
	 * @return the operator
	 */
	public Operator getOperator() {
		return operator;
	}

	/**
	 * Sets the operator.
	 * 
	 * @param operator the new operator
	 */
	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	/**
	 * Returns the expression.
	 * 
	 * @return the expression
	 */
	public String getExpression() {
		return expression;
	}

	/**
	 * Sets the expression.
	 * 
	 * @param expression the new expression
	 */
	public void setExpression(String expression) {
		this.expression = expression;
	}

	/**
	 * Returns the key. The key is used for internal replacement of parts of a term
	 * (as text) by placeholders.
	 * 
	 * @return the key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * Sets the key. The key is used for internal replacement of parts of a term (as
	 * text) by placeholders.
	 * 
	 * @param key the new key
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "([" + key + "]" + (constant ? "!" : "") + "\\l:" + left + "/" + this.operator + "\\r:" + right + ")";
	}

	@Override
	public Type getType() {
		return getType(false);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType(boolean ignoreMT) {

		if (type != null) {
			return type;
		}
		if (left == null) {
			throw new RuntimeException("Syntax error: " + this.toString());
		}
		Type t1 = left.getType();
		Type t2 = t1;
		if (operator != Operator.NOP) {
			t2 = right.getType();
		}

		if (operator.isDelimiter()) {
			return t1;
		}
		if (t1.equals(Type.INTEGER) && t2.equals(Type.REAL)) {
			return t2;
		}
		if (t1.equals(Type.REAL) && t2.equals(Type.INTEGER)) {
			return t1;
		}
		if (!t1.equals(t2)) {
			if (ignoreMT) {
				return Type.INTEGER;
			}
			if (Checker.isTypeMismatch(this)) {
				throw new RuntimeException("Type mismatch error: " + this.toString() + " | " + left + " | " + right
						+ " | " + t1 + "/" + t2 + "/" + operator.getType());
			}
		}
		type = t1;
		return t1;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<String> ret = new ArrayList<String>();
		List<CodeContainer> cc = new ArrayList<CodeContainer>();

		if (operator.isNop()) {
			if (left == null) {
				throw new RuntimeException("Syntax error!");
			}
			return left.evalToCode(config, machine);
		}
		Type type = getType(true);
		if (type == Type.STRING) {
			if (operator.isPlus()) {
				List<String> s1 = left.evalToCode(config, machine).get(0).getExpression();
				List<String> s2 = right.evalToCode(config, machine).get(0).getExpression();
				ret.add(0, "_");
				s2.add(0, ":.");
				ret.addAll(0, s1);
				ret.addAll(0, s2);
				cc.add(new CodeContainer(ret));
				return cc;
			}
		} else {

			List<String> n1 = left.evalToCode(config, machine).get(0).getExpression();
			List<String> n2 = right.evalToCode(config, machine).get(0).getExpression();

			if (n1 == null || n2 == null) {
				throw new RuntimeException("Unknown function name: " + this.getExpression());
			}

			switch (operator.getType()) {
			case 0:
				ret.add(0, "_");
				n2.add(0, ":^");
				ret.addAll(0, n1);
				ret.addAll(0, n2);
				break;
			case 1:
				ret.add(0, "_");
				n2.add(0, ":*");
				ret.addAll(0, n1);
				ret.addAll(0, n2);
				break;
			case 2:
				ret.add(0, "_");
				n2.add(0, ":/");
				ret.addAll(0, n1);
				ret.addAll(0, n2);
				break;
			case 3:
				ret.add(0, "_");
				n2.add(0, ":+");
				ret.addAll(0, n1);
				ret.addAll(0, n2);
				break;
			case 4:
				ret.add(0, "_");
				n2.add(0, ":-");
				ret.addAll(0, n1);
				ret.addAll(0, n2);
				break;
			case 5:
				break;
			case 6:
				break;
			case 7:
				ret.add(0, "_");
				n2.add(0, ":|");
				ret.addAll(0, n1);
				ret.addAll(0, n2);
				break;
			case 8:
				ret.add(0, "_");
				n2.add(0, ":&");
				ret.addAll(0, n1);
				ret.addAll(0, n2);
				break;
			case 9:
				ret.add("_");
				n2.add(":!");
				ret.addAll(0, n2);
				break;
			}
			cc.add(new CodeContainer(ret));
			return cc;
		}
		throw new RuntimeException("Unable to evaluate term to expression: " + this.toString());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		try {
			callCount++;
			machine.setCurrentOperator(operator);
			if (jittedMethod != null) {
				return machine.getJit().call(this);
			}
			if (operator.isNop()) {
				if (left == null) {
					throw new RuntimeException("Syntax error!");
				}
				return left.eval(machine);
			}
			Type type = getType();
			if (type == Type.STRING) {
				if (operator.isPlus()) {
					return left.eval(machine).toString() + right.eval(machine).toString();
				}
			} else {
				Number n1 = (Number) left.eval(machine);
				Number n2 = n1;
				if (left != right) {
					n2 = (Number) right.eval(machine);
				}

				double v1 = 0;
				switch (operator.getType()) {
				case 0:
					v1 = Math.pow(n1.doubleValue(), n2.doubleValue());
					break;
				case 1:
					v1 = n1.doubleValue() * n2.doubleValue();
					break;
				case 2:
					if (n2.doubleValue() == 0) {
						throw new RuntimeException("Division by zero error: " + n1 + "/" + n2);
					}
					v1 = n1.doubleValue() / n2.doubleValue();
					break;
				case 3:
					v1 = n1.doubleValue() + n2.doubleValue();
					break;
				case 4:
					v1 = n1.doubleValue() - n2.doubleValue();
					break;
				case 5:
					break;
				case 6:
					break;
				case 7:
					v1 = n1.intValue() | n2.intValue();
					break;
				case 8:
					v1 = n1.intValue() & n2.intValue();
					break;
				case 9:
					v1 = ~n2.intValue();
					break;
				}
				return v1;
			}
			throw new RuntimeException("Unable to evaluate term: " + this.toString());
		} finally {
			machine.setCurrentOperator(null);
			// TODO Make 20 dependent on something
			if (!jitRun && callCount > 20 && machine.getJit() != null) {
				jitRun = machine.getJit().addMethod(this, machine);
			}
		}
	}

	@Override
	public String toCode(Machine machine) {
		try {
			if (operator.isNop()) {
				if (left == null) {
					throw new RuntimeException("Syntax error!");
				}
				String ls = left.toCode(machine);
				if (ls != null) {
					return filterCode("(" + ls + ")");
				} else {
					return null;
				}
			}
			Type type = getType();
			if (type == Type.STRING) {
				if (operator.isPlus()) {
					String ls = left.toCode(machine);
					String rs = right.toCode(machine);
					if (ls == null || rs == null) {
						return null;
					}
					return filterCode("(" + ls + "+" + rs + ")");
				}
			} else {
				String n1 = left.toCode(machine);
				String n2 = n1;
				if (left != right) {
					n2 = right.toCode(machine);
				}

				if (n1 == null || n2 == null) {
					return null;
				}

				String v1 = "";
				if (operator.isPlus()) {
					v1 = n1 + "+" + n2;
				} else if (operator.isMinus()) {
					v1 = n1 + "-" + n2;
				} else if (operator.isPower()) {
					v1 = "(float) Math.pow(" + n1 + "," + n2 + ")";
				} else if (operator.isMultiplication()) {
					v1 = n1 + "*" + n2;
				} else if (operator.isDivision()) {
					v1 = n1 + "/" + n2;
				} else if (operator.isOr()) {
					v1 = "(int) (" + n1 + ")|" + n2;
				} else if (operator.isAnd()) {
					v1 = "(int) (" + n1 + ")&" + n2;
				} else if (operator.isNot()) {
					v1 = "~(int) (" + n2 + ")";
				}
				return filterCode("(" + v1 + ")");
			}
			return null;
		} finally {
			//
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return true;
	}

	/**
	 * Gets a unique ID for this term.
	 * 
	 * @return the ID
	 */
	public int getId() {
		return id;
	}

	/**
	 * Gets the number of calls for this term.
	 * 
	 * @return the count
	 */
	public int getCallCount() {
		return callCount;
	}

	/**
	 * If this term has been compiled by the JIT compiler, this will return the
	 * Method instance in the compiled code.
	 * 
	 * @return the method instance of null
	 */
	public Method getJittedMethod() {
		return jittedMethod;
	}

	/**
	 * @return
	 */
	public Jitted getJittedInstance() {
		return jittedInstance;
	}

	/**
	 * @param jittedInstance
	 */
	public void setJittedInstance(Jitted jittedInstance) {
		this.jittedInstance = jittedInstance;
	}

	/**
	 * Gets the initial term.
	 * 
	 * @return the term
	 */
	public String getInitial() {
		return initial;
	}

	/**
	 * Gets the initial term, but truncated to first actual parameter.
	 * 
	 * @return the truncated term
	 */
	public String getTruncatedInitial() {
		String ini = this.initial;
		boolean inString = false;
		int brackets = 0;
		for (int ii = 0; ii < ini.length(); ii++) {
			char c = ini.charAt(ii);
			if (c == '"') {
				inString = !inString;
			} else if (!inString) {
				if (c == '(') {
					brackets++;
				} else if (c == ')') {
					brackets--;
				} else if (c == ',' && brackets == 0) {
					ini = ini.substring(0, ii);
					break;
				}
			}
		}
		return ini;
	}

	/**
	 * Sets the initial term.
	 * 
	 * @param initial the initial term
	 */
	public void setInitial(String initial) {
		this.initial = initial;
	}

	/**
	 * Sets the initial term after evaluating the potential replacements in the term
	 * map
	 * 
	 * @param term    the initial term
	 * @param termMap the current term mapping
	 */
	public void setInitial(String term, Map<String, Term> termMap) {
		boolean inString = false;
		boolean replaced = false;
		// System.out.println("old term: "+term);
		do {
			replaced = false;
			for (int i = 0; i < term.length(); i++) {
				char c = term.charAt(i);
				if (c == '"') {
					inString = !inString;
				}
				if (!inString) {
					if (c == '{') {
						int end = term.indexOf("}", i);
						if (end != -1) {
							String key = term.substring(i, end + 1);
							Term st = termMap.get(key);
							if (st != null) {
								term = term.substring(0, i) + "(" + st.getExpression() + ")" + term.substring(end + 1);
								replaced = true;
								// System.out.println("new term:
								// "+term+"/"+key+"/"+termMap.get(key).getInitial());
								break;
							}
						}
					}
				}
			}
		} while (replaced);

		this.initial = term;
	}

	/**
	 * Sets the Method instance, once this term has been compiled by the JIT
	 * compiler
	 * 
	 * @param jitted the method
	 */
	public void setJittedMethod(Method jitted) {
		this.jittedMethod = jitted;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#isConstant()
	 */
	@Override
	public boolean isConstant() {
		return constant;
	}

	public void setConstant(boolean constant) {
		this.constant = constant;
	}

	private String filterCode(String code) {
		// TODO stuff?
		return code;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}
		if (o instanceof Term) {
			if (o == this && (!(this.left instanceof Function) || ((Function) this.left).isDeterministic())) {
				return true;
			}

			boolean eq = true;

			if (this.left != null) {
				eq = this.left.equals(((Term) o).left);
			}

			if (this.right != null && eq) {
				eq = this.right.equals(((Term) o).right);
			}

			if (this.operator != null && eq) {
				eq = this.operator.equals(((Term) o).operator);
			}

			return eq;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return (this.left != null ? this.left.hashCode() : 0) + (this.right != null ? this.right.hashCode() : 0);
	}

	public boolean isSealed() {
		return sealed;
	}

	public void setSealed(boolean sealed) {
		this.sealed = sealed;
	}

}
