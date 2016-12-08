package com.sixtyfour.test;

import java.util.Arrays;

import com.sixtyfour.Assembler;
import com.sixtyfour.Loader;


public class AssemblerTest
{
  public static void main(String[] args)
  {
    // testAssembler();
    testLda();
    testLdx();
    testLdy();
  }


  private static void testLda()
  {
    String line = "*=$c000  \n TEST=$a001 \n  lda #$c011 \n";
    line += "lda $ffff \n";
    line += "lda $fe \n";
    line += "lda $fd,X \n";
    line += "lda ($fc,X) \n";
    line += "lda ($fb),y \n";
    line += "lda TEST \n";
    int[] bin = new Assembler(line).compile();
    System.out.println(Arrays.toString(bin));
  }


  private static void testLdx()
  {
    String line = "*=$c000  \n TEST=$a001 \n  ldx #$c011 \n";
    line += "ldx $ffff \n";
    line += "ldx $fe \n";
    line += "ldx $fd,Y \n";
    line += "ldx $bbbb,y \n";
    line += "ldx TEST \n";
    int[] bin = new Assembler(line).compile();
    System.out.println(Arrays.toString(bin));
  }


  private static void testLdy()
  {
    String line = "*=$c000  \n TEST=$a001 \n  ldy #$c011 \n";
    line += "ldy $ffff \n";
    line += "ldy $fe \n";
    line += "ldy $fd,x \n";
    line += "ldy $bbbb,x \n";
    line += "ldy TEST \n";
    int[] bin = new Assembler(line).compile();
    System.out.println(Arrays.toString(bin));
  }


  private static void testAssembler()
  {
    String[] code = Loader.loadProgram("src/test/resources/asm/example.asm");
    Assembler asm = new Assembler(code);
    int[] binary = asm.compile();
  }

}
