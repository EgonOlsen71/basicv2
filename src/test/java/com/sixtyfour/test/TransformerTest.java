package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.mos6502.C64Platform;
import com.sixtyfour.cbmnative.mos6502.Transformer6502;
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
    basic.compile();
    List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(basic.getMachine(), basic.getPCode());
    List<String> nCode = new Transformer6502().transform(basic.getMachine(), new C64Platform(), mCode);
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
      basic.compile();
      List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(basic.getMachine(), basic.getPCode());
      List<String> nCode = new Transformer6502().transform(basic.getMachine(), new C64Platform(), mCode);
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
