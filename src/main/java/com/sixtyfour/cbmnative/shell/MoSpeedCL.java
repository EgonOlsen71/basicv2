package com.sixtyfour.cbmnative.shell;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.javascript.PlatformJs;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.cbmnative.mos6502.vic20.Platform20;
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
		System.out.println("*** MOSpeed - a Commodore BASIC V2 cross compiler");
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
		cfg.setPcodeOptimizations(false /*getOption("pcodeopt", cmds)*/);
		cfg.setDeadStoreElimination(getOption("deadstoreopt", cmds));
		cfg.setDeadStoreEliminationOfStrings(getOption("deadstoreoptstr", cmds));
		cfg.setIntermediateLanguageOptimizations(getOption("ilangopt", cmds));
		cfg.setNativeLanguageOptimizations(getOption("nlangopt", cmds));
		cfg.setOptimizeConstants(getOption("constopt", cmds));
		cfg.setOptimizedLinker(getOption("smartlinker", cmds));
		cfg.setFloatOptimizations(getOption("floatopt", cmds));
		cfg.setIntOptimizations(getOption("intopt", cmds));
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

		PlatformProvider platform = new Platform64();
		String appendix=".prg";
		if (cmds.containsKey("platform")) {
		    String pl=cmds.get("platform");
		    if (pl.equalsIgnoreCase("c64")) {
			platform = new Platform64();
			appendix=".prg";
		    } else if (pl.equalsIgnoreCase("js")) {
			platform = new PlatformJs();
			appendix=".js";
		    } else if (pl.equalsIgnoreCase("vic20") || pl.equalsIgnoreCase("vc20")) {
			platform = new Platform20();
			appendix=".prg";
		    } else {
			System.out.println("Target platform " + cmds.get("platform") + " not supported!");
			exit(4);
		    }
		}
		
		String targetFile = "++" + new File(srcFile).getName().replace(".bas", "") + appendix;
		if (cmds.containsKey("target")) {
			targetFile = cmds.get("target");
			if (appendix.equalsIgnoreCase(".js") && !targetFile.endsWith(".js")) {
			    targetFile=targetFile+appendix;
			}
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

		Assembler assy=null;
		if (platform instanceof Platform64 || platform instanceof Platform20) {
        		assy = new Assembler(nCode);
        		assy.compile(cfg);
		}
		writeTargetFiles(memConfig, targetFile, nCode, assy, platform);
		System.out.println(srcFile + " compiled in " + (System.currentTimeMillis() - s) + "ms!");

		if (cmds.containsKey("vice")) {
			runVice(cmds, targetFile);
		}

		exit(0);
	}

	private static void writeTargetFiles(MemoryConfig memConfig, String targetFile, List<String> ncode, Assembler assy, PlatformProvider platform) {
	    if (platform instanceof Platform64 || platform instanceof Platform20) {
        	    try {
        		System.out.println("Writing target file: " + targetFile);
        	    	FileWriter.writeAsPrg(assy.getProgram(), targetFile, memConfig.getProgramStart() == -1 || memConfig.getProgramStart() < platform.getMaxHeaderAddress(), platform.getBaseAddress());
        	    } catch (Exception e) {
        	    	System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
        	    	exit(9);
        	    }
	    } else if (platform instanceof PlatformJs) {
		Transformer trsn=new PlatformJs().getTransformer();
		try (PrintWriter pw = new PrintWriter(targetFile); PrintWriter cpw=new PrintWriter(targetFile.replace(".js", ".html"))) {
		    System.out.println("Writing target files: " + targetFile);
		    for (String line : ncode) {
			pw.println(line);
		    }
		    String[] parts=targetFile.replace("\\","/").split("/");
		    for (String line:trsn.createCaller(parts[parts.length-1])) {
			cpw.println(line);
		    }
		} catch (Exception e) {
		    System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
    	    	exit(9);
		}
	    } else {
		System.out.println("\n!!! Unsupported platform: " + platform);
		exit(19);
	    }
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
		List<String> res=new ArrayList<>();
		for (String line:src) {
		    if (!line.trim().startsWith("!")) {
			res.add(line);
		    }
		}
		return res.toArray(new String[res.size()]);
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
		System.out.println("/platform=xxxx - the target platform. Options are c64 (for c64 compatible machine code), vic20 or vc20 and js (for Javascript), default is c64");
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
		System.out.println("/floatopt=true|false - enables/disables some floating point optimizations, which might impact accuracy");
		System.out.println("/intopt=true|false - enables/disables some integer optimizations");
		System.out.println("/compactlevel=[3...] - sets the compactor level. The lower the level, the more compact (but slower) the code. 0 means off!");
		System.out.println("/progstart=xxxxx|$yyyy - sets the start address for the compiled program. If close to the machine's BASIC start address, a BASIC header will be added automatically.");
		System.out.println("/varstart=xxxxx|$yyyy - the start address for variables. If none is given, they will be located right after the runtime code.");
		System.out.println("/varend=xxxxx|$yyyy - the end address of the variable memory, i.e. in fact of the string memory.");
		System.out.println("/runtimestart=xxxxx|$yyyy - the start address of the runtime's code. If none is given, it follows the program's code.");
		System.out.println("/alloff=true|false - if specified, all optimizations will be turned off");
		System.out.println("/vice=<path> - sets a path to the VICE executable. If specified, the compiled prg file will be started in VICE right away.");
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
