package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 *
 */
public abstract class GeneratorBase implements Generator
{

  protected String createAddress(String addr, int offset) {
    try {
      int ia=Integer.parseInt(addr);
      ia+=offset;
      return String.valueOf(ia);
    } catch(Exception e) {
      return addr+"+"+offset;
    }
  }
  
}
