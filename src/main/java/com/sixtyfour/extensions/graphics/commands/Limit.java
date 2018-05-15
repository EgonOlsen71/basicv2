package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.CompilerConfig;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The BUFFERMODE command
 * 
 * @author EgonOlsen
 * 
 */
public class Limit extends AbstractGraphicsCommand {

	private long frameTime;
	private long lastTime;
	private long lastDif;

	public Limit() {
		super("LIMIT");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
		checkTypes(pars, linePart, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		Atom m = pars.get(0);
		limit(VarUtils.getInt(m.eval(machine)));
		return null;
	}

	/**
	 * Limits the speed of a fixed max. fps value. 0 (or lower) means no limit.
	 * 
	 * @param fps
	 *            the desired fps value
	 */
	private void limit(int fps) {
		if (fps <= 0) {
			return;
		}
		frameTime = 1000000000L / (long) fps;
		long now = System.nanoTime();
		long dif = now - lastTime;
		if (dif < 0) {
			// Fix overflow
			dif = lastDif;
		}
		lastDif = dif;
		if (dif < frameTime) {
			try {
				long waitTime = (frameTime - dif) / 1000000L;
				Thread.sleep(waitTime);
			} catch (Exception e) {
				//
			}
		}
		lastTime = System.nanoTime();
	}

}
