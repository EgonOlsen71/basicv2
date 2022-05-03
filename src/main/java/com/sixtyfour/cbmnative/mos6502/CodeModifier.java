package com.sixtyfour.cbmnative.mos6502;

import java.util.List;

/**
 * 
 * @author EgonOlsen
 *
 */
public interface CodeModifier {

	public List<String> modify(IntPattern pattern, List<String> input);

}
