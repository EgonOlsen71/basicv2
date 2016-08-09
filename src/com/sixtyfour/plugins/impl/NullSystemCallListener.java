/*
 * 
 */
package com.sixtyfour.plugins.impl;

import com.sixtyfour.plugins.SystemCallListener;


/**
 * The listener interface for receiving nullSystemCall events. The class that is
 * interested in processing a nullSystemCall event implements this interface,
 * and the object created with that class is registered with a component using
 * the component's <code>addNullSystemCallListener<code> method. When
 * the nullSystemCall event occurs, that object's appropriate
 * method is invoked.
 * 
 * @see NullSystemCallEvent
 */
public class NullSystemCallListener
  implements SystemCallListener
{

  /* (non-Javadoc)
   * @see sixtyfour.plugins.SystemCallListener#sys(int, java.lang.Object[])
   */
  @Override
  public void sys(int addr, Object... params)
  {
    //
  }

}
