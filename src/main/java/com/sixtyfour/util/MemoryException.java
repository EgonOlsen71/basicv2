package com.sixtyfour.util;

/**
 * @author EgonOlsen
 * 
 */
public class MemoryException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public MemoryException() {
		super();
	}

	public MemoryException(String msg, Throwable t) {
		super(msg, t);
	}

	public MemoryException(String msg) {
		super(msg);
	}

}
