package com.sixtyfour.config;

import java.util.List;

import com.sixtyfour.cbmnative.Pattern;

/**
 * Interface for providing optimizer hints and/or additional runtime code that
 * should only be used in some special cases and are not part of the normal
 * operation of the compiler.
 * 
 * @author EgonOlsen
 *
 */
public interface RuntimeAddition {

	List<Pattern> getAdditionalPatterns();

	List<String> getAdditionalRuntimeCode();

}
