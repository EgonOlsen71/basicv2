package com.sixtyfour.elements.commands;

import java.util.List;

/**
 * @author EgonOlsen
 *
 */
public interface Jump {
	/**
	 * Returns the target line numbers of a jump
	 * 
	 * @return
	 */
	List<Integer> getTargetLineNumbers();
}
