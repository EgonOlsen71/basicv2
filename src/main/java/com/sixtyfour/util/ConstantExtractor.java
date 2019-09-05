package com.sixtyfour.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Basic;
import com.sixtyfour.extensions.BasicExtension;

/**
 * Collects all label2constant maps from all the used BasicExtension in the
 * current context.
 * 
 * @author EgonOlsen
 *
 */
public class ConstantExtractor {

	/**
	 * Collects all label2constant maps from all the used BasicExtension in the
	 * current context.
	 * 
	 * @return the map containing all the constants
	 */
	public static Map<String, Integer> getAllConstantMaps() {
		Map<String, Integer> ret = new HashMap<>();
		List<BasicExtension> exts = Basic.getExtensions();
		for (BasicExtension ext : exts) {
			Map<String, Integer> cs = ext.getLabel2Constant();
			if (cs != null) {
				ret.putAll(cs);
			}
		}
		return ret;
	}

}
