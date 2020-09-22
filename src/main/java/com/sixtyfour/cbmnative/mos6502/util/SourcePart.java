package com.sixtyfour.cbmnative.mos6502.util;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;

/**
 * Represents a part of a 6502 assembly listing.
 * 
 * @author EgonOlsen
 *
 */
public class SourcePart {

	private int startLine;
	private int endLine;
	private boolean compiledCode;
	private List<String> src;

	public SourcePart(int start, int end, List<String> src) {
		startLine = start;
		endLine = end;
		this.src = new ArrayList<>(src);
	}

	public int getStartLine() {
		return startLine;
	}

	public int getEndLine() {
		return endLine;
	}

	public List<String> getSourcePart() {
		return src.subList(startLine, endLine);
	}

	public int calculateCodeSize(CompilerConfig config, ConstantsContainer ccon, LabelsContainer lcon) {
		int size = 0;
		Machine machine = new Machine();

		for (int i = startLine; i < endLine; i++) {
			size += Assembler.compileSingleLine(machine, ccon, lcon, config, src.get(i));
		}
		return size;
	}

	public boolean isCompiledCode() {
		return compiledCode;
	}

	public void setCompiledCode(boolean compiledCode) {
		this.compiledCode = compiledCode;
	}

}
