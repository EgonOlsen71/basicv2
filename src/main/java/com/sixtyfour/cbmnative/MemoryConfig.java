package com.sixtyfour.cbmnative;

/**
 * @author EgonOlsen
 *
 */
public class MemoryConfig {

    private int programStart = -1;
    private int variableStart = -1;
    private int stringEnd = -1;

    public MemoryConfig() {
	//
    }

    public MemoryConfig(int programStart, int variableStart, int stringEnd) {
	this.programStart = programStart;
	this.variableStart = variableStart;
	this.stringEnd = stringEnd;
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
}
