package com.sixtyfour.cbmnative;

import java.util.List;

/**
 * Interface for implementing a platform specific "unlinker". The runtime code
 * for the target platform is written as one file in assembly or javascript code
 * and the whole file will be appended to the compiled code. Implementing an
 * unlinker adds the option to strip away unused parts of the runtime code
 * afterwards.
 * 
 * @author EgonOlsen
 * 
 */
public interface Unlinker {

    /**
     * Removes unused parts from the runtime code.
     * 
     * @param code
     *            the code
     * @return the stripped code
     */
    List<String> unlink(List<String> code);

}