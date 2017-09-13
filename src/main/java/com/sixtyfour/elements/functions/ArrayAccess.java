package com.sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * A virtual function (i.e. not part of the BASIC V2 specs) that is used
 * internally to access array elements.
 */
public class ArrayAccess extends AbstractFunction {

	/** The variable name. */
	private String variableName;

	/** The variable type. */
	private Type variableType;

	/** The pis. */
	private int[] pis;

	private List<Atom> pars;

	/**
	 * Instantiates a new array access.
	 */
	public ArrayAccess() {
		super("[]");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return variableType;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		fillParameterIndices(machine);
		Variable vary = machine.getVariableUpperCase(variableName);
		if (vary == null) {
			// No such array...revert to a constant
			if (variableType.equals(Type.REAL)) {
				return Float.valueOf(0f);
			}
			if (variableType.equals(Type.INTEGER)) {
				return Integer.valueOf(0);
			}
			if (variableType.equals(Type.STRING)) {
				return "";
			}
			return null;
		}

		return vary.getValue(pis);
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		// fillParameterIndices(machine);
		List<String> ret = new ArrayList<String>();
		ret.add("_");
		Variable vary = machine.getVariableUpperCase(variableName);

		List<Atom> pars = Parser.getParameters(term);
		int[] dimensions = vary.getDimensions();
		if (pars.size() != dimensions.length) {
			throw new RuntimeException("Array indices don't match: " + this + "/" + pars.size() + "/" + dimensions.length);
		}

		Term t = Parser.createIndexTerm(machine, pars, dimensions);

		List<String> n1 = t.evalToCode(machine).get(0).getExpression();
		n1.addAll(vary.evalToCode(machine).get(0).getExpression());
		n1.add(":" + this.getClass().getSimpleName().toUpperCase(Locale.ENGLISH));
		ret.addAll(0, n1);
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
	}

	/**
	 * Sets the array variable that this function should access.
	 * 
	 * @param variable
	 *            the new variable
	 */
	public void setVariable(Variable variable) {
		this.variableType = variable.getType();
		this.variableName = VarUtils.toUpper(variable.getName());
	}

	private void fillParameterIndices(Machine machine) {
		if (pis == null) {
			pars = Parser.getParameters(term);
			pis = new int[pars.size()];
		}
		for (int i = 0; i < pars.size(); i++) {
			pis[i] = VarUtils.getInt(pars.get(i).eval(machine));
		}
	}
}
