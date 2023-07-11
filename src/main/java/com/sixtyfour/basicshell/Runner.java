package com.sixtyfour.basicshell;

import java.util.concurrent.Future;

import com.sixtyfour.Basic;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.extensions.graphics.GraphicsBasic;
import com.sixtyfour.extensions.textmode.ConsoleSupport;
import com.sixtyfour.plugins.CodeEnhancer;
import com.sixtyfour.plugins.MemoryListener;

/**
 * Runs the program that's inside the editor.
 * 
 * @author nietoperz809
 */
public class Runner implements Runnable {
	private final Basic olsenBasic;
	private boolean running;
	private Basic runningBasic = null;
	private CompilerConfig config = new CompilerConfig();
	private MemoryListener memListener;
	private String initCommand=null;

	public Runner(String[] program, BasicShell shellFrame) {
		this(program, shellFrame, null);
	}
		
	
	public Runner(String[] program, BasicShell shellFrame, String initCommand) {
		Basic.registerExtension(new GraphicsBasic());
		Basic.registerExtension(new ConsoleSupport());
		this.olsenBasic = new Basic(program);
		olsenBasic.setOutputChannel(new ShellOutputChannel(shellFrame));
		olsenBasic.setInputProvider(new ShellInputProvider(shellFrame));
		memListener = new ShellMemoryListener(shellFrame);
		this.initCommand = initCommand;
	}

	public void dispose() {
		if (olsenBasic != null) {
			olsenBasic.resetMemory();
		}
	}

	public void registerKey(Character key) {
		if (olsenBasic.getInputProvider() instanceof ShellInputProvider) {
			((ShellInputProvider) olsenBasic.getInputProvider()).setCurrentKey(key);
		}
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
	 * @param command the command the execute
	 */
	public void executeDirectCommand(final String command) {
		Future<?> f = BasicShell.executor.submit(new Runnable() {
			@Override
			public void run() {
				running = true;
				Basic imm = new Basic("0" + command, olsenBasic.getMachine());
				// imm.setLoopMode(LoopMode.REMOVE);
				setRunningBasic(imm);
				imm.compile(config, false);
				imm.start(config);
				running = false;
				removeRunningBasic();
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
	 * @param synchronous if true the caller is blocked
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
		setRunningBasic(olsenBasic);
		olsenBasic.run(config);
		running = false;
		removeRunningBasic();
	}
	
	private void setRunningBasic(Basic basic) {
		basic.setMemoryListener(memListener);
		if (initCommand!=null) {
			olsenBasic.setCodeEnhancer(new CodeEnhancer() {
	
				@Override
				public String getFirstCommand() {
					return initCommand;
				}
	
				@Override
				public String getLastCommand() {
					return null;
				}
				
			});
		}
		runningBasic = basic;
	}
	
	private void removeRunningBasic() {
		runningBasic.setMemoryListener(null);
		olsenBasic.setCodeEnhancer(null);
		runningBasic = null;
	}
}
