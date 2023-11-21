package com.sixtyfour.cbmnative.shell;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.Pattern;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.javascript.PlatformJs;
import com.sixtyfour.cbmnative.mos6502.AssemblyOptimizer;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.cbmnative.mos6502.util.MemoryHole;
import com.sixtyfour.cbmnative.mos6502.util.SourcePart;
import com.sixtyfour.cbmnative.mos6502.util.SourceProcessor;
import com.sixtyfour.cbmnative.mos6502.vic20.Platform20;
import com.sixtyfour.cbmnative.mos6502.x16.PlatformX16;
import com.sixtyfour.cbmnative.powerscript.PlatformPs;
import com.sixtyfour.compression.Compressor;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.config.RuntimeAddition;
import com.sixtyfour.extensions.x16.X16Extensions;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.parser.RuntimeAddParser;
import com.sixtyfour.parser.cbmnative.UnTokenizer;
import com.sixtyfour.plugins.AssemblerMonitor;
import com.sixtyfour.system.FileWriter;
import com.sixtyfour.system.Program;
import com.sixtyfour.system.ProgramPart;

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
		List<MemoryHole> holes = new ArrayList<>();
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

		CompilerConfig cfg = new CompilerConfig();
		MemoryConfig memConfig = new MemoryConfig();

		memConfig.setProgramStart(getNumber("progstart", cmds));
		memConfig.setBasicBufferStart(getNumber("sysbuffer", cmds));
		memConfig.setRuntimeStart(getNumber("runtimestart", cmds));
		memConfig.setVariableStart(getNumber("varstart", cmds));
		memConfig.setStringEnd(getNumber("varend", cmds));

		if (cfg.isBigRam()) {
			System.out.println("Runtime start configuration ignored, because bigram is true!");
			memConfig.setRuntimeStart(-1);
		}

		if (!memConfig.isValid()) {
			System.out.println("Invalid memory configuration!");
			exit(12);
		}

		boolean addrHeader = getOptionInt("addressheader", cmds);

		cfg.setConstantFolding(getOption("constfolding", cmds));
		cfg.setConstantPropagation(getOption("constprop", cmds));
		cfg.setDeadCodeElimination(getOptionIntDefault("deadcodeopt", cmds, false));
		cfg.setAssignmentOptimizations(getOptionIntDefault("assignmentopt", cmds, false));
		cfg.setPcodeOptimizations("" /* getOption("pcodeopt", cmds) */);
		cfg.setDeadStoreElimination(getOption("deadstoreopt", cmds));
		cfg.setDeadStoreEliminationOfStrings(getOption("deadstoreoptstr", cmds));
		cfg.setIntermediateLanguageOptimizations(getOption("ilangopt", cmds));
		cfg.setNativeLanguageOptimizations(getOption("nlangopt", cmds));
		cfg.setOptimizeConstants(getOption("constopt", cmds));
		cfg.setOptimizedLinker(getOption("smartlinker", cmds));
		cfg.setFloatOptimizations(getOptionIntDefault("floatopt", cmds, false));
		cfg.setPrintSizeOptimization(getOptionIntDefault("printopt", cmds, false));
		cfg.setArrayOptimizations(getOptionIntDefault("arrayopt", cmds, false));
		cfg.setIntOptimizations(getOption("intopt", cmds));
		cfg.setSymbolTable(cmds.get("symboltable"));
		cfg.setAggressiveFloatOptimizations(getOption("xfloatopt", cmds));
		cfg.setNonDecimalNumbersAware(getOptionIntDefault("nondecimals", cmds, false));
		cfg.setConvertStringToLower(getOptionIntDefault("tolower", cmds, false));
		cfg.setFlipCasing(getOptionIntDefault("flipcase", cmds, false));
		cfg.setLoopMode(getOption("loopopt", cmds) ? LoopMode.REMOVE : LoopMode.EXECUTE);
		cfg.setBoostMode(getOptionIntDefault("boost", cmds, false));
		cfg.setBigRam(getOptionIntDefault("bigram", cmds, false));
		cfg.setInlineAssembly(getOptionIntDefault("inlineasm", cmds, false));
		cfg.setZeropageOptimizations(getOptionIntDefault("varopt", cmds, false));

		if (cmds.containsKey("specops")) {
			System.out.println("reading runtime/optimizer information!");
			final RuntimeAddParser addy = new RuntimeAddParser(loadSource(cmds.get("specops")));
			RuntimeAddition rta = new RuntimeAddition() {

				@Override
				public List<Pattern> getAdditionalPatterns() {
					return addy.getPatterns();
				}

				@Override
				public List<String> getAdditionalRuntimeCode() {
					return addy.getCode();
				}

			};
			cfg.setRuntimeAddition(rta);
		}

		boolean compress = getOptionIntDefault("compression", cmds, false);
		boolean multiPart = getOptionIntDefault("multipart", cmds, false);

		holes = parseMemoryHoles(cmds);

		cfg.setProgressListener(new DotPrintingProgressListener());

		if (cmds.containsKey("compactlevel")) {
			try {
				int level = Integer.parseInt(cmds.get("compactlevel"));
				if (level < 3) {
					level = 0;
				}
				cfg.setCompactThreshold(level);
			} catch (Exception e) {
				System.out.println("Invalid compactor level: " + cmds.get("compactlevel"));

			}
		}

		if (cmds.containsKey("threads")) {
			try {
				cfg.setThreads(Integer.parseInt(cmds.get("threads")));
			} catch (Exception e) {
				System.out.println("Invalid thread count: " + cmds.get("threads"));

			}
		}

		boolean genSrc = cmds.containsKey("generatesrc") && Boolean.valueOf(cmds.get("generatesrc"));
		String ilTarget = null;
		String nlTarget = null;
		String ascTarget = null;
		String asmTarget = null;

		PlatformProvider platform = new Platform64();
		String appendix = ".prg";
		boolean multiByteTokens = false;
		if (cmds.containsKey("platform")) {
			String pl = cmds.get("platform");
			if (pl.equalsIgnoreCase("c64")) {
				platform = new Platform64();
				appendix = ".prg";
			} else if (pl.equalsIgnoreCase("js")) {
				platform = new PlatformJs();
				appendix = ".js";
				cfg.setInlineAssembly(false);
			} else if (pl.equalsIgnoreCase("x16")) {
				platform = new PlatformX16();
				Basic.registerExtension(new X16Extensions());
				cfg.setNonDecimalNumbersAware(true);
				cfg.setAggressiveFloatOptimizations(false);
				multiByteTokens = true;
				appendix = ".prg";
			} else if (pl.equalsIgnoreCase("ps")) {
				platform = new PlatformPs();
				appendix = ".ps1";
				cfg.setInlineAssembly(false);
			} else if (pl.equalsIgnoreCase("vic20") || pl.equalsIgnoreCase("vc20")) {
				platform = new Platform20();
				String vicConf = cmds.get("memconfig");
				if (vicConf != null) {
					if (vicConf.equals("0")) {
						((Platform20) platform).setNewBaseAddress(4097);
						((Platform20) platform).setBasicMemoryEndAddress(7679);
					} else if (vicConf.equals("3")) {
						((Platform20) platform).setNewBaseAddress(1025);
						((Platform20) platform).setBasicMemoryEndAddress(7679);
					}
				}
				appendix = ".prg";
			} else {
				System.out.println("Target platform " + cmds.get("platform") + " not supported!");
				exit(4);
			}
		}

		if (platform.supportsBigRam()) {
			if (cfg.isBigRam()) {
				if (memConfig.getStringEnd() == -1) {
					memConfig.setStringEnd(53247);
				}
				System.out.println(
						"BigRam option enabled, highest memory address available is " + memConfig.getStringEnd());
			}
		} else {
			cfg.setBigRam(false);
		}

		if (!platform.supportsCompression() && compress) {
			System.out.println("WARNING: This target platform doesn't support compression!");
			compress = false;
		}

		if (compress && multiPart) {
			System.out.println("WARNING: Compression isn't supported if the multipart option is enabled!");
			compress = false;
		}

		String targetFile = "++" + new File(srcFile).getName().replace(".BAS", "").replace(".bas", "")
				.replace(".prg", "").replace(".PRG", "") + appendix;
		if (cmds.containsKey("target")) {
			targetFile = cmds.get("target");
			if ((appendix.equalsIgnoreCase(".js") && !targetFile.endsWith(".js"))
					|| (appendix.equalsIgnoreCase(".ps1") && !targetFile.endsWith(".ps1"))) {
				targetFile = targetFile + appendix;
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
			ascTarget = targetFile + ".asc";
			asmTarget = targetFile + ".dbg";
			ok = delete(ilTarget) && delete(nlTarget) && delete(ascTarget);
			if (!ok) {
				System.out.println(
						"Can't delete generated source file: " + ilTarget + " / " + nlTarget + "/" + ascTarget);
				exit(5);
			}
		}

		System.out.println("Compiling " + srcFile + "...");
		String[] src = null;

		if (srcFile.toLowerCase(Locale.ENGLISH).endsWith(".prg")) {
			try {
				System.out.println("Looks like a PRG file, trying to convert it...");
				byte[] data = Loader.loadBlob(srcFile);
				UnTokenizer unto = new UnTokenizer();
				List<String> srcList = unto.getText(data, multiByteTokens);
				src = srcList.toArray(new String[0]);
				System.out.println("PRG file converted into ASCII, proceeding!");
				if (genSrc) {
					write(srcList, ascTarget);
				}
				srcFile = srcFile.replace(".prg", ".bas");
			} catch (Exception e) {
				System.out.println("Failed to convert PRG file: " + e.getClass() + "/" + e.getMessage());
				System.out.println("Proceeding as if it was ASCII instead!");
			}
		}

		if (src == null) {
			src = loadSource(srcFile);
		}

		if (src == null || src.length == 0) {
			System.out.println("\nSource file is empty!");
			exit(45);
		}

		for (String line : src) {
			if (!line.trim().isEmpty()) {
				char c = line.charAt(0);
				if (!Character.isDigit(c)) {
					System.out.println("Code seems to use labels, not lines...converting it!");
					src = Preprocessor.convertToLineNumbers(src);
					if (genSrc) {
						write(Arrays.asList(src), ascTarget);
					}
				}
				break;
			}
		}

		src = Preprocessor.convertSpecialChars(src);

		Basic basic = new Basic(src);
		try {
			System.out.println("Checking source file...");
			basic.compile(cfg);
		} catch (Exception e) {
			System.out.println("\n!!! Error compiling BASIC program: " + e.getMessage());
			printCause(e);
			exit(10);
		}
		List<String> nCode = null;

		NativeCompiler nComp = NativeCompiler.getCompiler();
		try {
			if (genSrc) {
				List<String> mCode = NativeCompiler.getCompiler().compileToPseudoCode(cfg, basic);
				write(mCode, ilTarget);
			}

			// basic = new Basic(src);
			nCode = nComp.compile(cfg, basic, memConfig, platform);
		} catch (Exception e) {
			// e.printStackTrace();
			System.out.println("\n!!! Error compiling: " + e.getMessage());
			String ll = nComp.getLastProcessedLine();
			if (ll != null) {
				System.out.println("Error at: " + ll);
			}
			printCause(e);
			exit(15);
		}

		if (is6502Platform(platform) && !holes.isEmpty()) {
			SourceProcessor srcProc = new SourceProcessor(nCode);
			List<SourcePart> parts = srcProc.split();
			nCode = srcProc.relocate(cfg, parts, holes);
		}

		// Relocated into the actual compile step to be executed before the compact run
		/*
		 * if (cfg.isBigRam()) { SourceProcessor srcProc = new SourceProcessor(nCode);
		 * nCode = srcProc.moveRuntime(); }
		 */

		if (cfg.isZeropageOptimizations() && platform.supportsVarRelocation()) {
			nCode = new AssemblyOptimizer().moveVariables(nCode);
		}
		
		if (genSrc) {
			write(nCode, nlTarget);
		}

		Assembler assy = null;
		if (is6502Platform(platform)) {
			PrintWriter pwa = null;
			try {
				assy = new Assembler(nCode);
				if (genSrc) {
					pwa = new PrintWriter(asmTarget);
					final PrintWriter pwd = pwa;
					assy.setMonitor(new AssemblerMonitor() {
						@Override
						public void doneWithLine(int addr, int lineNumber, String line) {
							if (!line.isEmpty()) {
								pwd.println(lineNumber + "\t.$" + Integer.toHexString(addr) + "\t" + line);
							}
						}

					});
				}
				assy.compile(cfg);
			} catch (Exception e) {
				System.out.println("\n!!! Error running assembler: " + e.getMessage());
				printCause(e);
				exit(15);
			} finally {
				if (pwa != null) {
					pwa.close();
				}
			}
		}
		writeTargetFiles(memConfig, targetFile, nCode, assy, platform, addrHeader, multiPart, compress);
		System.out.println(srcFile + " compiled in " + (System.currentTimeMillis() - s) + "ms!");

		if (cmds.containsKey("vice")) {
			runVice(cmds, targetFile);
		}

		exit(0);
	}

	private static List<MemoryHole> parseMemoryHoles(Map<String, String> cmds) {
		List<MemoryHole> holes = new ArrayList<>();
		String holeTxt = cmds.get("memhole");
		if (holeTxt == null || holeTxt.isEmpty()) {
			return holes;
		}
		String[] parts = holeTxt.split(",");
		for (String part : parts) {
			String[] subs = part.split("-");
			if (subs.length == 2) {
				String start = subs[0].trim();
				String end = subs[1].trim();
				int si = 0, ei = 0;
				try {
					si = getNumber(start);
					ei = getNumber(end);
				} catch (NumberFormatException nfe) {
					System.out.println("Invalid number: " + holeTxt);
					exit(37);
				}
				if (si != ei && si > 0 && ei > 0) {
					holes.add(new MemoryHole(si, ei));
				}
			} else {
				System.out.println("Parse error: " + holeTxt);
				exit(38);
			}
		}
		return holes;
	}

	private static void printCause(Exception e) {
		if (e.getCause() != null && e.getCause().getMessage() != null) {
			System.out.println("Caused by: " + e.getCause().getMessage());
		}
	}

	private static void writeTargetFiles(MemoryConfig memConfig, String targetFile, List<String> ncode, Assembler assy,
			PlatformProvider platform, boolean addrHeader, boolean multiPart, boolean compress) {
		if (is6502Platform(platform)) {
			write6502(memConfig, targetFile, assy, platform, addrHeader, multiPart, compress);
			// Check out of memory on write time
			int se = memConfig.getStringEnd();
			if (se <= 0) {
				se = platform.getBasicMemoryEndAddress();
			}
			if (se >= 0) {
				ProgramPart part0 = assy.getProgram().getParts().get(0);
				if (part0.getAddress() <= se && part0.getEndAddress() > se) {
					System.out.println("\nWARNING: Compiled program's length exceeds memory limit: "
							+ (part0.getEndAddress() + ">" + se));
				}
			}
		} else if (platform instanceof PlatformJs) {
			writeJavascript(targetFile, ncode);
		} else if (platform instanceof PlatformPs) {
			writePowershell(targetFile, ncode);
		} else {
			System.out.println("\n!!! Unsupported platform: " + platform);
			exit(19);
		}
	}

	private static void writePowershell(String targetFile, List<String> ncode) {
		try (PrintWriter pw = new PrintWriter(targetFile)) {
			System.out.println("Writing target file: " + targetFile);
			for (String line : ncode) {
				pw.println(line);
			}
		} catch (Exception e) {
			System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
			exit(9);
		}
	}

	private static void writeJavascript(String targetFile, List<String> ncode) {
		Transformer trsn = new PlatformJs().getTransformer();
		try (PrintWriter pw = new PrintWriter(targetFile);
				PrintWriter cpw = new PrintWriter(targetFile.replace(".js", ".html"))) {
			System.out.println("Writing target files: " + targetFile);
			for (String line : ncode) {
				pw.println(line);
			}
			String[] parts = targetFile.replace("\\", "/").split("/");
			for (String line : trsn.createCaller(parts[parts.length - 1])) {
				cpw.println(line);
			}
		} catch (Exception e) {
			System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
			exit(9);
		}
	}

	private static void write6502(MemoryConfig memConfig, String targetFile, Assembler assy, PlatformProvider platform,
			boolean addrHeader, boolean multiPart, boolean compress) {
		try {
			if (!multiPart) {
				System.out.println("Writing target file: " + targetFile);
				boolean basicHeader = memConfig.getProgramStart() == -1
						|| (memConfig.getProgramStart() < platform.getMaxHeaderAddress()
								&& memConfig.getProgramStart() >= platform.getBaseAddress() + 23);
				FileWriter.writeAsPrg(assy.getProgram(), targetFile, basicHeader, platform.getBaseAddress(),
						addrHeader);
				if (compress) {
					byte[] bytes = Compressor.loadProgram(targetFile);
					Program compressed = Compressor.compressAndLinkNative(bytes,
							basicHeader ? -1 : memConfig.getProgramStart());
					if (compressed != null) {
						String resultFile = targetFile.replace(".prg", "-c.prg");
						System.out.println("Writing compressed target file: " + resultFile);
						FileWriter.writeAsPrg(compressed, resultFile, false);
					} else {
						System.out.println(
								"Unable to compress the program any further, no compressed version has been created!");
					}
				}
			} else {
				System.out.println("Writing multiple target files!");
				Program tmp = new Program();
				Program sp = assy.getProgram();
				tmp.setLabelsContainer(sp.getLabelsContainer());
				tmp.addPart(sp.getParts().get(0));
				tmp.setCodeStart(sp.getCodeStart());
				System.out.println("Writing target file: " + targetFile);
				FileWriter.writeAsPrg(tmp, targetFile,
						memConfig.getProgramStart() == -1
								|| (memConfig.getProgramStart() < platform.getMaxHeaderAddress()
										&& memConfig.getProgramStart() >= platform.getBaseAddress() + 23),
						platform.getBaseAddress(), addrHeader);
				String master = targetFile.replace(".prg", ".p0");
				for (int i = 1; i < sp.getParts().size(); i++) {
					tmp = new Program();
					ProgramPart pp = sp.getParts().get(i);
					tmp.addPart(pp);
					tmp.setCodeStart(pp.getAddress());
					tmp.setLabelsContainer(sp.getLabelsContainer());
					String newName = master + i;
					delete(newName);
					System.out.println("Writing target file: " + newName);
					FileWriter.writeAsPrg(tmp, newName, false, platform.getBaseAddress(), true);
				}
			}
		} catch (Exception e) {
			System.out.println("Failed to write target file '" + targetFile + "': " + e.getMessage());
			exit(9);
		}
	}

	private static boolean is6502Platform(PlatformProvider platform) {
		return platform instanceof Platform64 || platform instanceof Platform20 || platform instanceof PlatformX16;
	}

	private static void runVice(Map<String, String> cmds, String targetFile) {
		try {
			Process prc = Runtime.getRuntime()
					.exec(cmds.get("vice") + " \"" + new File(targetFile).getAbsolutePath() + "\"");
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
			System.out.println("Failed to load source file (" + srcFile + "): " + e.getMessage());
			exit(6);
		}
		List<String> res = new ArrayList<>();
		for (String line : src) {
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
		return getOptionInt(option, options);
	}

	private static boolean getOptionInt(String option, Map<String, String> options) {
		return getOptionIntDefault(option, options, true);
	}

	private static boolean getOptionIntDefault(String option, Map<String, String> options, boolean def) {
		option = option.toLowerCase(Locale.ENGLISH);
		if (options.containsKey(option)) {
			return Boolean.valueOf(options.get(option));
		}
		return def;
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
		System.out.println("Basic usage: mospeed" + appx + " <source file>");
		System.out.println(
				"\nThis will compile the specified source file for the C64 with all optimizations enabled and using the default memory configuration.");
		System.out.println("The target file name is the source file name with a '++'-prefix.");
		System.out.println("An existing file of the same name will be overwritten.\n\n");
		System.out.println("Optional parameters (either with / or - as prefix):\n");
		System.out.println("/target=<target file> -  the target file name");
		System.out.println(
				"/platform=xxxx - the target platform. Options are c64 (for c64 compatible machine code), vic20 or vc20, x16 (for the Commander (NOT Commodore) X16), js (for Javascript) and ps (for Powershell/-script), default is c64");
		System.out.println(
				"/generatesrc=true|false -  writes the generated intermediate and assembly language programs to disk as well");
		System.out.println("/constprop=true|false - enables/disables constant propagation optimizations");
		System.out.println("/constfolding=true|false - enables/disables constant folding optimizations");
		System.out.println("/constopt=true|false - enables/disables constant pool optimizations");
		System.out.println("/ilangopt=true|false - enables/disables intermediate language optimizations");
		System.out.println("/nlangopt=true|false - enables/disables native language optimizations");
		System.out.println("/smartlinker=true|false - enables/disables linker optimizations for size");
		System.out.println("/deadstoreopt=true|false - enables/disables dead store elimination for numbers");
		System.out.println("/deadstoreoptstr=true|false - enables/disables dead store elimination for strings");
		System.out.println("/deadcodeopt=true|false - enables/disables dead code elimination. Default is false.");
		System.out.println("/loopopt=true|false - enables/disables the removal of empty loops");
		System.out.println("/addressheader=true|false - enables/disables the writing of the two address header bytes");
		System.out.println(
				"/floatopt=true|false - enables/disables some additional floating point optimizations, which might impact accuracy. Default is false.");
		System.out.println(
				"/xfloatopt=true|false - enables/disables additional floating point optimizations. While they speed up some operations by up to 25%, they need more memory.");
		System.out.println("/intopt=true|false - enables/disables some integer optimizations");
		System.out.println(
				"/compactlevel=[3...] - sets the compactor level. The lower the level, the more compact (but slower) the code. 0 means off!");
		System.out.println(
				"/progstart=xxxxx|$yyyy - sets the start address for the compiled program. If close to the machine's BASIC start address, a BASIC header will be added automatically.");
		System.out.println(
				"/varstart=xxxxx|$yyyy - the start address for variables. If none is given, they will be located right after the runtime code.");
		System.out.println(
				"/varend=xxxxx|$yyyy - the end address of the variable memory, i.e. in fact the end of the string memory.");
		System.out.println(
				"/runtimestart=xxxxx|$yyyy - the start address of the runtime's code. If none is given, it follows the program's code. This setting will be ignored when using the bigram option.");
		System.out.println(
				"/sysbuffer=xxxxx|$yyyy - the start address of the buffer used to execute SYS commands with parameters. Default is 820 for the CBM machines and 1024 for the X16. If set to 0, the runtime will reserve its own buffer in BASIC memory.");
		System.out.println("/alloff=true|false - if specified, all optimizations will be turned off");
		System.out.println(
				"/vice=<path> - sets a path to the VICE executable. If specified, the compiled prg file will be started in VICE right away.");
		System.out.println(
				"/memconfig=0|3|8 - the memory configuration in case of VIC20 as the target machine. 0 means 'unexpanded', 3 means with a 3k expansion, 8 means with an 8k or larger expansion. Default is 8.");
		System.out.println(
				"/symboltable=<file> - this only applies to the X16 target platform. It lets you specify a different symbol table to compile for different ROM releases. The default symbol table should match the latest ROM release.");
		System.out.println(
				"/tolower=true|false - if true, all strings in the source code will be treated as lower case. This can be useful when compiling BASIC code copied directly from an emulator. Default is false.");
		System.out.println(
				"/flipcase=true|false - if true, the casing of strings in the source code will be reversed. This can be useful when compiling BASIC code copied directly from an emulator. Default is false.");
		System.out.println(
				"/nondecimals=true|false - if true, hexadecimal and binary numbers can be indicated by & and %. Default is false, except for the X16 platform, where it's enabled by default.");
		System.out.println(
				"/multipart=true|false - if false (default) the target file contains all binary data regardless of the address in memory. If true, several files will be written if the addresses of the program's parts aren't adjacent.");
		System.out.println(
				"/memhole=<start1-end1>,<start2-end2>,... - Defines holes/locked regions in memory. The compiled program won't use these memory locations for compiled code and variables. If a hole is located after the end of the compiled program, it will be ignored. Default is none.");
		System.out.println(
				"/boost=true|false - If true, a compiled C64 program will use the C128's 2 Mhz mode to increase performance up to 25%. This only works on the C128 in C64 mode, it has no effect when run on a real C64. It might also not be compatible with all programs. Default is false.");
		System.out.println(
				"/bigram=true|false - *Experimental* - If true, the RAM under the C64's BASIC ROM as well as the higher 4K of RAM will be used for the compiled program as well. This will reduce performance, especially when accessing memory under the ROM. Default is false.");
		System.out.println(
				"/compression=true|false - *Experimental* - If true, the compiled program will be compressed to achieve a smaller file size. The compressed file will be saved in addition to the normal binary. Compression isn't always possible. In that case, no compressed file will be written.");
		System.out.println(
				"/inlineasm=true|false - *Experimental* - If true, inline assembly code can be used, marked by REM [...;...;...]. Default is false.");
		System.out.println(
				"/printopt=true|false - *Experimental* - If true, the compiler tries to rearrange texts in PRINT statements to save memory at the expense of speed. Default is false.");
		System.out.println(
				"/arrayopt=true|false - *Experimental* - If true, the compiler tries to optimize access speed of multi-dimensional arrays at the expense of memory usage. Default is false.");
		System.out.println(
				"/assignmentopt=true|false - *Experimental* - If true, the compiler tries to optimize assignments. Default is false.");
		System.out.println(
				"/varopt=true|false - *Experimental* - If true, the compiler tries to move integer variables into the zeropage if possible and applicable. Default is false.");

		
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
