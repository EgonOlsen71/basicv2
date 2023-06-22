package com.sixtyfour.basicshell;

//import com.sixtyfour.cbmnative.mos6502.util.Converter;

/**
 * 
 * @author EgonOlsen71
 *
 */
public class ShellConverter {
	
	private static int[] TRANSLATION_TABLE = new int[]{0x80, 0x20, 0x00, 0x40, 0xC0, 0x60, 0x40, 0x60};
	
	private static int offset = 0xee00;
	
	private static int reverseOffset=0;
	
	/**
	 * 
	 * @param chars
	 * @param shell
	 * @return
	 */
	public static String translateToFont(String chars, BasicShell shell) {
		StringBuilder text = new StringBuilder();
		//chars = Converter.convertCase(chars, false);
		int sc;
		for (int i=0; i<chars.length(); i++) {
	        char c = chars.charAt(i);
	        System.out.println((int)c);
	        switch (c) {
		        case 147:
		        	shell.clearHome();
		        	break;
		        case 19:
		        	// Doesn't really work!?
		        	shell.home(); 
		        	break;
		        case 9:
		        	text.append("\t");
		        	break;
		        case 18:
		        	ShellConverter.reverseOn();
		        	break;
		        case 146:
		        	ShellConverter.reverseOff();
		        	break;
		        case '\n':
		        case '\r':
		        	text.append(c);
		        	break;
		        default:
		        	try {
		        		sc = c!=255?(TRANSLATION_TABLE[c >> 5] + (c & 0x1f)):94;
		        		if (sc<128) {
		        			sc+=reverseOffset;
		        		}
		        		text.append((char) (offset|sc));
		        	} catch(Exception e) {
		        		text.append(c);
		        	}
		        	break;
	        }
		}
		return text.toString();
	}
	
	/**
	 * 
	 */
	public static void reverseOn() {
		reverseOffset=128;
	}
	
	/**
	 * 
	 */
	public static void reverseOff() {
		reverseOffset=0;
	}
	
	/**
	 * 
	 */
	public static void toggleCasing() {
		if (offset==0xee00) {
			offset = 0xef00;
		} else {
			offset=0xee00;
		}
	}

}
