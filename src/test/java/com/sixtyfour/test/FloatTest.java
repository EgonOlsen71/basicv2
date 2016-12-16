package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.system.Cpu;


/**
 * Test for floating point conversions
 * 
 * @author Foerster-H
 *
 */
public class FloatTest
{

  public static void main(String[] args)
  {
    testFloat();
  }


  public static void testFloat()
  {
    Basic basic = new Basic("10 poke97,152:poke98,53:poke99,68:poke100,122:poke101,0:poke102,0");
    basic.run();
    Cpu cpu = basic.getMachine().getCpu();
    System.out.println(cpu.convertFloat(97) + "/" + 11879546.0d);
  }

}
