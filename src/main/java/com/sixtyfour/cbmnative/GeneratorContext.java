package com.sixtyfour.cbmnative;

/**
 * @author EgonOlsen
 * 
 */
public class GeneratorContext {

	private Operand lastMoveTarget;
	private Operand lastMoveSource;

	public Operand getLastMoveTarget() {
		return lastMoveTarget;
	}

	public void setLastMoveTarget(Operand lastMoveTarget) {
		this.lastMoveTarget = lastMoveTarget;
	}

	public Operand getLastMoveSource() {
		return lastMoveSource;
	}

	public void setLastMoveSource(Operand lastMoveSource) {
		this.lastMoveSource = lastMoveSource;
	}
}
