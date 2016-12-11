package com.sixtyfour.plugins.impl;

import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class RamSystemCallListener implements SystemCallListener {

	private Machine machine;

	public RamSystemCallListener(Machine machine) {
		this.machine = machine;
	}

	@Override
	public void sys(int addr, Object... params) {
		machine.getCpu().execute(addr);
	}

}
