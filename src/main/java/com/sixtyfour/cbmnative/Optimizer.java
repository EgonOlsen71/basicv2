package com.sixtyfour.cbmnative;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;

/**
 * Interface for implementing an optimizer.
 * 
 * @author EgonOlsen
 * 
 */
public interface Optimizer {

	/**
	 * Optimizes native/assembly code.
	 * 
	 * @param the compiler config
	 * @param platform the target platform
	 * @param input    the input code
	 * @param pg       an optional progress listener
	 * @return the optimized code
	 */
	List<String> optimize(CompilerConfig config, PlatformProvider platform, List<String> input, ProgressListener pg);

}
