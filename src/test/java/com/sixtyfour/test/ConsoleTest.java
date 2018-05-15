package com.sixtyfour.test;

import java.io.FileInputStream;
import java.io.InputStream;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.extensions.graphics.GraphicsBasic;
import com.sixtyfour.extensions.textmode.ConsoleSupport;

/**
 * @author EgonOlsen
 * 
 */
public class ConsoleTest {
	
    private static CompilerConfig config=new CompilerConfig();
    public static void main(String[] args) {
		testConsole();
		testPrint();
		testShowImage();
		testGfxAndConsole();
	}

	private static void testGfxAndConsole() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/gfxandconsole.bas");
		Basic.registerExtension(new ConsoleSupport());
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.compile(config);
		loadImage(inty);
		inty.run(config);
	}

	private static void testShowImage() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/showimage.bas");
		Basic.registerExtension(new ConsoleSupport());
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.compile(config);
		loadImage(inty);
		inty.run(config);
	}

	private static void loadImage(Basic inty) {
		try {
			loadBinary(inty, "src/test/resources/bin/textram.bin", 1024);
			loadBinary(inty, "src/test/resources/bin/colorram.bin", 55296);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private static void loadBinary(Basic inty, String name, int targetAddr) throws Exception {
		InputStream is = new FileInputStream(name);
		byte[] buf = new byte[1024];
		int len = 0;
		int total = 0;
		while (len > -1) {
			len = is.read(buf);
			if (len > 0) {
				for (int i = 0; i < len; i++) {
					inty.getRam()[targetAddr + total + i] = (int) (buf[i] & 0xff);
				}
				total += len;
			}
		}
		is.close();
	}

	private static void testConsole() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/console.bas");
		Basic.registerExtension(new ConsoleSupport());
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run(config);
	}

	private static void testPrint() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/printconsole.bas");
		Basic.registerExtension(new ConsoleSupport());
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run(config);
	}

}
