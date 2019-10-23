package com.sixtyfour.cbmnative.powerscript;

import java.util.List;

import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;
import com.sixtyfour.config.CompilerConfig;

/**
 * An optimizer implementation for the Powerscript target platform. It doesn't
 * do anything but return the input ATM.
 * 
 * @author EgonOlsen
 *
 */
public class OptimizerPs implements Optimizer {

	@Override
	public List<String> optimize(CompilerConfig config, PlatformProvider platform, List<String> code, ProgressListener pg) {
		return code;
	}

}
