package com.sixtyfour.cbmnative;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.Machine;

/**
 * Provides a context for a Generator.
 * 
 * @author EgonOlsen
 * 
 */
public class GeneratorContext {

	private CompilerConfig compilerConfig;
	private Machine machine;
	
	private Operand lastMoveTarget;
	private Operand lastMoveSource;
	
	/**
	 * 
	 * @param config
	 */
	public GeneratorContext(CompilerConfig config, Machine machine) {
		this.compilerConfig = config;
		this.machine = machine;
	}
	
	
	/**
	 * 
	 * @return
	 */
	public Machine getMachine() {
		return machine;
	}



	/**
	 * Returns the last move target
	 * 
	 * @return the last target
	 */
	public Operand getLastMoveTarget() {
		return lastMoveTarget;
	}

	/**
	 * Sets the last move target
	 * 
	 * @param lastMoveTarget the last move target
	 */
	public void setLastMoveTarget(Operand lastMoveTarget) {
		this.lastMoveTarget = lastMoveTarget;
	}

	/**
	 * Returns the last move source
	 * 
	 * @return the last source
	 */
	public Operand getLastMoveSource() {
		return lastMoveSource;
	}

	/**
	 * Sets the last move source
	 * 
	 * @param lastMoveTarget the last move source
	 */
	public void setLastMoveSource(Operand lastMoveSource) {
		this.lastMoveSource = lastMoveSource;
	}

	/**
	 * 
	 * @return
	 */
	public CompilerConfig getCompilerConfig() {
		return compilerConfig;
	}

	/**
	 * 
	 * @param compilerConfig
	 */
	public void setCompilerConfig(CompilerConfig compilerConfig) {
		this.compilerConfig = compilerConfig;
	}
}
