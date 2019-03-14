package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;

/**
 * Common interface for a Mnemonic.
 */
public interface Mnemonic {

	/**
	 * Parse a mnemonic into an opcode and its operands.
	 * 
	 * @param linePart the line that contains the mnemonic
	 * @param addr     the current address in memory in which the new opcode will be
	 *                 stored
	 * @param machine  the current machine
	 * @param ccon     a container for known constants
	 * @param lcon     a container for known and future labels
	 * @return the next free memory address after inserting the new opcode and its
	 *         operands.
	 */
	int parse(CompilerConfig config, String linePart, int addr, Machine machine, ConstantsContainer ccon,
			LabelsContainer lcon);

	/**
	 * Returns true if the implementation can handle the given line's content.
	 * 
	 * @param linePart the line
	 * @return can we handle it?
	 */
	boolean isMnemonic(String linePart);

	/**
	 * Returns true if the mnemonic uses relative addressing.
	 * 
	 * @return does it?
	 */
	boolean isRelative();

	/**
	 * Returns true if the mnemonic has no operands.
	 * 
	 * @return is it single?
	 */
	boolean isSingle();

	/**
	 * Returns true if the mnemonic is a jump.
	 * 
	 * @return is it a jump?
	 */
	boolean isJump();

	/**
	 * Returns the abstract instruction in human readable form.
	 * 
	 * @return the instruction or null, if the opcode doesn't belong to this
	 *         mnemonic
	 */
	String getInstruction(int opcode);

	/**
	 * Returns an optional parameter (like A for ROL, ROR, ASL, LSR) or null, if
	 * there is none.
	 * 
	 * @return the parameter or null
	 */
	String getOptionalParameter();

}
