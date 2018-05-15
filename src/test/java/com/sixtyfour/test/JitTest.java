package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.extensions.graphics.GraphicsBasic;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.Jit;

/**
 * Some tests for the experimental JIT compiler
 * 
 * @author EgonOlsen
 * 
 */
public class JitTest {
	private static CompilerConfig config = new CompilerConfig();

	public static void main(String[] args) {
		testJittedTerm();
		testComplexCalculation();
		testFractal();
	}

	private static void testJittedTerm() {
		System.out.println("testStuff");
		Machine machine = new Machine();
		machine.setJit(new Jit());
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
		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res);
		System.out.println("Code: " + res.toCode(machine));
	}

	private static void testComplexCalculation() {
		String[] prime = Loader.loadProgram("src/test/resources/basic/jittest.bas");
		Basic inty = new Basic(prime);
		inty.enableJit(0);
		inty.run(config);
	}

	private static void testFractal() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/fractal.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.enableJit(3);
		inty.run(config);
	}
}
