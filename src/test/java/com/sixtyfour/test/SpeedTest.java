package com.sixtyfour.test;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;


public class SpeedTest
{
  public static void main(String[] args)
    throws Exception
  {
    String[] asm = Loader.loadProgram("src/test/resources/asm/selfmodify.asm");
    String[] basic = new String[] { "10fori%=8192to16192:pokei%,0:next" };

    // Prewarm
    for (int i = 0; i < 10; i++)
    {
      testBasic(basic);
      testAsm(asm);
    }

    long time = System.currentTimeMillis();
    for (int i = 0; i < 10000; i++)
    {
      System.out.println("Basic run: "+i);
      testBasic(basic);
    }
    long timeB = System.currentTimeMillis() - time;

    time = System.currentTimeMillis();
    for (int i = 0; i < 10000; i++)
    {
      System.out.println("Assembler run: "+i);
      testAsm(asm);
    }
    System.out.println("Assembler: " + (System.currentTimeMillis() - time) + "ms");
    System.out.println("Basic: " + timeB + "ms");
  }


  private static void testAsm(String[] code)
  {
    Assembler asm = new Assembler(code);
    asm.run();
  }


  private static void testBasic(String[] code)
  {
    Basic basic = new Basic(code);
    basic.run();
  }
}
