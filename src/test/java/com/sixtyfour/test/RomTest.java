package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.plugins.impl.RamSystemCallListener;

/**
 * @author EgonOlsen
 *
 */
public class RomTest
{
  public static void main(String[] args)
  {
    testRomAccess();
  }


  private static void testRomAccess()
  {
    String[] vary = Loader.loadProgram("src/test/resources/rom/romtest.bas");
    Basic inty = new Basic(vary);
    inty.getMachine().addRoms();
    inty.setSystemCallListener(new RamSystemCallListener(inty.getMachine()));
    inty.run();
  }
}
