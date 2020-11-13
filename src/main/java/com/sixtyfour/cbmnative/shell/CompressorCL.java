package com.sixtyfour.cbmnative.shell;

import java.io.File;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.compression.Compressor;
import com.sixtyfour.system.FileWriter;
import com.sixtyfour.system.Program;

/**
 * Comnmand line version of the cruncher
 * 
 * @author EgonOlsen
 *
 */
public class CompressorCL {

	public static void main(String[] args) throws Exception {
		long s = System.currentTimeMillis();
		System.out.println("***** MOScrunch - a cross compressor *****");
		System.out.println("(w) by EgonOlsen - https://github.com/EgonOlsen71");
		System.out.println("-------------------------------------------------");
		Map<String, String> cmds = new HashMap<>();
		String srcFile = null;
		for (String arg : args) {
			if (arg.startsWith("/") || arg.startsWith("-")) {
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

		byte[] data = Compressor.loadProgram(srcFile);

		String targetFile = new File(srcFile).getName();
		if (targetFile.contains(".")) {
			int pos = targetFile.lastIndexOf(".");
			targetFile = targetFile.substring(0, pos) + "-c" + targetFile.substring(pos);
		}

		if (cmds.containsKey("target")) {
			targetFile = cmds.get("target");
		}

		int startAddr = getNumber("startaddress", cmds);

		Program compressed = Compressor.compressAndLinkNative(data, startAddr);

		if (compressed != null) {
			System.out.println("Writing compressed target file: " + targetFile);
			FileWriter.writeAsPrg(compressed, targetFile, false);
		} else {
			System.out.println("Unable to compress the program any further, no compressed version has been created!");
		}

		System.out.println(srcFile + " compressed in " + (System.currentTimeMillis() - s) + "ms!");
		exit(0);
	}

	private static void exit(int i) {
		System.out.println("\nREADY.");
		System.exit(i);
	}

	private static int getNumber(String option, Map<String, String> options) {
		option = option.toLowerCase(Locale.ENGLISH);
		try {
			if (options.containsKey(option)) {
				String nums = options.get(option);
				return getNumber(nums);
			}
		} catch (Exception e) {
			System.out.println("Invalid number: " + options.get(option));
			exit(11);
		}
		return -1;
	}

	private static int getNumber(String nums) {
		if (nums.startsWith("$")) {
			nums = nums.substring(1);
			return Integer.parseInt(nums, 16);
		}
		return Integer.parseInt(nums);
	}

	private static void printOutHelp() {
		System.out.println("\n");
		String appx = ".sh";
		if (System.getProperty("os.name").toLowerCase().contains("windows")) {
			appx = ".cmd";
		}
		System.out.println("Usage: moscrunch" + appx + " <source file>");
		System.out.println("\nThis will compress the specified source file, if possible.");
		System.out.println("The target file name is the source file name with a '-c'-infix.");
		System.out.println("An existing file of the same name will be overwritten.\n\n");
		System.out.println("Optional parameters (either with / or - as prefix):\n");
		System.out.println("/target=<target file> -  the target file name");
		System.out.println(
				"/startaddress=xxxxx|$yyyy -  start address of the program, if no basic header is present. If none is given, RUN will be executed instead. This is also the default.");
		System.out.println();
	}

}
