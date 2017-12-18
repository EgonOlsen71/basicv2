package com.sixtyfour.cbmnative;

/**
 * @author EgonOlsen
 *
 */
public interface PlatformProvider
{
  /**
   * @param line
   * @return
   */
  String getCall(String line);
  
  /**
   * @return
   */
  int getStartAddress();

  /**
   * @return
   */
  int getStackSize();
}
