package com.sixtyfour.templating;

import java.util.Map;

import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.plugins.impl.RamSystemCallListener;
import com.sixtyfour.system.Machine;

/**
 * A listener used to process templates. Template parsing inserts SYS1000 calls
 * into the program, which will output the template's static content. This is
 * done here. All other SYS-calls will be redirect to an internal instance of
 * RamSystemCallListener.
 */
public class StaticTemplateCallListener implements SystemCallListener {

	/** The parts. */
	private Map<Integer, TemplatePart> parts;

	/** The out. */
	private TemplateOutputChannel out;

	private RamSystemCallListener ramCaller;

	/**
	 * Instantiates a new static template call listener.
	 * 
	 * @param parts
	 *            the parts
	 * @param out
	 *            the out
	 */
	public StaticTemplateCallListener(Map<Integer, TemplatePart> parts, TemplateOutputChannel out, Machine machine) {
		this.parts = parts;
		this.out = out;
		ramCaller = new RamSystemCallListener(machine);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.SystemCallListener#sys(int, java.lang.Object[])
	 */
	@Override
	public void sys(int addr, Object... params) {
		if (addr == 1000 && params != null && params.length == 1) {
			out.print(0, parts.get(params[0]).getContent());
		} else {
			ramCaller.sys(addr, params);
		}
	}

  @Override
  public float usr(Object params)
  {
    return ramCaller.usr(params);
  }

}
