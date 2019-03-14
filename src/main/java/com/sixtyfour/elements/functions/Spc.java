package com.sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.Print;
import com.sixtyfour.elements.commands.PrintFile;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The SPC function.
 */
public class Spc extends AbstractFunction {

	/** The Constant SPACES. */
	protected final static String SPACES;
	private static boolean limitedToPrint = true;

	static {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 255; i++) {
			sb.append(' ');
		}
		SPACES = sb.toString();
	}

	/**
	 * Instantiates a new spc.
	 * 
	 * @param name the name
	 */
	protected Spc(String name) {
		super(name);
	}

	/**
	 * Instantiates a new spc.
	 */
	public Spc() {
		super("SPC");
	}

	/**
	 * If set to false, this function can be called outside of PRINT, PRINT# and CMD
	 * as well. Default is true (i.e. it can't, which is normal CBM BASIC
	 * behaviour).
	 * 
	 * @param limited should it be limited
	 */
	public static void setLimitedToPrint(boolean limited) {
		limitedToPrint = limited;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.STRING;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		ensureContext(machine);
		if (term.getType().equals(Type.STRING)) {
			typeMismatch(this);
		}
		int num = VarUtils.getInt(term.eval(machine));
		if (num < 0 || num > 255) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}
		return SPACES.substring(0, num);
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<String> ret = new ArrayList<String>();
		ret.add("_");
		List<String> n1 = term.evalToCode(config, machine).get(0).getExpression();
		String call = ":" + this.getClass().getSimpleName().toUpperCase(Locale.ENGLISH);
		if (machine.getCurrentCommand() instanceof PrintFile) {
			call += "CHANNEL";
		}
		n1.add(call);
		ret.addAll(0, n1);
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
	}

	/**
	 * Ensure context.
	 * 
	 * @param machine the machine
	 */
	protected void ensureContext(Machine machine) {
		if (limitedToPrint) {
			if (!(machine.getCurrentCommand() instanceof Print) || !machine.getCurrentOperator().isNop()) {
				throw new RuntimeException("Syntax error: " + this);
			}
		}
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
}
