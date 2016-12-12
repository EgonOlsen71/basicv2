package com.sixtyfour.parser.assembly;

import com.sixtyfour.system.Machine;


/**
 * An byte constant (i.e. an 8bit value). Bytes will be stored as ints as well, 
 * but their value never exceeds 255 and applying them only writes one byte into memory.
 * 
 * @author EgonOlsen
 *
 */
public class ConstantByte
  implements ConstantValue
{
  private String name;
  private int value;


  public ConstantByte(String name, int value)
  {
    this.name = name;
    this.value = value;
  }


  public String getName()
  {
    return name;
  }


  public int getValue()
  {
    return value;
  }


  @Override
  public String toString()
  {
    return name + "=" + value;
  }


  @Override
  public int apply(Machine machine, int address)
  {
    machine.getRam()[address++] = value;
    return address;
  }

}
