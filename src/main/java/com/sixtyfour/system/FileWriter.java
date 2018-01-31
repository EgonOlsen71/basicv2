package com.sixtyfour.system;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * @author EgonOlsen
 * 
 */
public class FileWriter {

	/**
	 * @param prg
	 * @param fileName
	 * @throws IOException
	 */
	public static void writeAsPrg(Program prg, String fileName) throws IOException {
		writeAsPrg(prg, new FileOutputStream(fileName));
	}

	/**
	 * @param prg
	 * @param os
	 */
	public static void writeAsPrg(Program prg, OutputStream os) throws IOException {
		BufferedOutputStream bos = null;
		try {
			bos = new BufferedOutputStream(os);
			bos.write(prg.getCodeStart() % 256);
			bos.write(prg.getCodeStart() >> 8);
			int[] bin = prg.getParts().get(0).getBytes();
			for (int b : bin) {
				bos.write(b);
			}
		} finally {
			if (bos != null) {
				bos.close();
			}
		}

	}
}
