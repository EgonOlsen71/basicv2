package com.sixtyfour.basicshell;

import java.util.concurrent.Future;

import com.sixtyfour.Basic;

/**
 * Runs the program that's inside the editor.
 * 
 * @Author nietoperz809
 */
public class Runner implements Runnable {
	private final Basic olsenBasic;
	private boolean running;

	public Runner(String[] program, BasicShell shellFrame) {
		this.olsenBasic = new Basic(program);
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

	public boolean isRunning() {
		return running;
	}

	public Basic getOlsenBasic() {
		return olsenBasic;
	}

	@Override
	public void run() {
		running = true;
		olsenBasic.run();
		running = false;
	}
}
