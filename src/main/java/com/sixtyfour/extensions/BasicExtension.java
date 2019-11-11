package com.sixtyfour.extensions;

import java.util.List;
import java.util.Map;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.system.Machine;

/**
 * Interface for implementing BASIC extensions
 * 
 * @author EgonOlsen
 * 
 */
public interface BasicExtension {
    /**
     * Returns all commands of this extension. If null, no new commands will be
     * recognized.
     * 
     * @return the new commands or null
     */
    List<Command> getCommands();

    /**
     * Returns all functions of this extension. If null, no new functions will
     * be recognized.
     * 
     * @return the new functions or null
     */
    List<Function> getFunctions();

    /**
     * Returns a list of optional runtime libaries that are needed for this
     * extension to be natively compiled.
     * 
     * @return the list or null
     */
    List<String> getAdditionalIncludes();

    /**
     * Returns additional system variables like ST or TI for this extension
     * 
     * @return the list or null
     */
    List<Variable> getSystemVariables();
    
    /**
     * Called when a machine instance gets reset.
     * 
     * @param machine
     *            the machine instance
     */
    void reset(Machine machine);

    /**
     * Returns a map of optional constants that are needed for this extension to
     * be natively compiled.
     * 
     * @return the map or null
     */
    Map<String, Integer> getLabel2Constant();

    /**
     * Returns true, if a function (which has to be part of this extensions)
     * with a given name is a single sided function. Returns false otherwise or
     * if the function name isn't know to this extension. This default
     * implementation returns true for all functions of the extension which
     * should be normal case.
     * 
     * 
     * @param function
     *            the name of the function
     * @return if it's single sided or not
     */
    default boolean isSingleSided(String function) {
	for (Function fun : getFunctions()) {
	    if (fun.isNativeFunction(function)) {
		return true;
	    }
	}
	return false;
    }

    /**
     * Applies an operation (function) by adding new code to the list, if this
     * is possible. This only applies to functions in extended BASIC, not the default ones.
     * * 
     * @param function the operator/function call
     * @param code the code
     * @return has something been added to the code?
     */
    default boolean applyOperation(String function, List<String> code) {
	for (Function fun : getFunctions()) {
	    if (fun.isNativeFunction(function)) {
		boolean added = fun.addNativeFunctionCall(code);
		if (added) {
		    return true;
		}
	    }
	}
	return false;
    }

}
