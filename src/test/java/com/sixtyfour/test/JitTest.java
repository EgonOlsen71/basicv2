package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.extensions.graphics.GraphicsBasic;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.Jit;


public class JitTest
{
  public static void main(String[] args)
  {
    testJittedTerm();
    testComplexCalculation();
    testFractal();
  }


  private static void testJittedTerm()
  {
    System.out.println("testStuff");
    Machine machine = new Machine();
    machine.add(new Variable("A", 23));
    machine.add(new Variable("B", 41));
    machine.add(new Variable("D", 123));
    machine.add(new Variable("F", 141));
    machine.add(new Variable("G", 3));
    machine.add(new Variable("Z", 1));
    machine.add(new Variable("T", 11));
    machine.add(new Variable("R", 21));
    machine.add(new Variable("P", 55));
    machine.add(new Variable("U", 22));
    machine.add(new Variable("O", 45));
    machine.add(new Variable("I", 67));
    String term = "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + (-(d*u))*(p+(o*i*z))*z+u";
    String wbres = Parser.addBrackets(term);
    System.out.println(wbres);

    Term res = Parser.getTerm(term, machine, false, true);
    System.out.println(res);
    System.out.println("Code: " + res.toCode());
  }
  
  
  private static void testComplexCalculation() {
    String[] prime = Loader.loadProgram("src/test/resources/basic/jittest.bas");
    Basic inty = new Basic(prime);
    inty.getMachine().setJit(new Jit());
    inty.run();
  }
  
  private static void testFractal() {
    String[] vary = Loader.loadProgram("src/test/resources/ext/fractal.bas");
    Basic.registerExtension(new GraphicsBasic());
    Basic inty = new Basic(vary);
    inty.getMachine().setJit(new Jit(12));
    inty.run();
  }
}
