package com.sixtyfour.parser;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
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

	/** The key for term replacement while parsing */
	private String key;

	/** The type that the Term returns */
	private Type type;

	private int id = termId++;

	private int callCount = 0;

	private Method jittedMethod = null;

	private Jitted jittedInstance = null;

	private boolean jitRun = false;

	/**
	 * Instantiates a new term based on the given expression.
	 * 
	 * @param expression
	 *            the expression
	 */
	public Term(String expression) {
		this.setExpression(expression);
	}

	/**
	 * Instantiates a new term with an Atom as left child and a 0 as the right
	 * child. The operator is a NOP.
	 * 
	 * @param left
	 *            the left child
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
	 * @param left
	 *            the new left child
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
	 * @param right
	 *            the new right child
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
	 * @param operator
	 *            the new operator
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
	 * @param expression
	 *            the new expression
	 */
	public void setExpression(String expression) {
		this.expression = expression;
	}

	/**
	 * Returns the key. The key is used for internal replacement of parts of a
	 * term (as text) by placeholders.
	 * 
	 * @return the key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * Sets the key. The key is used for internal replacement of parts of a term
	 * (as text) by placeholders.
	 * 
	 * @param key
	 *            the new key
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
		return "([" + key + "]\\l:" + left + "/" + this.operator + "\\r:" + right + ")";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
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
			throw new RuntimeException("Type mismatch error: " + this.toString() + " | " + left + " | " + right + " | " + t1 + "/" + t2 + "/" + operator.getType());
		}
		type = t1;
		return t1;
	}

	@Override
  public List<String> evalToExpression(Machine machine) {
	  List<String> ret=new ArrayList<String>();
      if (operator.isNop()) {
        if (left == null) {
          throw new RuntimeException("Syntax error!");
        }
        return left.evalToExpression(machine);
      }
      Type type = getType();
      if (type == Type.STRING) {
        if (operator.isPlus()) {
          ret.add(0,"_");
          ret.add(0,":+");
          ret.addAll(0,left.evalToExpression(machine));
          ret.addAll(0,right.evalToExpression(machine));
          return ret;
        }
      } else {
        List<String> n1 = left.evalToExpression(machine);
        List<String> n2 = n1;
        if (left != right) {
          n2 = right.evalToExpression(machine);
        }

        if (n1==null || n2==null) {
        	throw new RuntimeException("Unknown function name: "+this.getExpression());
        }
        
        switch (operator.getType()) {
        case 0:
          ret.add(0,"_");
          n2.add(0,":^");
          ret.addAll(0,n1);
          ret.addAll(0,n2);
          break;
        case 1:
          ret.add(0,"_");
          n2.add(0,":*");
          ret.addAll(0,n1);
          ret.addAll(0,n2);
          break;
        case 2:
          ret.add(0,"_");
          n2.add(0,":/");
          ret.addAll(0,n1);
          ret.addAll(0,n2);
          break;
        case 3:
          ret.add(0,"_");
          n2.add(0,":+");
          ret.addAll(0,n1);
          ret.addAll(0,n2);
          break;
        case 4:
          ret.add(0,"_");
          n2.add(0,":-");
          ret.addAll(0,n1);
          ret.addAll(0,n2);
          break;
        case 5:
          break;
        case 6:
          break;
        case 7:
          ret.add(0,"_");
          n2.add(0,":|");
          ret.addAll(0,n1);
          ret.addAll(0,n2);
          break;
        case 8:
          ret.add(0,"_");
          n2.add(0,":&");
          ret.addAll(0,n1);
          ret.addAll(0,n2);
          break;
        case 9:
          ret.add(0,"_");
          n2.add(0,":!");
          ret.addAll(0,n2);
          break;
        }
        return ret;
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

				float v1 = 0;
				switch (operator.getType()) {
				case 0:
					v1 = (float) Math.pow(n1.doubleValue(), n2.doubleValue());
					break;
				case 1:
					v1 = n1.floatValue() * n2.floatValue();
					break;
				case 2:
					if (n2.floatValue() == 0) {
						throw new RuntimeException("Division by zero error: " + n1 + "/" + n2);
					}
					v1 = n1.floatValue() / n2.floatValue();
					break;
				case 3:
					v1 = n1.floatValue() + n2.floatValue();
					break;
				case 4:
					v1 = n1.floatValue() - n2.floatValue();
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
	 * Sets the Method instance, once this term has been compiled by the JIT
	 * compiler
	 * 
	 * @param jitted
	 *            the method
	 */
	public void setJittedMethod(Method jitted) {
		this.jittedMethod = jitted;
	}

	private String filterCode(String code) {
		// TODO stuff?
		return code;
	}
}
