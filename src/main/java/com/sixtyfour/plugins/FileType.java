/*
 * 
 */
package com.sixtyfour.plugins;

/**
 * The Enum FileType.
 */
public enum FileType {

	/** The prg. */
	PRG('P'),
	/** The seq. */
	SEQ('S'),
	/** The usr. */
	USR('U'),
	/** The rel. */
	REL('L');

	/** The short cut. */
	private char shortCut;

	/**
	 * Instantiates a new file type.
	 * 
	 * @param shortCut
	 *            the short cut
	 */
	FileType(char shortCut) {
		this.shortCut = shortCut;
	}

	/**
	 * Gets the file type.
	 * 
	 * @param type
	 *            the type
	 * @return the file type
	 */
	public static FileType getFileType(String type) {
		if (type == null || type.isEmpty()) {
			return PRG;
		}
		char c = Character.toUpperCase(type.charAt(0));
		for (FileType fm : FileType.values()) {
			if (fm.shortCut == c) {
				return fm;
			}
		}
		return PRG;
	}
}
