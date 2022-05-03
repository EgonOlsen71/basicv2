package com.sixtyfour.extensions.graphics.commands;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The COLOR command
 * 
 * @author EgonOlsen
 * 
 */
public class Color extends AbstractGraphicsCommand {

	private static Constant<Integer> alpha = new Constant<Integer>(255);

	public Color() {
		super("COLOR");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 3, 1);
		List<Atom> pars = Parser.getParameters(term);
		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		Atom r = pars.get(0);
		Atom g = pars.get(1);
		Atom b = pars.get(2);
		Atom a = null;
		if (pars.size() > 3) {
			a = pars.get(3);
		} else {
			a = alpha;
		}

		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.color(VarUtils.getInt(r.eval(machine)), VarUtils.getInt(g.eval(machine)),
					VarUtils.getInt(b.eval(machine)), VarUtils.getInt(a.eval(machine)));
		}
		return null;
	}
}
