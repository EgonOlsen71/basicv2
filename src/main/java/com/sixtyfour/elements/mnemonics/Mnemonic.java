package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;

/**
 *
 */
public interface Mnemonic {
	int parse(String linePart, int addr, Machine machine, ConstantsContainer ccon, LabelsContainer lcon);

	boolean isMnemonic(String linePart);

	boolean isRelative();

	boolean isSingle();
	
	boolean isJump();

}
