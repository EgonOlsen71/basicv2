package com.sixtyfour.cbmnative;

import java.util.List;

/**
 * Interface from implementing an optimizer.
 * 
 * @author EgonOlsen
 * 
 */
public interface Optimizer {

	/**
	 * Optimizes native/assembly code.
	 * 
	 * @param platform the target platform
	 * @param input    the input code
	 * @return the optimized code
	 */
	List<String> optimize(PlatformProvider platform, List<String> input);

	/**
	 * Optimizes native/assembly code.
	 * 
	 * @param platform the target platform
	 * @param input    the input code
	 * @param pg       an optional progress listener
	 * @return the optimized code
	 */
	List<String> optimize(PlatformProvider platform, List<String> input, ProgressListener pg);

}
