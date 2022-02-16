package com.sixtyfour.example;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.cbmnative.mos6502.util.MemoryHole;
import com.sixtyfour.cbmnative.mos6502.util.SourcePart;
import com.sixtyfour.cbmnative.mos6502.util.SourceProcessor;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.parser.cbmnative.UnTokenizer;
import com.sixtyfour.system.FileWriter;
import com.sixtyfour.system.Program;

/**
 * The simplest way to compile something for the C64. Mainly meant as an example
 * of how to use the compiler in your own Java code.
 * 
 * This is as simple as it gets without any fancy configuration options being
 * used.
 * 
 * @author EgonOlsen
 *
 */
public class SimpleCompiler {

	public static void main(String[] args) throws Exception {
		Program compiled = new SimpleCompiler().compile("src/test/resources/prg/test.prg");

		// Write result
		FileWriter.writeAsPrg(compiled, new FileOutputStream("++test.prg"), true);
	}

	public Program compile(String file) throws Exception {

		// Init configs and target platform
		CompilerConfig cfg = new CompilerConfig();
		MemoryConfig memConfig = new MemoryConfig();
		PlatformProvider platform = new Platform64();
		List<MemoryHole> memHoles = new ArrayList<>();

		// Load prg
		byte[] binary = Loader.loadBlob(new FileInputStream(file));

		// Convert PRG into ASCII
		UnTokenizer unto = new UnTokenizer();
		List<String> srcList = unto.getText(binary, false);
		String[] src = srcList.toArray(new String[0]);
		if (src == null || src.length == 0) {
			handleError("File is empty!");
			return null;
		}
		src = Preprocessor.convertSpecialChars(src);

		// Compile into AST
		Basic basic = new Basic(src);
		try {
			basic.compile(cfg);
		} catch (Exception e) {
			handleError(e.getMessage());
			return null;
		}

		// Compile into native code
		List<String> nCode = null;
		NativeCompiler nComp = NativeCompiler.getCompiler();
		try {
			nCode = nComp.compile(cfg, basic, memConfig, platform);
		} catch (Exception e) {
			String ll = nComp.getLastProcessedLine();
			handleError(e.getMessage() + (ll != null ? ("-" + ll) : ""));
			return null;
		}

		// Restructure assembly code if needed
		if (!memHoles.isEmpty()) {
			SourceProcessor srcProc = new SourceProcessor(nCode);
			List<SourcePart> parts = srcProc.split();
			nCode = srcProc.relocate(cfg, parts, memHoles);
		}

		if (cfg.isBigRam()) {
			SourceProcessor srcProc = new SourceProcessor(nCode);
			nCode = srcProc.moveRuntime();
		}

		// Assemble compiled program
		Assembler assy = null;
		assy = new Assembler(nCode);
		try {
			assy.compile(cfg);
		} catch (Exception e) {
			handleError(e.getMessage());
			return null;
		}

		return assy.getProgram();
	}

	private void handleError(String msg) {
		// Do some clever error handling here...
		System.out.println("Error: " + msg);
	}

}
