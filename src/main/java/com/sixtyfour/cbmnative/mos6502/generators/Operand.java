package com.sixtyfour.cbmnative.mos6502.generators;

import com.sixtyfour.elements.Type;


/**
 * @author Foerster-H
 *
 */
public class Operand
{
  private String register;
  private Type type;
  private String address;
  private boolean indexed;


  public String getRegister()
  {
    return register;
  }


  public String getRegisterName()
  {
    return register + "_REG";
  }


  public void setRegister(String register)
  {
    this.register = register;
    if (register != null)
    {
      type = Type.REAL;
      if (register.equalsIgnoreCase("A") || register.equalsIgnoreCase("B") || register.equalsIgnoreCase("G"))
      {
        type = Type.INTEGER;
      }
    }
  }


  public Type getType()
  {
    return type;
  }


  public void setType(Type type)
  {
    this.type = type;
  }


  public String getAddress()
  {
    return address;
  }


  public void setAddress(String address)
  {
    this.address = address;
  }


  public boolean isIndexed()
  {
    return indexed;
  }


  public void setIndexed(boolean indexed)
  {
    this.indexed = indexed;
  }


  public boolean isRegister()
  {
    return register != null;
  }


  public boolean isAddress()
  {
    return address != null;
  }


  @Override
  public String toString()
  {
    return register + " / " + type + " / " + address + " / " + indexed;
  }
}
