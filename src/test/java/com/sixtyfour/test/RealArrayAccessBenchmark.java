package com.sixtyfour.test;

import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.test.helper.JsrProfiler;
import com.sixtyfour.test.helper.ProfilerData;

public class RealArrayAccessBenchmark {

	private static final int READS = 1024;
	private static final int CHECKSUM_OK = 49152;
	public static void main(String[] args) {
		// A real index selects _S with native optimization; a variable integer index selects _INT, not _PRE.
		benchmark(false, false, "ARRAYACCESS_REAL");
		benchmark(true, false, "ARRAYACCESS_REAL_S");
		benchmark(true, true, "ARRAYACCESS_REAL_INT");
	}

	private static void benchmark(boolean nativeOptimization, boolean intOptimization, String expectedRoutine) {
		CompilerConfig config = new CompilerConfig();
		config.setNativeLanguageOptimizations(nativeOptimization);
		config.setIntOptimizations(intOptimization);
		config.setOptimizedLinker(true);
		config.setThreads(1);
		String[] source = {
				"10 DIM A(" + (READS - 1) + ")",
				"20 FOR I=0 TO " + (READS - 1) + ": A(I)=I: NEXT I",
				"30 S=0: FOR I=0 TO " + (READS - 1),
				intOptimization ? "40 J%=I: S=S+A(J%)" : "40 S=S+A(I)",
				"50 NEXT I",
				"60 IF S=" + (READS * (READS - 1) / 2) + " THEN POKE " + CHECKSUM_OK + ",1",
				"70 END"
		};
		List<String> code = NativeCompiler.getCompiler().compile(config, new Basic(source), new MemoryConfig(),
				new Platform64());
		Assembler assembler = new Assembler(code);
		assembler.compile(config);
		assembler.getMachine().addRoms();
		JsrProfiler profiler = new JsrProfiler(assembler);
		assembler.getCpu().setCpuTracer(profiler);
		assembler.run(config);

		if (assembler.getMachine().getRam()[CHECKSUM_OK] != 1) {
			throw new AssertionError(expectedRoutine + ": real array checksum did not match");
		}
		List<ProfilerData> reads = profiler.getCollectedData().stream()
				.filter(call -> call.getCommand().startsWith("JSR ARRAYACCESS_REAL"))
				.collect(Collectors.toList());
		if (reads.size() != 1 || !reads.get(0).getCommand().equals("JSR " + expectedRoutine)
				|| reads.get(0).getCalls() != READS || reads.get(0).getTicks() <= 0) {
			throw new AssertionError("Expected " + READS + " calls to " + expectedRoutine + ", measured " + reads);
		}
		ProfilerData read = reads.get(0);
		System.out.printf(Locale.ROOT, "%s: %,d calls, %,d emulator cycles, %.2f cycles/call (excluding caller JSR)%n",
				expectedRoutine, read.getCalls(), read.getTicks(), (double) read.getTicks() / read.getCalls());
	}
}
