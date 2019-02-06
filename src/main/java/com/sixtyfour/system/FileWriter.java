package com.sixtyfour.system;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import com.sixtyfour.Logger;

/**
 * Some helper methods for writing out programs and/or data
 * 
 * @author EgonOlsen
 * 
 */
public class FileWriter {

    private final static int[] HEADER = new int[] { 0x16, 0x08, 0x00, 0x00, 0x9e, 0x32, 0x30, 0x36, 0x38, 0x3a, 0x8f,
	    0x20, 0x4d, 0x4f, 0x53, 0x50, 0x45, 0x45, 0x44, 0x00, 0x00, 0x00 };

    /**
     * Writes the program into a file that contains the BASIC program to read
     * the program from datas.
     * 
     * @param prg
     * @param fileName
     * @throws IOException
     */
    public static void writeAsDatas(Program prg, String fileName, int lineNumber) throws IOException {
	writeAsDatas(prg, new FileOutputStream(fileName), lineNumber);
    }

    /**
     * Writes the program into a file that contains the BASIC program to read
     * the program from datas.
     * 
     * @param prg
     * @param fileOutputStream
     */
    private static void writeAsDatas(Program prg, FileOutputStream fileOutputStream, int lineNumber) {
	List<ProgramPart> parts = new ArrayList<>(prg.getParts());
	Collections.sort(parts);

	try (PrintWriter pw = new PrintWriter(fileOutputStream)) {
	    for (ProgramPart part : parts) {
		pw.println((lineNumber++) + " for qq=" + part.getAddress() + " to " + (part.getEndAddress()-1)
			+ ":read dq:pokeqq,dq:next");
	    }
	    pw.println((lineNumber++) + " return");

	    StringBuilder sb = new StringBuilder();
	    for (ProgramPart part : parts) {
		for (int bite : part.getBytes()) {
		    boolean first = false;
		    if (sb.length() == 0) {
			sb.append(lineNumber++).append(" data ");
			first = true;
		    }
		    if (!first) {
			sb.append(",");
		    }
		    sb.append(((int) bite) & 0xff);
		    if (sb.length() > 70) {
			pw.println(sb.toString());
			sb.setLength(0);
		    }
		}
		if (sb.length() > 0 && !sb.toString().endsWith(" data ")) {
		    pw.println(sb.toString());
		}
		sb.setLength(0);
	    }
	} catch (Exception e) {
	    Logger.log("Failed to write data file!", e);
	    throw e;
	}
    }

    /**
     * @param prg
     * @param fileName
     * @param withBasicHeader
     * @throws IOException
     */
    public static void writeAsPrg(Program prg, String fileName, boolean withBasicHeader) throws IOException {
   	writeAsPrg(prg, new FileOutputStream(fileName), withBasicHeader, 2049);
    }
    
    /**
     * @param prg
     * @param os
     * @param withBasicHeader
     * @throws IOException
     */
    public static void writeAsPrg(Program prg, OutputStream os, boolean withBasicHeader) throws IOException {
	writeAsPrg(prg, os, withBasicHeader, 2049);
    }
    
    /**
     * @param prg
     * @param fileName
     * @throws IOException
     */
    public static void writeAsPrg(Program prg, String fileName, boolean withBasicHeader, int baseAddr) throws IOException {
	writeAsPrg(prg, new FileOutputStream(fileName), withBasicHeader, baseAddr);
    }

    /**
     * @param prg
     * @param os
     */
    public static void writeAsPrg(Program prg, OutputStream os, boolean withBasicHeader, int baseAddr) throws IOException {
	BufferedOutputStream bos = null;
	int codeStart = prg.getCodeStart();
	int codeStartOrg = codeStart;
	int[] header = null;
	int sa=baseAddr+23;
	int ea=sa+228;
	if (withBasicHeader) {
	    if (codeStart >= sa && codeStart < ea) {
		header = new int[codeStart - baseAddr];
		System.arraycopy(HEADER, 0, header, 0, HEADER.length);
		String hss = String.valueOf(codeStart);
		for (int i = 0; i < hss.length(); i++) {
		    char c = hss.charAt(i);
		    int cc = ((int) c - (int) '0') + 0x30;
		    header[i + 5] = cc;
		}
		codeStart = baseAddr;
	    } else {
		throw new RuntimeException("Starting address out of range for a BASIC header: " + prg.getCodeStart()+"/"+baseAddr);
	    }
	}
	try {
	    List<ProgramPart> parts = new ArrayList<>(prg.getParts());
	    Collections.sort(parts);

	    bos = new BufferedOutputStream(os);
	    if (!withBasicHeader) {
		bos.write(parts.get(0).getAddress() % 256);
		bos.write(parts.get(0).getAddress() >> 8);
	    } else {
		bos.write(codeStart % 256);
		bos.write(codeStart >> 8);
	    }
	    if (header != null) {
		for (int b : header) {
		    bos.write(b);
		}
	    }
	    int lastEnd = -1;
	    int cnt = 0;

	    for (ProgramPart part : parts) {
		int start = part.getAddress();
		int[] bin = part.getBytes();

		if (lastEnd != -1) {
		    for (int i = lastEnd; i < start; i++) {
			bos.write(0);
		    }
		}

		Integer end = prg.getLabelsContainer().get("PROGRAMEND");
		if (end != null && end < part.getEndAddress() && end > (cnt == 0 ? codeStartOrg : start)) {
		    int clip = end - (cnt == 0 ? codeStartOrg : start);
		    if (clip < bin.length) {
			bin = Arrays.copyOfRange(bin, 0, clip);
		    }
		} else {
		    end = part.getEndAddress();
		}
		lastEnd = end;
		cnt++;
		for (int b : bin) {
		    bos.write(b);
		}
	    }
	} finally {
	    if (bos != null) {
		bos.close();
	    }
	}

    }
}
