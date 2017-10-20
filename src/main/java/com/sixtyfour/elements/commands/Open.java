package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
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

	/** The pars. */
	private List<Atom> pars;

	/**
	 * Instantiates a new open.
	 */
	public Open() {
		super("OPEN");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.isEmpty()) {
			syntaxError(this);
		}

		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
	    NativeCompiler compiler = NativeCompiler.getCompiler();
	    List<String> after = new ArrayList<String>();
	    List<String> expr = new ArrayList<String>();
	    List<String> before = new ArrayList<String>();
	    
	    try {
	      switch (pars.size()) {
	      case 1:
	        expr.addAll(compiler.compileToPseudoCode(machine, pars.get(0)));
	        String expPush = getPushRegister(expr.get(expr.size() - 1));
	        expr = expr.subList(0, expr.size() - 1);
	        if (expPush.equals("Y")) {
	          expr.add("MOV X,Y");
	        }
	        after.add("MOV Y,#1{INTEGER}");
	        break;
	      case 2:
	        expr.addAll(compiler.compileToPseudoCode(machine, pars.get(0)));
	        expr.addAll(compiler.compileToPseudoCode(machine, pars.get(1)));
	        expr.add("POP C");
	        expr.add("POP X");
	        after.add("MOV Y,#2{INTEGER}");
	        break;
	      case 3:
	        expr.addAll(compiler.compileToPseudoCode(machine, pars.get(0)));
          expr.addAll(compiler.compileToPseudoCode(machine, pars.get(1)));
          expr.addAll(compiler.compileToPseudoCode(machine, pars.get(2)));
          expr.add("POP D");
          expr.add("POP C");
          expr.add("POP X");
          after.add("MOV Y,#3{INTEGER}");
	        break;
	      case 4:
	        expr.addAll(compiler.compileToPseudoCode(machine, pars.get(0)));
          expr.addAll(compiler.compileToPseudoCode(machine, pars.get(1)));
          expr.addAll(compiler.compileToPseudoCode(machine, pars.get(2)));
          expr.addAll(compiler.compileToPseudoCode(machine, pars.get(3)));
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
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		DeviceProvider device = machine.getDeviceProvider();

		try {
			switch (pars.size()) {
			case 1:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)));
				break;
			case 2:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)));
				break;
			case 3:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)), VarUtils.getInt(pars.get(2).eval(machine)));
				break;
			case 4:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)), VarUtils.getInt(pars.get(2).eval(machine)), (String) pars
						.get(3).eval(machine));
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
