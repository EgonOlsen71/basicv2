package com.sixtyfour.elements.commands.internal;

import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.elements.commands.For;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * Delay is an internal command that is used to execute busy wait loops similar
 * to the timing that a real C64 would have.
 * 
 * @author EgonOlsen
 */
public class Delay extends AbstractCommand {

	private final static float MS_PER_STEP = 1.2f;
	private For delayLoop;
	private boolean delay;

	public Delay(For delayLoop, boolean delay) {
		super("__DELAY");
		this.delayLoop = delayLoop;
		this.delay = delay;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		delayLoop.setToFinalValue(machine);
		if (delay) {
			long steps = delayLoop.getSteps(machine);
			long waitTime = (long) (steps * MS_PER_STEP);
			try {
				Thread.sleep(waitTime);
			} catch (Exception e) {
				//
			}
		}
		return null;
	}

}
