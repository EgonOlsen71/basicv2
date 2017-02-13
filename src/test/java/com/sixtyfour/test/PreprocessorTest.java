package com.sixtyfour.test;

import com.sixtyfour.Loader;
import com.sixtyfour.parser.Preprocessor;


public class PreprocessorTest
{
  public static void main(String[] args)
  {
    testPrePro();
  }


  private static void testPrePro()
  {
    String[] code = Loader.loadProgram("src/test/resources/pre/withlabels.BAS");
    String[] res = Preprocessor.convertToLineNumbers(code);

    for (String line : res)
    {
      System.out.println(line);
    }
  }
}
