package com.sixtyfour.config;

import com.sixtyfour.cbmnative.ProgressListener;

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
	private boolean pcodeOptimize = false;
	private boolean intermediateLanguageOptimizations = true;
	private boolean nativeLanguageOptimizations = true;
	private boolean optimizedLinker = true;
	private boolean deadStoreElimination = true;
	private boolean deadStoreEliminationOfStrings = true;
	private boolean optimizeConstants = true;
	private boolean intOptimizations = true;
	private boolean loopOptimizations = true;
	private boolean shiftOptimizations = true;
	private boolean nonDecimalNumbersAware = false;
	private boolean convertStringToLower = false;
	private boolean flipCasing = false;
	private boolean aggressiveFloatOptimizations = true;
	private boolean enhancedInstructionSet = false;
	private boolean deadCodeElimination = false;
	private boolean floatOptimizations = false;
	private boolean boostMode = false;
	private boolean bigRam = false;
	private boolean inlineAssembly = false;

	private String symbolTable = null;
	private int threads = -1;
	private LoopMode loopMode = LoopMode.EXECUTE;
	private ProgressListener progressListener;

	private RuntimeAddition runtimeAddition = null;

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

	public void setPcodeOptimizations(boolean pcodeOptimize) {
		this.pcodeOptimize = pcodeOptimize;
	}

	public boolean isPcodeOptimize() {
		return pcodeOptimize;
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
	 * Returns the current loop mode that will be used when compiling the program.
	 * 
	 * @return the loop mode
	 */
	public LoopMode getLoopMode() {
		return loopMode;
	}

	/**
	 * Sets the loop mode. This has to be set before compiling/running a program to
	 * have an effect.
	 * 
	 * @param loopMode the loop mode, EXECUTE is default
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

	public boolean isBigRam() {
		return bigRam;
	}

	public void setBigRam(boolean bigRam) {
		this.bigRam = bigRam;
	}

	public ProgressListener getProgressListener() {
		return progressListener;
	}

	public void setProgressListener(ProgressListener progressListener) {
		this.progressListener = progressListener;
	}

	public boolean isFloatOptimizations() {
		return floatOptimizations;
	}

	public void setFloatOptimizations(boolean floatOptimizations) {
		this.floatOptimizations = floatOptimizations;
	}

	public boolean isIntOptimizations() {
		return intOptimizations;
	}

	public void setIntOptimizations(boolean intOptimizations) {
		this.intOptimizations = intOptimizations;
	}

	public boolean isLoopOptimizations() {
		return loopOptimizations;
	}

	public void setLoopOptimizations(boolean loopOptimizations) {
		this.loopOptimizations = loopOptimizations;
	}

	public boolean isShiftOptimizations() {
		return shiftOptimizations;
	}

	public void setShiftOptimizations(boolean shiftOptimizations) {
		this.shiftOptimizations = shiftOptimizations;
	}

	public boolean isNonDecimalNumbersAware() {
		return nonDecimalNumbersAware;
	}

	public void setNonDecimalNumbersAware(boolean nonDecimalNumbersAware) {
		this.nonDecimalNumbersAware = nonDecimalNumbersAware;
	}

	public String getSymbolTable() {
		return symbolTable;
	}

	public void setSymbolTable(String symbolTable) {
		this.symbolTable = symbolTable;
	}

	public boolean isConvertStringToLower() {
		return convertStringToLower;
	}

	public void setConvertStringToLower(boolean convertStringToLower) {
		this.convertStringToLower = convertStringToLower;
	}

	public boolean isAggressiveFloatOptimizations() {
		return aggressiveFloatOptimizations;
	}

	public void setAggressiveFloatOptimizations(boolean aggressiveFloatOptimizations) {
		this.aggressiveFloatOptimizations = aggressiveFloatOptimizations;
	}

	public boolean isEnhancedInstructionSet() {
		return enhancedInstructionSet;
	}

	public void setEnhancedInstructionSet(boolean enhancedInstructionSet) {
		this.enhancedInstructionSet = enhancedInstructionSet;
	}

	public boolean isFlipCasing() {
		return flipCasing;
	}

	public void setFlipCasing(boolean flipCasing) {
		this.flipCasing = flipCasing;
	}

	public int getThreads() {
		return threads;
	}

	public void setThreads(int threads) {
		this.threads = threads;
	}

	public boolean isDeadCodeElimination() {
		return deadCodeElimination;
	}

	public void setDeadCodeElimination(boolean deadCodeElimination) {
		this.deadCodeElimination = deadCodeElimination;
	}

	public boolean isBoostMode() {
		return boostMode;
	}

	public void setBoostMode(boolean boostMode) {
		this.boostMode = boostMode;
	}

	public RuntimeAddition getRuntimeAddition() {
		return runtimeAddition;
	}

	public void setRuntimeAddition(RuntimeAddition runtimeAddition) {
		this.runtimeAddition = runtimeAddition;
	}

	public boolean isInlineAssembly() {
		return inlineAssembly;
	}

	public void setInlineAssembly(boolean inlineAssembly) {
		this.inlineAssembly = inlineAssembly;
	}

}
