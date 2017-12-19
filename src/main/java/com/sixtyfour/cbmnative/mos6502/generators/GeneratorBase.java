package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public abstract class GeneratorBase implements Generator {

	// Zeropage address for temp. data, actually ARG/FAC1
	protected final static int TMP_ZP = 105;

	protected String createAddress(String addr, int offset) {
		try {
			int ia = Integer.parseInt(addr);
			ia += offset;
			return String.valueOf(ia);
		} catch (Exception e) {
			return addr + "+" + offset;
		}
	}

}
