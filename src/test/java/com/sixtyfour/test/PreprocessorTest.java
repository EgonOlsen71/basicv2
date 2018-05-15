package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.system.CompilerConfig;

public class PreprocessorTest {
    private static CompilerConfig config=new CompilerConfig();
	public static void main(String[] args) {
		testPrePro();
		testPrePro2();
	}

	private static void testPrePro() {
		String[] code = Loader.loadProgram("src/test/resources/pre/withlabels.BAS");
		String[] res = Preprocessor.convertToLineNumbers(code);

		for (String line : res) {
			System.out.println(line);
		}
	}

	private static void testPrePro2() {
		String[] code = Loader.loadProgram("src/test/resources/pre/labels2.BAS");
		String[] res = Preprocessor.convertToLineNumbers(code);

		for (String line : res) {
			System.out.println(line);
		}
		Basic bas = new Basic(res);
		bas.run(config);
	}
}
