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
 * The SPRITESHAPE function. It converts a sprite in C64 format from memory into
 * a shape and returns its internal id.
 * 
 * @author EgonOlsen
 * 
 */
public class SpriteShape extends AbstractFunction {

	public SpriteShape() {
		super("SPRITESHAPE");
	}

	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	@Override
	public Object eval(Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 2) {
			throw new RuntimeException("Wrong number of parameters: " + term);
		}
		Atom addr = pars.get(0);
		checkType(addr);
		Atom type = pars.get(1);
		checkType(type);

		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			return window.spriteShape(machine, VarUtils.getInt(addr.eval(machine)),
					VarUtils.getInt(type.eval(machine)) == 1);
		}
		throw new RuntimeException("Graphics mode not enabled!");
	}

	private void checkType(Atom x) {
		if (x.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.Function#isDeterministic()
	 */
	@Override
	public boolean isDeterministic() {
		return false;
	}

}
