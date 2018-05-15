package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.extensions.graphics.GraphicsBasic;
import com.sixtyfour.extensions.textmode.ConsoleSupport;
import com.sixtyfour.parser.Preprocessor;

public class FrogTest {
    private static CompilerConfig config=new CompilerConfig();
    public static void main(String[] args) {
		testFrog();
		testFrog2();
	}

	public static void testFrog() {
		String[] vary = Preprocessor.convertToLineNumbers(Loader.loadProgram("src/test/resources/demo/frog.bas"));
		for (String line : vary) {
			System.out.println(line);
		}
		Basic.registerExtension(ConsoleSupport.class);
		Basic.registerExtension(GraphicsBasic.class);
		Basic inty = new Basic(vary);
		inty.compile(config);
		inty.run(config);
	}

	public static void testFrog2() {
		String[] vary = Preprocessor.convertToLineNumbers(Loader.loadProgram("src/test/resources/demo/frog2.bas"));
		for (String line : vary) {
			System.out.println(line);
		}
		Basic.registerExtension(ConsoleSupport.class);
		Basic.registerExtension(GraphicsBasic.class);
		Basic inty = new Basic(vary);
		inty.compile(config);
		inty.run(config);
	}
}
