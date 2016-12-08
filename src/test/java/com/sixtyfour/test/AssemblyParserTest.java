package com.sixtyfour.test;

import com.sixtyfour.parser.assembly.AssemblyParser;


public class AssemblyParserTest
{
  public static void main(String[] args)
  {
    testConstants();
    testBytes();
    testLabel();
  }


  private static void testLabel()
  {
    String line = "start        lda #147  ";
    System.out.println(AssemblyParser.getLabel(line));
  }


  private static void testBytes()
  {
    int c = 49157;
    System.out.println(AssemblyParser.getLowByte(c));
    System.out.println(AssemblyParser.getHighByte(c));
  }


  private static void testConstants()
  {
    System.out.println(AssemblyParser.getConstant("*=$c000"));
    System.out.println(AssemblyParser.getConstant("BSOUTy = 63424"));
    System.out.println(AssemblyParser.getConstant(AssemblyParser.truncateComments("*=$c001 ;This is a comment!;;;")));
  }
}
