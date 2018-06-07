package com.sixtyfour.cbmnative;

/**
 * @author EgonOlsen
 *
 */
public interface ProgressListener {

	void start();
	
	void nextStep();
	
	void done();
}
