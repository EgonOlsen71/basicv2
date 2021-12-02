package com.sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.parser.optimize.TermOptimizer;
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
	public boolean typesMatch() {
		List<Atom> pars = Parser.getParameters(term);
		for (Atom par : pars) {
			if (par.getType(true) == Type.STRING) {
				return false;
			}
		}
		return true;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		// fillParameterIndices(machine);
		List<String> ret = new ArrayList<String>();
		ret.add("_");
		Variable vary = machine.getVariableUpperCase(variableName);
		List<Atom> pars = Parser.getParameters(term);
		
		if (vary == null) {
			int[] dims=new int[Math.max(pars.size(), 1)];
			for (int i=0; i<dims.length; i++) {
				dims[i]=10;
			}
			Variable tmpVar = new Variable(variableName, null, dims);
			machine.add(tmpVar);
			Logger.log("Array not defined: " + variableName + ", defaulting to a depth of 10 with "+pars.size()+" dimensions!");
			vary = machine.getVariableUpperCase(variableName);
		}

		
		int[] dimensions = vary.getDimensions();
		if (pars.size() != dimensions.length) {
			throw new RuntimeException("Array indices don't match (" + variableName + "): " + this + "/" + pars.size()
					+ "/" + dimensions.length);
		}

		// System.out.println("Creating term: "+this.variableName+"/"+pars);
		Term t = Parser.createIndexTerm(config, machine, pars, dimensions);
		TermOptimizer.optimizeCalculations(config, machine, t);

		List<String> n1 = t.evalToCode(config, machine).get(0).getExpression();
		n1.addAll(vary.evalToCode(config, machine).get(0).getExpression());
		n1.add(":" + getNativeFunctionName());
		ret.addAll(0, n1);
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
	}

	/**
	 * Sets the array variable that this function should access.
	 * 
	 * @param variable the new variable
	 */
	public void setVariable(Variable variable) {
		this.variableType = variable.getType();
		this.variableName = VarUtils.toUpper(variable.getName());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#isDeterministic()
	 */
	@Override
	public boolean isDeterministic() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.Function#getInitialCall()
	 */
	@Override
	public String getInitialCall() {
		return this.variableName.replace("[]", "") + "(" + term.getInitial() + ")";
	}

	private void fillParameterIndices(Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		if (pis == null) {
			pis = new int[pars.size()];
		}
		for (int i = 0; i < pars.size(); i++) {
			pis[i] = VarUtils.getInt(pars.get(i).eval(machine));
		}
	}
}
