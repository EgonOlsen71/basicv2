package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;


public class Mov
  implements Generator
{

  @Override
  public String getMnemonic()
  {
    return "MOV";
  }


  @Override
  public void generateCode(String line, List<String> nCode, List<String> subCode)
  {
    // TODO Auto-generated method stub
    System.out.println("MOV: " + line);
  }

}
