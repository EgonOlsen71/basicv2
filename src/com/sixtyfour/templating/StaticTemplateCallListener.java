package com.sixtyfour.templating;

import java.util.Map;

import com.sixtyfour.plugins.SystemCallListener;

/**
 * The listener interface for receiving staticTemplateCall events. The class
 * that is interested in processing a staticTemplateCall event implements this
 * interface, and the object created with that class is registered with a
 * component using the component's
 * <code>addStaticTemplateCallListener<code> method. When
 * the staticTemplateCall event occurs, that object's appropriate
 * method is invoked.
 * 
 * @see StaticTemplateCallEvent
 */
public class StaticTemplateCallListener implements SystemCallListener {
	
	/** The parts. */
	private Map<Integer, TemplatePart> parts;
	
	/** The out. */
	private TemplateOutputChannel out;

	/**
	 * Instantiates a new static template call listener.
	 * 
	 * @param parts
	 *            the parts
	 * @param out
	 *            the out
	 */
	public StaticTemplateCallListener(Map<Integer, TemplatePart> parts, TemplateOutputChannel out) {
		this.parts = parts;
		this.out = out;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.plugins.SystemCallListener#sys(int, java.lang.Object[])
	 */
	@Override
	public void sys(int addr, Object... params) {
		if (addr == 49152 && params != null && params.length == 1) {
			out.print(0, parts.get(params[0]).getContent());
		}
	}

}
