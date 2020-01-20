/*
 * 
 */
package com.sixtyfour.extensions.x16.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.FileOperation;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The LOAD command for the X16, which slightly extends BASICV2's LOAD
 */
public class Xload extends FileOperation {

	/**
	 * Instantiates a new load.
	 */
	public Xload() {
		super("LOAD");
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return evalToCode(config, machine, "LOAD");
	}

	@Override
	protected boolean isLoad() {
		return true;
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

		try {
			switch (pars.size()) {
			case 0:
				device.load(config, "", 1, 0);
				break;
			case 1:
				device.load(config, (String) pars.get(0).eval(machine), 1, 0);
				break;
			case 2:
				device.load(config, (String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)), 0);
				break;
			case 3:
				device.load(config, (String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)),
						VarUtils.getInt(pars.get(2).eval(machine)));
				break;
			case 4:
				device.load(config, (String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)),
						VarUtils.getInt(pars.get(2).eval(machine)));
				// Ignore the 3rd numeric parameter here...
				break;
			default:
				syntaxError(this);
			}
		} catch (ClassCastException e) {
			syntaxError(this);
		}

		return null;
	}

	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine, String call) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();
		List<String> before = new ArrayList<String>();
		boolean extendedLoad = false;

		try {
			switch (pars.size()) {
			case 0:
				// Actually, this case doesn't really happen due to the way in
				// which the parser handles LOAD without parameters, but
				// anyway...
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.add("MOV G,#{STRING}");
				after.add("MOV X,#1{INTEGER}");
				after.add("MOV Y,#0{INTEGER}");
				break;
			case 1:
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.add("POP G");
				after.add("MOV X,#1{INTEGER}");
				after.add("MOV Y,#0{INTEGER}");
				break;
			case 2:
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(1)));
				expr.add("POP X");
				expr.add("POP G");
				after.add("MOV Y,#0{INTEGER}");
				break;
			case 3:
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(1)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(2)));
				expr.add("POP Y");
				expr.add("POP X");
				expr.add("POP G");
				break;
			case 4:
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(1)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(2)));
				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(3)));
				expr.add("POP C");
				expr.add("POP Y");
				expr.add("POP X");
				expr.add("POP G");
				extendedLoad = true;
				break;
			default:
				syntaxError(this);
			}
		} catch (ClassCastException e) {
			syntaxError(this);
		}

		after.add("JSR " + (extendedLoad ? (call + "EXT") : call));
		if (!extendedLoad) {
			after.add("JMP RESTARTPRG");
		}

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
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
		linePart = TermEnhancer.removeWhiteSpace(linePart);
		linePart = linePart.substring(this.name.length());
		if (linePart.trim().isEmpty()) {
			linePart = "\"\"";
		}
		term = Parser.getTerm(config, linePart, machine, false, true);
		pars = Parser.getParameters(term);

		if (pars.size() > 0 && !pars.get(0).getType().equals(Type.STRING)) {
			syntaxError(this);
		}
		if (pars.size() > 1 && pars.get(1).getType().equals(Type.STRING)) {
			syntaxError(this);
		}
		if (pars.size() > 2 && pars.get(2).getType().equals(Type.STRING)) {
			syntaxError(this);
		}
		if (pars.size() > 3 && pars.get(3).getType().equals(Type.STRING)) {
			syntaxError(this);
		}
		return null;
	}

	@Override
	public boolean isOverride() {
		return true;
	}

}
