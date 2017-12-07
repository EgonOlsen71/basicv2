package com.sixtyfour.cbmnative;

/**
 * @author Foerster-H
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
}
