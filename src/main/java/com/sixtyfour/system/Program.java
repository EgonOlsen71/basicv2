package com.sixtyfour.system;

import java.util.ArrayList;
import java.util.List;

public class Program {

	private int codeStart;
	private List<ProgramPart> parts = new ArrayList<ProgramPart>();

	public Program() {
		//
	}

	public List<ProgramPart> getParts() {
		return parts;
	}

	public void addPart(ProgramPart part) {
		parts.add(part);
	}

	public int getCodeStart() {
		return codeStart;
	}

	public void setCodeStart(int codeStart) {
		this.codeStart = codeStart;
	}

}
