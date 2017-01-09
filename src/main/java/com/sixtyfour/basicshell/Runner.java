package com.sixtyfour.basicshell;

import java.util.concurrent.Future;

import com.sixtyfour.Basic;

/**
 * Runs the program that's inside the editor.
 * 
 * @author nietoperz809
 */
public class Runner implements Runnable {
	private final Basic olsenBasic;
	private boolean running;
	private Basic runningBasic = null;

	public Runner(String[] program, BasicShell shellFrame) {
		this.olsenBasic = new Basic(program);
		// this.olsenBasic.setLoopMode(LoopMode.DELAY);
		// this.olsenBasic.setTracer(new DelayTracer(3));
		olsenBasic.setOutputChannel(new ShellOutputChannel(shellFrame));
		olsenBasic.setInputProvider(new ShellInputProvider(shellFrame));
	}

	/**
	 * Start BASIC task and blocks starter until task ends
	 */
	public void synchronousStart() {
		Future<?> f = BasicShell.executor.submit(this);
		try {
			f.get();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Executes a command in "direct mode" by shoehorning it into a one line
	 * program.
	 * 
	 * @param command
	 *            the command the execute
	 */
	public void executeDirectCommand(final String command) {
		Future<?> f = BasicShell.executor.submit(new Runnable() {
			@Override
			public void run() {
				running = true;
				Basic imm = new Basic("0" + command, olsenBasic.getMachine());
				// imm.setLoopMode(LoopMode.REMOVE);
				runningBasic = imm;
				imm.compile(false);
				imm.start();
				running = false;
				runningBasic = null;
			}
		});
		try {
			f.get();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean isRunning() {
		return running;
	}

	public Basic getOlsenBasic() {
		return olsenBasic;
	}

	public Basic getRunningBasic() {
		return runningBasic;
	}

	/**
	 * Start BASIC task
	 * 
	 * @param synchronous
	 *            if true the caller is blocked
	 */
	public void start(boolean synchronous) {
		Future<?> f = BasicShell.executor.submit(this);
		if (!synchronous)
			return;
		try {
			f.get();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void run() {
		running = true;
		runningBasic = olsenBasic;
		olsenBasic.run();
		running = false;
		runningBasic = null;
	}
}
