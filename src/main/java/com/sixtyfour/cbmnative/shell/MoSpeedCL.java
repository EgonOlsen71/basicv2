package com.sixtyfour.cbmnative.shell;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.system.FileWriter;

/**
 * Command line version of the native compiler
 * 
 * @author EgonOlsen
 * 
 */
public class MoSpeedCL {

	public static void main(String[] args) {
		long s = System.currentTimeMillis();
		System.out.println("*** MoSpeed - a Commodore BASIC V2 cross compiler");
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

		CompilerConfig cfg = new CompilerConfig();
		MemoryConfig memConfig = new MemoryConfig();

		memConfig.setProgramStart(getNumber("progstart", cmds));
		memConfig.setRuntimeStart(getNumber("runtimestart", cmds));
		memConfig.setVariableStart(getNumber("varstart", cmds));
		memConfig.setStringEnd(getNumber("varend", cmds));

		if (!memConfig.isValid()) {
			System.out.println("Invalid memory configuration!");
			exit(12);
		}

		cfg.setConstantFolding(getOption("constfolding", cmds));
		cfg.setConstantPropagation(getOption("constprop", cmds));
		cfg.setDeadStoreElimination(getOption("deadstoreopt", cmds));
		cfg.setDeadStoreEliminationOfStrings(getOption("deadstoreoptstr", cmds));
		cfg.setIntermediateLanguageOptimizations(getOption("ilangopt", cmds));
		cfg.setNativeLanguageOptimizations(getOption("nlangopt", cmds));
		cfg.setOptimizeConstants(getOption("constopt", cmds));
		cfg.setOptimizedLinker(getOption("smartlinker", cmds));
		cfg.setLoopMode(getOption("loopopt", cmds) ? LoopMode.REMOVE : LoopMode.EXECUTE);

		cfg.setProgressListener(new DotPrintingProgressListener());

		if (cmds.containsKey("compactlevel")) {
			try {
				int level = Integer.parseInt(cmds.get("compactlevel"));
				if (level < 3) {
					level = 0;
				}
				cfg.setCompactThreshold(level);
			} catch (Exception e) {
				System.out.println("Invalid compator level: " + cmds.get("compactlevel"));

			}
		}

		boolean genSrc = cmds.containsKey("generatesrc") && Boolean.valueOf(cmds.get("generatesrc"));
		String ilTarget = null;
		String nlTarget = null;

		String targetFile = "++" + new File(srcFile).getName().replace(".bas", "") + ".prg";
		if (cmds.containsKey("target")) {
			targetFile = cmds.get("target");
		}
		boolean ok = delete(targetFile);
		if (!ok) {
			System.out.println("Can't delete target file: " + targetFile);
			exit(3);
		}

		if (genSrc) {
			ilTarget = targetFile + ".il";
			nlTarget = targetFile + ".nl";
			ok = delete(ilTarget) && delete(nlTarget);
			if (!ok) {
				System.out.println("Can't delete generated source file: " + ilTarget + " / " + nlTarget);
				exit(5);
			}
		}

		PlatformProvider platform = new Platform64();
		if (cmds.containsKey("platform") && !cmds.get("platform").equalsIgnoreCase("c64")) {
			System.out.println("Target platform " + cmds.get("platform") + " not supported!");
			exit(4);
		}

		System.out.println("Compiling " + srcFile + "...");
		String[] src = loadSource(srcFile);
		for (String line : src) {
			if (!line.trim().isEmpty()) {
				char c = line.charAt(0);
				if (!Character.isDigit(c)) {
					System.out.println("Code seems to use labels, not lines...converting it!");
					src = Preprocessor.convertToLineNumbers(src);
				}
				break;
			}
		}

		Basic basic = new Basic(src);
		try {
			basic.compile(cfg);
		} catch (Exception e) {
			System.out.println("\n!!! Error compiling BASIC program: " + e.getMessage());
			exit(10);
		}
		List<String> nCode = null;

		try {
			if (genSrc) {
				List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(cfg, basic);
				write(mCode, ilTarget);
			}

			nCode = NativeCompiler.getCompiler().compile(cfg, basic, memConfig, platform);
		} catch (Exception e) {
			System.out.println("\n!!! Error compiling: " + e.getMessage());
			exit(15);
		}
		if (genSrc) {
			write(nCode, nlTarget);
		}

		Assembler assy = new Assembler(nCode);
		assy.compile(cfg);
		try {
			System.out.println("Writing target file: " + targetFile);
			FileWriter.writeAsPrg(assy.getProgram(), targetFile, memConfig.getProgramStart() == -1 || memConfig.getProgramStart() < 2100);
		} catch (Exception e) {
			System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
			exit(9);
		}
		System.out.println(srcFile + " compiled in " + (System.currentTimeMillis() - s) + "ms!");

		if (cmds.containsKey("vice")) {
			runVice(cmds, targetFile);
		}

		exit(0);
	}

