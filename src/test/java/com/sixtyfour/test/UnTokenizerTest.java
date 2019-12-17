package com.sixtyfour.test;

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
    }

    public static void testUnTokenizer() {
	byte[] data=Loader.loadBlob("src/test/resources/prg/demo.prg");
	UnTokenizer unto=new UnTokenizer();
	List<String> res=unto.getText(data);
	res.forEach(p -> System.out.println(p));
    }

}
