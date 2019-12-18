package com.sixtyfour.test;

import java.io.PrintWriter;
import java.util.List;

import com.sixtyfour.Loader;
import com.sixtyfour.parser.cbmnative.UnTokenizer;

/**
 * @author EgonOlsen71
 *
 */
public class UnTokenizerTest {

	public static void main(String[] args) {
		testUnTokenizer();
		testUnTokenizerX16();
	}

	public static void testUnTokenizer() {
		byte[] data = Loader.loadBlob("src/test/resources/prg/demo.prg");
		UnTokenizer unto = new UnTokenizer();
		List<String> res = unto.getText(data, false);
		res.forEach(p -> System.out.println(p));
		try (PrintWriter pw = new PrintWriter("src/test/resources/prg/demo.bas")) {
			for (String line : res) {
				pw.println(line);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public static void testUnTokenizerX16() {
		byte[] data = Loader.loadBlob("src/test/resources/prg/cmds.prg");
		UnTokenizer unto = new UnTokenizer();
		List<String> res = unto.getText(data, true);
		res.forEach(p -> System.out.println(p));
		try (PrintWriter pw = new PrintWriter("src/test/resources/prg/cmds.bas")) {
			for (String line : res) {
				pw.println(line);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}
