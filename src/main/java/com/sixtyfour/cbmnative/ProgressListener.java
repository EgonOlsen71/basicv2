package com.sixtyfour.cbmnative;

/**
 * A listener that can be attached to an optimizer to visualize the progress.
 * 
 * @author EgonOlsen
 * 
 */
public interface ProgressListener {

	/**
	 * Called one time when the process starts.
	 */
	void start();

	/**
	 * Called for each "step". It depends on the optimizer's implementation what
	 * exactly a step represents.
	 */
	void nextStep();

	/**
	 * Called one time when the process is done.
	 */
	void done();
}
