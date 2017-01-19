package com.sixtyfour.extensions.graphics.functions;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.AbstractFunction;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The GETSHAPE function. It creates a shape from a region of the screen buffer
 * and its internal id.
 * 
 * @author EgonOlsen
 * 
 */
public class GetShape extends AbstractFunction {

	public GetShape() {
		super("GETSHAPE");
	}

	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	@Override
	public Object eval(Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 4) {
			throw new RuntimeException("Wrong number of parameters: " + term);
		}
		Atom xs = pars.get(0);
		checkType(xs);
		Atom ys = pars.get(1);
		checkType(ys);
		Atom xe = pars.get(2);
		checkType(xe);
		Atom ye = pars.get(3);
		checkType(ye);

		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			return window.getShape(VarUtils.getInt(xs.eval(machine)), VarUtils.getInt(ys.eval(machine)), VarUtils.getInt(xe.eval(machine)), VarUtils.getInt(ye.eval(machine)));
		}
		throw new RuntimeException("Graphics mode not enabled!");
	}

	private void checkType(Atom x) {
		if (x.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
	}

}
