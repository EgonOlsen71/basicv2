package com.sixtyfour.test;

import java.io.FileInputStream;
import java.io.InputStream;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.extensions.graphics.GraphicsBasic;
import com.sixtyfour.extensions.textmode.ConsoleSupport;

/**
 * @author EgonOlsen
 * 
 */
public class ConsoleTest {
	public static void main(String[] args) {
		testConsole();
		testPrint();
		testShowImage();
	}

	private static void testShowImage() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/showimage.bas");
		Basic.registerExtension(new ConsoleSupport());
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.compile();
		try {
			InputStream is = new FileInputStream("src/test/resources/bin/textram.bin");
			byte[] buf = new byte[1024];
			int len = 0;
			int total = 0;
			while (len > -1) {
				len = is.read(buf);
				if (len > 0) {
					for (int i = 0; i < len; i++) {
						inty.getRam()[1024 + total + i] = (int) (buf[i] & 0xff);
					}
					total += len;
				}
			}
			is.close();
			
			is = new FileInputStream("src/test/resources/bin/colorram.bin");
			buf = new byte[1024];
			len = 0;
			total = 0;
			while (len > -1) {
				len = is.read(buf);
				if (len > 0) {
					for (int i = 0; i < len; i++) {
						inty.getRam()[55296 + total + i] = (int) (buf[i] & 0xff);
					}
					total += len;
				}
			}
			is.close();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		inty.run();
	}

	private static void testConsole() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/console.bas");
		Basic.registerExtension(new ConsoleSupport());
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testPrint() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/printconsole.bas");
		Basic.registerExtension(new ConsoleSupport());
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

}
