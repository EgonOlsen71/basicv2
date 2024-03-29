package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The OPEN command.
 */
public class Open extends AbstractCommand {

	/**
	 * Instantiates a new open.
	 */
	public Open() {
		super("OPEN");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int,
	 * int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(config, this, linePart, machine, true);
		List<Atom> pars = Parser.getParameters(term);

		if (pars.isEmpty()) {
			syntaxError(this);
		}

		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();
		List<String> before = new ArrayList<String>();
		List<Atom> pars = Parser.getParameters(term);

		try {
			switch (pars.size()) {
			case 1:
				expr.addAll(addSingleParameter(config, machine, compiler, pars));
				after.add("MOV Y,#1{INTEGER}");
				break;
			case 2:
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(1)));
				expr.add("POP C");
				expr.add("POP X");
				after.add("MOV Y,#2{INTEGER}");
				break;
			case 3:
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(1)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(2)));
				expr.add("POP D");
				expr.add("POP C");
				expr.add("POP X");
				after.add("MOV Y,#3{INTEGER}");
				break;
			case 4:
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(1)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(2)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(3)));
				expr.add("POP G");
				expr.add("POP D");
				expr.add("POP C");
				expr.add("POP X");
				after.add("MOV Y,#4{INTEGER}");
				break;
			default:
				syntaxError(this);
			}
		} catch (ClassCastException e) {
			syntaxError(this);
		}

		after.add("JSR OPEN");

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		DeviceProvider device = machine.getDeviceProvider();
		List<Atom> pars = Parser.getParameters(term);
		try {
			switch (pars.size()) {
			case 1:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)));
				break;
			case 2:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)));
				break;
			case 3:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)),
						VarUtils.getInt(pars.get(2).eval(machine)));
				break;
			case 4:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)),
						VarUtils.getInt(pars.get(2).eval(machine)), (String) pars.get(3).eval(machine));
				break;
			default:
				syntaxError(this);
			}
		} catch (ClassCastException e) {
			syntaxError(this);
		}

		return null;

	}
}
