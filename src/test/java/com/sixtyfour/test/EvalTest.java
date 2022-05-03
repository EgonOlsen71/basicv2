package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;

public class EvalTest {
	private static CompilerConfig config = new CompilerConfig();

	public static void main(String[] args) {
		testEval();
	}

	public static void testEval() {
		String[] vary = Loader.loadProgram("src/test/resources/basic/eval.bas");
		for (String line : vary) {
			System.out.println(line);
		}
		Basic inty = new Basic(vary);
		inty.compile(config);
		inty.run(config);
	}
}
