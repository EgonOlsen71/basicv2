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

	private final static int[] HEADER = new int[] { 0x13, 0x08, 0x00, 0x00, 0x9e, 0x32, 0x30, 0x36, 0x38, 0x20, 0x4d, 0x4f, 0x53, 0x50, 0x45, 0x45, 0x44, 0x00, 0x00, 0x00 };

	/**
	 * @param prg
	 * @param fileName
	 * @throws IOException
	 */
	public static void writeAsPrg(Program prg, String fileName, boolean withBasicHeader) throws IOException {
		writeAsPrg(prg, new FileOutputStream(fileName), withBasicHeader);
	}

	/**
	 * @param prg
	 * @param os
	 */
	public static void writeAsPrg(Program prg, OutputStream os, boolean withBasicHeader) throws IOException {
		BufferedOutputStream bos = null;
		int codeStart = prg.getCodeStart();
		int[] header = null;
		if (withBasicHeader) {
			if (codeStart >= 2070 && codeStart < 2300) {
				header = new int[codeStart - 2049];
				System.arraycopy(HEADER, 0, header, 0, HEADER.length);
				String hss = String.valueOf(codeStart);
				for (int i = 0; i < hss.length(); i++) {
					char c = hss.charAt(i);
					int cc = ((int) c - (int) '0') + 0x30;
					header[i + 5] = cc;
				}
				codeStart = 2049;
			} else {
				throw new RuntimeException("Starting address out of range for a BASIC header: " + prg.getCodeStart());
			}
		}
		try {
			bos = new BufferedOutputStream(os);
			bos.write(codeStart % 256);
			bos.write(codeStart >> 8);
			if (header != null) {
				for (int b : header) {
					bos.write(b);
				}
			}
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
