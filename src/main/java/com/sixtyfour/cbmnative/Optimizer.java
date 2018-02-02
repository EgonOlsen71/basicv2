package com.sixtyfour.cbmnative;

import java.util.List;

/**
 * @author EgonOlsen
 * 
 */
public interface Optimizer {

	List<String> optimize(PlatformProvider platform, List<String> input);

}
