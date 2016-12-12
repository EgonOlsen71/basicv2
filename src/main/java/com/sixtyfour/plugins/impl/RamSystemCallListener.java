package com.sixtyfour.plugins.impl;

import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.system.Machine;


/**
 * A system call listener implementation that executes actual machine code in the ram of the machine by using a 6502
 * emulation layer.
 * 
 * @author EgonOlsen
 * 
 */
public class RamSystemCallListener
  implements SystemCallListener
{

  private Machine machine;


  /**
   * Creates a new instance.
   * 
   * @param machine the machine to use
   */
  public RamSystemCallListener(Machine machine)
  {
    this.machine = machine;
  }


  @Override
  public void sys(int addr, Object... params)
  {
    machine.getCpu().execute(addr);
  }

}
