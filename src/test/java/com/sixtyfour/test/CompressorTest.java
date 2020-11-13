package com.sixtyfour.test;

import java.util.Arrays;

import com.sixtyfour.Loader;
import com.sixtyfour.compression.Compressor;

/**
 * @author EgonOlsen
 *
 */
public class CompressorTest {

	private static final int MAX_WINDOW_SIZE_1 = 32;
	private static final int MAX_WINDOW_SIZE_2 = 128;

	public static void main(String[] args) throws Exception {
		byte[] text = Loader.loadBlob("src/test/resources/compressor/test.txt");
		byte[] comp1 = Compressor.compress(text, MAX_WINDOW_SIZE_1, true);
		byte[] comp2 = Compressor.compress(text, MAX_WINDOW_SIZE_2, true);

		System.out.println(text.length + " / " + comp1.length + " / " + comp2.length);

		byte[] uncomp1 = Compressor.decompress(comp1);
		System.out.println(Arrays.equals(uncomp1, text));
	}

}
