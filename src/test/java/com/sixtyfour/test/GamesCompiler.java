package com.sixtyfour.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.system.CompilerConfig;
import com.sixtyfour.system.FileWriter;

/**
 * @author EgonOlsen
 * 
 */
public class GamesCompiler {

	public static void main(String[] args) throws Exception {
		File src = new File("src/test/resources/games");
		File dst = new File("compiled");
		dst.mkdir();
		File[] games = src.listFiles(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				return name.endsWith("Turkey.bas");
			}
		});

		for (File game : games) {
			System.out.println("Compiling " + game);
			String[] vary = Loader.loadProgram(new FileInputStream(game));
			Assembler assy = initTestEnvironment(vary, false, 49152);
			String target = dst.getPath() + "/+" + game.getName().replace(".bas", ".prg");
			FileWriter.writeAsPrg(assy.getProgram(), target, true);
		}
	}

	private static Assembler initTestEnvironment(String[] vary, boolean executePseudo, int variableStart) {
		CompilerConfig conf = CompilerConfig.getConfig();
		boolean optis=true;
		conf.setConstantFolding(optis);
		conf.setConstantPropagation(optis);
		conf.setDeadStoreElimination(optis);
		conf.setDeadStoreEliminationOfStrings(optis);
		conf.setIntermediateLanguageOptimizations(optis);
		conf.setNativeLanguageOptimizations(optis);
		conf.setOptimizedLinker(optis);
		//conf.setCompactThreshold(4);

		final Basic basic = new Basic(vary);
		basic.compile();

		List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(basic);
		System.out.println("------------------------------");
		for (String line : mCode) {
			System.out.println(line);
		}
		System.out.println("------------------------------");

		if (executePseudo) {
			System.out.println("Running pseudo code...");
			PseudoCpu pc = new PseudoCpu();
			pc.execute(basic.getMachine(), mCode);
		}
		System.out.println("------------------------------");

		List<String> nCode = NativeCompiler.getCompiler().compile(basic, variableStart);
		for (String line : nCode) {
			System.out.println(line);
		}

		final Assembler assy = new Assembler(nCode);
		assy.compile();

		return assy;
	}
}
