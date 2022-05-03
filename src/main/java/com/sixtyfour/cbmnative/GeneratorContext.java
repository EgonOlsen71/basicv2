package com.sixtyfour.cbmnative;

/**
 * Provides a context for a Generator.
 * 
 * @author EgonOlsen
 * 
 */
public class GeneratorContext {

	private Operand lastMoveTarget;
	private Operand lastMoveSource;

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
}
