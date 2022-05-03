package com.sixtyfour.config;

/**
 * Memory configuration for the native compiler. The values returned by this
 * class might not be applicable to all target platform. Javascript for example
 * doesn't care about or need any memory address informations.
 * 
 * @author EgonOlsen
 * 
 */
public class MemoryConfig {

	private int programStart = -1;
	private int variableStart = -1;
	private int stringEnd = -1;
	private int runtimeStart = -1;
	private int basicBufferStart = -1;
	private boolean optimizedTempStorage = true;
	private boolean optimizedStringPointers = false;

	/**
	 * Creates a new config with default values.
	 */
	public MemoryConfig() {
		//
	}

	/**
	 * Creates a new memory config.
	 * 
	 * @param programStart  the start of the compiled code
	 * @param runtimeStart  the start of the runtime
	 * @param variableStart the start of the variables
	 * @param stringEnd     the end of the string memory
	 */
	public MemoryConfig(int programStart, int runtimeStart, int variableStart, int stringEnd) {
		this.programStart = programStart;
		this.variableStart = variableStart;
		this.stringEnd = stringEnd;
		this.runtimeStart = runtimeStart;
	}

	public int getProgramStart() {
		return programStart;
	}

	public void setProgramStart(int programStart) {
		this.programStart = programStart;
	}

	public int getVariableStart() {
		return variableStart;
	}

	public void setVariableStart(int variableStart) {
		this.variableStart = variableStart;
	}

	public int getStringEnd() {
		return stringEnd;
	}

	public void setStringEnd(int stringEnd) {
		this.stringEnd = stringEnd;
	}

	public boolean isValid() {
		return !(stringEnd != -1 && variableStart != -1 && stringEnd < variableStart);
	}

	public int getRuntimeStart() {
		return runtimeStart;
	}

	public void setRuntimeStart(int runtimeStart) {
		this.runtimeStart = runtimeStart;
	}

	public boolean isOptimizedTempStorage() {
		return optimizedTempStorage;
	}

	public void setOptimizedTempStorage(boolean optimizedTempStorage) {
		this.optimizedTempStorage = optimizedTempStorage;
	}

	public int getBasicBufferStart() {
		return basicBufferStart;
	}

	public void setBasicBufferStart(int basicBufferStart) {
		this.basicBufferStart = basicBufferStart;
	}

	public boolean isOptimizedStringPointers() {
		return optimizedStringPointers;
	}

	public void setOptimizedStringPointers(boolean optimizedStringPointers) {
		this.optimizedStringPointers = optimizedStringPointers;
	}
}
