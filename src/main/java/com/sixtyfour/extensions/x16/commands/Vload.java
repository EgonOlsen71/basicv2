/*
 * 
 */
package com.sixtyfour.extensions.x16.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.commands.FileOperation;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The LOAD command.
 */
public class Vload extends FileOperation {

	/**
	 * Instantiates a new load.
	 */
	public Vload() {
		super("VLOAD");
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
	    NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();
		List<String> before = new ArrayList<String>();
		
		try {
			switch (pars.size()) {
			case 4:
    			    	expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
    				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(1)));
    				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(2)));
    				expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(3)));
    				expr.add("POP C");
    				expr.add("POP Y");
    				expr.add("POP X");
    				expr.add("POP G");
    				break;
			default:
				syntaxError(this);
			}
		} catch (ClassCastException e) {
			syntaxError(this);
		}

		after.add("JSR VLOAD");

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

		try {
			switch (pars.size()) {
			case 4: if (config.isExtendedLoad()) {
			    	device.load(config, (String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)),
					VarUtils.getInt(pars.get(2).eval(machine)));
			    	// Ignore the 3rd numeric parameter here...
			    	break;
			}
			default:
				syntaxError(this);
			}
		} catch (ClassCastException e) {
			syntaxError(this);
		}

		return null;
	}

}
