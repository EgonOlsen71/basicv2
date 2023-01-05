package com.sixtyfour.cbmnative.shell;

import java.io.File;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.Assembler;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.FileWriter;

/**
 * Comnmand line version of the assembler
 * 
 * @author EgonOlsen
 *
 */
public class AssemblerCL {

	public static void main(String[] args) {
		long s = System.currentTimeMillis();
		System.out.println("***** MOSM - a simple 6502 cross assembler *****");
		System.out.println("(w) by EgonOlsen - https://github.com/EgonOlsen71");
		System.out.println("-------------------------------------------------");
		Map<String, String> cmds = new HashMap<>();
		String srcFile = null;
		for (String arg : args) {
			if ((arg.startsWith("/") || arg.startsWith("-")) && !(new File(arg).isFile())) {
				arg = arg.substring(1);
				String[] parts = arg.split("=");
				cmds.put(parts[0].toLowerCase(Locale.ENGLISH), parts.length > 1 ? parts[1] : null);
			} else {
				if (srcFile == null) {
					srcFile = arg;
				}
			}
		}

		if (cmds.containsKey("?")) {
			printOutHelp();
			exit(1);
		}
		System.out.println("type /? for more information\n\n");

		if (srcFile == null) {
			System.out.println("No input file specified - aborting!");
			exit(1);
		}

		CompilerConfig config = new CompilerConfig();
		System.out.println("Assembling " + srcFile + "...");
		String[] code = Loader.loadProgram(srcFile);
		Assembler asm = new Assembler(code);
		asm.compile(config);

		String targetFile = new File(srcFile).getName().replace(".asm", "");
		if (cmds.containsKey("target")) {
			targetFile = cmds.get("target");
		}

		if (getOption("datas", cmds)) {
			targetFile += ".bas";
			try {
				System.out.println("Writing target file (ASCII): " + targetFile);
				FileWriter.writeAsDatas(asm.getProgram(), targetFile, 30000);
			} catch (Exception e) {
				System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
				exit(9);
			}
		} else {
			targetFile += ".prg";
			try {
				System.out.println("Writing target file (binary): " + targetFile);
				FileWriter.writeAsPrg(asm.getProgram(), targetFile, false, asm.getProgram().getCodeStart(),
						!getOption("noheader", cmds));
			} catch (Exception e) {
				System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
				exit(9);
			}
		}

		System.out.println(srcFile + " assembled in " + (System.currentTimeMillis() - s) + "ms!");
		exit(0);
	}

	private static boolean getOption(String option, Map<String, String> options) {
		option = option.toLowerCase(Locale.ENGLISH);
		if (options.containsKey(option)) {
			return Boolean.valueOf(options.get(option));
		}
		return false;
	}

	private static void exit(int i) {
		System.out.println("\nREADY.");
		System.exit(i);
	}

	private static void printOutHelp() {
		System.out.println("\n");
		String appx = ".sh";
		if (System.getProperty("os.name").toLowerCase().contains("windows")) {
			appx = ".cmd";
		}
		System.out.println("Usage: mosm" + appx + " <source file>");
		System.out.println(
				"\nThis will assemble the specified source file for the 6502 and write it as a .prg file suitable for the Commodore line of 8bit micros.");
		System.out.println("The target file name is the source file name with a '.prg'-postfix.");
		System.out.println("An existing file of the same name will be overwritten.\n\n");
		System.out.println("Optional parameters (either with / or - as prefix):\n");
		System.out.println("/target=<target file> -  the target file name");
		System.out.println(
				"/datas=true|false -  write the assembled program as a set of data statements in ASCII form instead of a binary. Default is false.");
		System.out.println(
				"/noheader=true|false -  if true, the address header won't be written into the generated file. Default is false.");
		System.out.println();
	}

}
