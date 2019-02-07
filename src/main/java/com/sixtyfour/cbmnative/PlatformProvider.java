package com.sixtyfour.cbmnative;

/**
 * Interface for implementing a target platform.
 * 
 * @author EgonOlsen
 * 
 */
public interface PlatformProvider {

    /**
     * Returns the stack size that should be used on the target platform.
     * 
     * @return the size
     */
    int getStackSize();

    /**
     * Returns the stack size of the for-next stack that should be used on the
     * target platform.
     * 
     * @return the size
     */
    int getForStackSize();

    /**
     * Returns the optimizer that should be used on the target platform.
     * 
     * @return the optimizer or null, if none should be used
     */
    Optimizer getOptimizer();

    /**
     * Returns the transformer that should be used for the target platform.
     * 
     * @return the transformer
     */
    Transformer getTransformer();

    /**
     * Returns the unlinker that should be used on the target platform.
     * 
     * @return the unlinker or null, if none should be used
     */
    Unlinker getUnlinker();

    /**
     * Returns true, if loose types are allowed. False if not.
     * 
     * @return Are they allowed?
     */
    boolean useLooseTypes();
    
    /**
     * Address, up to which it's feasible to add a BASIC header to the compiled code
     * @return the address
     */
    int getMaxHeaderAddress();
    
    /**
     * Default base address at which the BASIC ram usually starts on a platform.
     * 
     * @return the address
     */
    int getBaseAddress();
    
}
