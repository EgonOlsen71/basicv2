package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;


public class NativeCompilerTest
{

  public static void main(String[] args)
  {
    testExpressions();
  }


  private static void testExpressions()
  {
    System.out.println("testExpression1");
    String term = "2+-(32-A)^10-1+(2*A)/(8*B)";
    // String term = "(2*A)+(8*B)";
    //String term = "-1+(2*A)/(8*B)";
    String s = Parser.addBrackets(term);
    System.out.println(s);
    Machine machine = new Machine();
    Term t = Parser.getTerm(term, machine, false, true);
    System.out.println(t);
    List<String> ret = t.evalToExpression(machine);
    
    System.out.println("Expression:");
    for (String line : ret)
    {
      System.out.println("--> " + line);
    }
    
    List<String> code=new NativeCompiler().compileToPseudoCode(machine, t);
    System.out.println("Pseudocode of "+term+" :");
    for (String line : code)
    {
      System.out.println("----> " + line);
    }
  }

}
