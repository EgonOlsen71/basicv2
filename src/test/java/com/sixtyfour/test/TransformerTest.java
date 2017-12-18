package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.system.Program;
import com.sixtyfour.system.ProgramPart;


/**
 * @author Foerster-H
 *
 */
public class TransformerTest
{
  public static void main(String[] args)
    throws Exception
  {
    testTransformer1();
    testTransformer2();
  }


  private static void testTransformer1()
    throws Exception
  {
    System.out.println("\n\ntestTransformer1");
    String[] vary = Loader.loadProgram("src/test/resources/basic/affine.bas");

    vary = Preprocessor.convertToLineNumbers(vary);
    Basic basic = new Basic(vary);
    List<String> nCode = NativeCompiler.getCompiler().compile(basic);
    for (String line : nCode)
    {
      System.out.println(line);
    }

    Assembler assy = new Assembler(nCode);
    assy.compile();
    assy.run();
    Program prg = assy.getProgram();
    for (ProgramPart pp : prg.getParts())
    {
      System.out.println("Size: " + pp.size());
    }
  }
  
  private static void testTransformer2()
      throws Exception
    {
      System.out.println("\n\ntestTransformer2");
      String[] vary = Loader.loadProgram("src/test/resources/transform/test1.bas");

      Basic basic = new Basic(vary);
      List<String> nCode = NativeCompiler.getCompiler().compile(basic);
      for (String line : nCode)
      {
        System.out.println(line);
      }

      Assembler assy = new Assembler(nCode);
      assy.compile();
      assy.run();
      Program prg = assy.getProgram();
      for (ProgramPart pp : prg.getParts())
      {
        System.out.println("Size: " + pp.size());
      }
    }
}