	private static void runVice(Map<String, String> cmds, String targetFile) {
		try {
			Process prc = Runtime.getRuntime().exec(cmds.get("vice") + " \"" + new File(targetFile).getAbsolutePath() + "\"");
			try (InputStream is = prc.getInputStream()) {
				// while (prc.isAlive()) {
				while (is.available() > 0) {
					is.read();
				}
				// }
			}
		} catch (Exception e) {
			System.out.println("Failed to start VICE at " + cmds.get("vice") + ": " + e.getMessage());
			exit(10);
		}
	}

	private static boolean delete(String ilTarget) {
		return !new File(ilTarget).exists() || new File(ilTarget).delete();
	}

	private static void write(List<String> code, String file) {
		System.out.println("Writing file: " + file);
		try (PrintWriter pw = new PrintWriter(file)) {
			for (String line : code) {
				pw.println(line);
			}
		} catch (Exception e) {
			System.out.println("Failed to write file '" + file + "': " + e.getMessage());
			exit(7);
		}
	}

	private static String[] loadSource(String srcFile) {
		String[] src = null;
		System.out.println("Loading source file...");
		try {
			src = Loader.loadProgram(srcFile);
		} catch (Exception e) {
			System.out.println("Failed to load source file: " + e.getMessage());
			exit(6);
		}
		return src;
	}

	private static void exit(int i) {
		System.out.println("\nREADY.");
		System.exit(i);
	}

	private static boolean getOption(String option, Map<String, String> options) {
		if (options.containsKey("alloff")) {
			return false;
		}
		option = option.toLowerCase(Locale.ENGLISH);
		if (options.containsKey(option)) {
			return Boolean.valueOf(options.get(option));
		}
		return true;
	}

	private static int getNumber(String option, Map<String, String> options) {
		option = option.toLowerCase(Locale.ENGLISH);
		try {
			if (options.containsKey(option)) {
				String nums = options.get(option);
				if (nums.startsWith("$")) {
					nums = nums.substring(1);
					return Integer.parseInt(nums, 16);
				}
				return Integer.parseInt(nums);
			}
		} catch (Exception e) {
			System.out.println("Invalid number: " + options.get(option));
			exit(11);
		}
		return -1;
	}

	private static void printOutHelp() {
		System.out.println("\n");
		String appx = ".sh";
		if (System.getProperty("os.name").toLowerCase().contains("windows")) {
			appx = ".cmd";
		}
		System.out.println("Basic usage: mospeed" + appx + " <source file>");
		System.out.println("\nThis will compile the specified source file for the C64 with all optimizations enabled and using the default memory configuration.");
		System.out.println("The target file name is the source file name with a '++'-prefix.");
		System.out.println("An existing file of the same name will be overwritten.\n\n");
		System.out.println("Optional parameters (either with / or - as prefix):\n");
		System.out.println("/target=<target file> -  the target file name");
		System.out.println("/platform=c64 - the target platform, only c64 supported for now");
		System.out.println("/generatesrc=true|false -  writes the generated intermediate and assembly language programs to disk as well");
		System.out.println("/constprop=true|false - enables/disables constant propagation optimizations");
		System.out.println("/constfolding=true|false - enables/disables constant folding optimizations");
		System.out.println("/constopt=true|false - enables/disables constant pool optimizations");
		System.out.println("/ilangopt=true|false - enables/disables intermediate language optimizations");
		System.out.println("/nlangopt=true|false - enables/disables native language optimizations");
		System.out.println("/smartlinker=true|false - enables/disables linker optimizations for size");
		System.out.println("/deadstoreopt=true|false - enables/disables dead store elimination for numbers");
		System.out.println("/deadstoreoptstr=true|false - enables/disables dead store elimination for strings");
		System.out.println("/loopopt=true|false - enables/disables the removal of empty loops");
		System.out.println("/compactlevel=[3...] - sets the compactor level. The lower the level, the more compact (but slower) the code. 0 means off!");
		System.out.println("/progstart=xxxxx|$yyyy - sets the start address for the compiled program. Below 2100, a BASIC header will be added automatically.");
		System.out.println("/varstart=xxxxx|$yyyy - the start address for variables. If none is given, they will be located right after the runtime code.");
		System.out.println("/varend=xxxxx|$yyyy - the end address of the variable memory, i.e. in fact of the string memory.");
		System.out.println("/runtimestart=xxxxx|$yyyy - the start address of the runtime's code. If none is given, it follows the program's code.");
		System.out.println("/alloff - if specified, all optimizations will be turned off");
		System.out.println("/vice - sets a path to the VICE executable. If specified, the compiled prg file will be started in VICE right away.");
		System.out.println();
	}

	private static class DotPrintingProgressListener implements ProgressListener {

		@Override
		public void nextStep() {
			System.out.print("*");
		}

		@Override
		public void start() {
			//
		}

		@Override
		public void done() {
			System.out.println();
		}

	}

}
