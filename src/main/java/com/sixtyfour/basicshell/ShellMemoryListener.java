package com.sixtyfour.basicshell;

import com.sixtyfour.plugins.MemoryListener;

/**
 * 
 * @author EgonOlsen71
 *
 */
public class ShellMemoryListener implements MemoryListener {

	private BasicShell shell;
	
	public ShellMemoryListener(BasicShell shellFrame) {
		this.shell = shellFrame;
	}
	
	@Override
	public void poke(int addr, int value) {
		switch(addr) {
			case 53281:
				shell.setBackgroundColor(value);
				break;
			case 646:
				shell.setFontColor(value);
				break;
			case 199:
				if (value==0) {
					ShellConverter.reverseOff();
				} else {
					ShellConverter.reverseOn();
				}
				break;
			default:
				break;
		}
	}

	@Override
	public Integer peek(int addr) {
		return null;
	}

	@Override
	public boolean wait(int addr, int value, int inverse) {
		return false;
	}

}
