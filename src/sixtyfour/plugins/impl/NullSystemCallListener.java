package sixtyfour.plugins.impl;

import sixtyfour.plugins.SystemCallListener;


public class NullSystemCallListener
  implements SystemCallListener
{

  @Override
  public void sys(int addr, Object... params)
  {
    //
  }

}
