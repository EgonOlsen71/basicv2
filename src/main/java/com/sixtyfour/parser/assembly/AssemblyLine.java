package com.sixtyfour.parser.assembly;

import java.util.List;
import java.util.Set;

/**
 * 
 * @author Foerster-H
 *
 */
public class AssemblyLine {

	private List<String> code;
	
	private Set<String> varNames;

	public List<String> getCode() {
		return code;
	}

	public void setCode(List<String> code) {
		this.code = code;
	}

	public Set<String> getVarNames() {
		return varNames;
	}

	public void setVarNames(Set<String> varNames) {
		this.varNames = varNames;
	}
	
	
	
}
