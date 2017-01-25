package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.extensions.textmode.ConsoleSupport;

/**
 * @author EgonOlsen
 *
 */
public class ConsoleTest
{
  public static void main(String[] args)
  {
    testConsole();
  }

  private static void testConsole()
  {
    String[] vary = Loader.loadProgram("src/test/resources/ext/console.bas");
    Basic.registerExtension(new ConsoleSupport());
    Basic inty = new Basic(vary);
    inty.run();
  }

}
