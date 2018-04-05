package com.sixtyfour.system;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.parser.assembly.LabelsContainer;

/**
 * A Program is a compiled assembler program. If has a starting address and a
 * list of parts.
 * 
 * 
 * @author EgonOlsen
 * 
 */
public class Program {

	private int codeStart;
	private List<ProgramPart> parts = new ArrayList<ProgramPart>();
	private LabelsContainer labelsContainer = null;

	/**
	 * Creates a new program instance.
	 */
	public Program() {
		//
	}

	/**
	 * Returns a program's parts in no particular order.
	 * 
	 * @return the parts
	 */
	public List<ProgramPart> getParts() {
		return parts;
	}

	/**
	 * Adds a new part to a program.
	 * 
	 * @param part
	 *            the new part
	 */
	public void addPart(ProgramPart part) {
		parts.add(part);
	}

	/**
	 * Returns the starting address for this program. This value will be set at
	 * compile time based on the first block of actual assembler code. If that
	 * assumption isn't true, you have to set this value manually before running
	 * this program.
	 * 
	 * @return the starting address
	 */
	public int getCodeStart() {
		return codeStart;
	}

	/**
	 * Sets a new starting address.
	 * 
	 * @param codeStart
	 *            the new address
	 */
	public void setCodeStart(int codeStart) {
		this.codeStart = codeStart;
	}

	/**
	 * @return
	 */
	public LabelsContainer getLabelsContainer() {
	    return labelsContainer;
	}

	/**
	 * @param labelsContainer
	 */
	public void setLabelsContainer(LabelsContainer labelsContainer) {
	    this.labelsContainer = labelsContainer;
	}

}
