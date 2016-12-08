package com.sixtyfour.elements.mnemonics;

public class Parameters
{
  private Integer value;
  private Integer addr;
  private boolean x;
  private boolean y;
  private boolean indirect;
  private boolean zeropage;


  public Integer getValue()
  {
    return value;
  }


  public void setValue(Integer value)
  {
    this.value = value;
  }


  public Integer getAddr()
  {
    return addr;
  }


  public void setAddr(Integer addr)
  {
    this.addr = addr;
  }


  public boolean isX()
  {
    return x;
  }


  public void setX(boolean x)
  {
    this.x = x;
  }


  public boolean isY()
  {
    return y;
  }


  public void setY(boolean y)
  {
    this.y = y;
  }


  public boolean isIndirect()
  {
    return indirect;
  }


  public void setIndirect(boolean indirect)
  {
    this.indirect = indirect;
  }


  public boolean isZeropage()
  {
    return zeropage;
  }


  public void setZeropage(boolean zeropage)
  {
    this.zeropage = zeropage;
  }

}
