package com.sixtyfour.config;

/**
 * Contains the configuration for the compiler. Some (most) of these options
 * apply to the native compiler only.
 * 
 * @author EgonOlsen
 * 
 */
public class CompilerConfig {

	private boolean constantPropagation = true;
	private boolean constantFolding = true;
	private boolean intermediateLanguageOptimizations = true;
	private boolean nativeLanguageOptimizations = true;
	private boolean optimizedLinker = true;
	private boolean deadStoreElimination = true;
	private boolean deadStoreEliminationOfStrings = true;
	private boolean optimizeConstants=true;
	private LoopMode loopMode=LoopMode.EXECUTE;

	private int compactThreshold = 0;

	public CompilerConfig() {
		//
	}

	public boolean isConstantPropagation() {
		return constantPropagation;
	}

	public void setConstantPropagation(boolean constantPropagation) {
		this.constantPropagation = constantPropagation;
	}

	public boolean isConstantFolding() {
		return constantFolding;
	}

	public void setConstantFolding(boolean constantFolding) {
		this.constantFolding = constantFolding;
	}

	public boolean isIntermediateLanguageOptimizations() {
		return intermediateLanguageOptimizations;
	}

	public void setIntermediateLanguageOptimizations(boolean intermediateLanguageOptimizations) {
		this.intermediateLanguageOptimizations = intermediateLanguageOptimizations;
	}

	public boolean isNativeLanguageOptimizations() {
		return nativeLanguageOptimizations;
	}

	public void setNativeLanguageOptimizations(boolean nativeLanguageOptimizations) {
		this.nativeLanguageOptimizations = nativeLanguageOptimizations;
	}

	public boolean isOptimizedLinker() {
		return optimizedLinker;
	}

	public void setOptimizedLinker(boolean optimizedLinker) {
		this.optimizedLinker = optimizedLinker;
	}

	public boolean isDeadStoreElimination() {
		return deadStoreElimination;
	}

	public void setDeadStoreElimination(boolean deadStoreElimination) {
		this.deadStoreElimination = deadStoreElimination;
	}

	public int getCompactThreshold() {
		return compactThreshold;
	}

	public void setCompactThreshold(int compactThreshold) {
		this.compactThreshold = compactThreshold;
	}

	public boolean isDeadStoreEliminationOfStrings() {
		return deadStoreEliminationOfStrings;
	}

	public void setDeadStoreEliminationOfStrings(boolean deadStoreEliminationOfStrings) {
		this.deadStoreEliminationOfStrings = deadStoreEliminationOfStrings;
	}

	/**
	 * Returns the current loop mode that will be used when compiling the
	 * program.
	 * 
	 * @return the loop mode
	 */
	public LoopMode getLoopMode() {
		return loopMode;
	}

	/**
	 * Sets the loop mode. This has to be set before compiling/running a program
	 * to have an effect.
	 * 
	 * @param loopMode
	 *            the loop mode, EXECUTE is default
	 */
	public void setLoopMode(LoopMode loopMode) {
		this.loopMode = loopMode;
	}

	/**
	 * @return
	 */
	public boolean isOptimizeConstants() {
	    return optimizeConstants;
	}

	/**
	 * @param optimizeConstants
	 */
	public void setOptimizeConstants(boolean optimizeConstants) {
	    this.optimizeConstants = optimizeConstants;
	}

}
