package com.sixtyfour.elements.mnemonics;

/**
 * STZ is 65C02 specific and used only in X16 optimizations
 * 
 * @author EgonOlsen71
 *
 */
public class Stz extends AbstractMnemonic {

   	/**
   	 * Instantiates a new stz.
   	 */
   	public Stz() {
   		super("STZ", new int[] { 0, 0, 0x9C, 0x9E, 0, 0x64, 0x74, 0, 0, 0, 0, 0 });
   	}

}
