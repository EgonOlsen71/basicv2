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
 * The LINKSHAPE function. It creates a shape from a PETSCII console's content. If none is open, nothing happens.
 * 
 * @author EgonOlsen
 * 
 */
public class LinkShape extends AbstractFunction {

	public LinkShape() {
		super("LINKSHAPE");
	}

	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	@Override
	public Object eval(Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 1) {
			throw new RuntimeException("Wrong number of parameters: " + term);
		}

		Atom type = pars.get(0);
    checkType(type);
		
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			return window.linkShape(machine, VarUtils.getInt(type.eval(machine)));
		}
		throw new RuntimeException("Graphics mode not enabled!");
	}
	
	private void checkType(Atom x) {
    if (x.getType().equals(Type.STRING)) {
      throw new RuntimeException("Type mismatch error: " + this);
    }
  }
}
