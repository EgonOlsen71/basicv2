package com.sixtyfour.parser.assembly;

import com.sixtyfour.system.Machine;


/**
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
