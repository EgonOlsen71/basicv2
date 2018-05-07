package com.sixtyfour.system;

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

	private int compactThreshold = 0;
	private static CompilerConfig instance = new CompilerConfig();

	public static CompilerConfig getConfig() {
		return instance;
	}

	private CompilerConfig() {
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
}
