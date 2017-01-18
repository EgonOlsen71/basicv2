package com.sixtyfour;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Get;
import com.sixtyfour.elements.commands.Input;
import com.sixtyfour.elements.commands.Wait;

/**
 * A Tracer implementation that can be used to delay the execution of BASIC
 * commands.
 * 
 * @author EgonOlsen
 * 
 */
public class DelayTracer implements Tracer {
	private long commandsPerSecond = -1;
	private long avgTicks = 0;
	private long lastTicks = 0;

	/**
	 * Creates a new DelayTracer. This implementation tries to calculate the
	 * delay time to achieve the desired commands/second rate based on the
	 * average execution time.
	 * 
	 * @param commandsPerSecond
	 */
	public DelayTracer(int commandsPerSecond) {
		this.commandsPerSecond = commandsPerSecond;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.Tracer#commandExecuted(com.sixtyfour.Basic,
	 * com.sixtyfour.elements.commands.Command, java.lang.Integer, int)
	 */
	@Override
	public void commandExecuted(Basic basic, Command command, Integer lineNumber, int count) {
		if (commandsPerSecond <= 0) {
			return;
		}

		long ticks = System.nanoTime();
		if (ticks - lastTicks < 0 || command instanceof Input || command instanceof Get || command instanceof Wait) {
			lastTicks = ticks;
		} else {
			if (avgTicks == 0) {
				avgTicks = ticks - lastTicks;
			}
			avgTicks = (avgTicks + (ticks - lastTicks)) >> 1;
		}

		long waitTime = (1000L * 1000000L / commandsPerSecond) - (ticks - lastTicks);
		waitTime /= 1000000L;
		if (waitTime > 0) {
			try {
				Thread.sleep(waitTime);
			} catch (Exception e) {
				//
			}
		}

		lastTicks = System.nanoTime();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.Tracer#start(com.sixtyfour.Basic)
	 */
	@Override
	public void start(Basic basic) {
		lastTicks = System.nanoTime();
		avgTicks = 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.Tracer#stop(com.sixtyfour.Basic)
	 */
	@Override
	public void stop(Basic basic) {
		//
	}

}
