package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.extensions.textmode.ConsoleSupport;
import com.sixtyfour.system.CompilerConfig;

public class LyricsTest {
    private static CompilerConfig config=new CompilerConfig();
	public static void main(String[] args) {
		testLyrics();
	}

	private static void testLyrics() {
		String[] vary = Loader.loadProgram("src/test/resources/basic/lyrix.BAS");
		Basic.registerExtension(ConsoleSupport.class);
		Basic inty = new Basic(vary);
		inty.run(config);
	}

}
