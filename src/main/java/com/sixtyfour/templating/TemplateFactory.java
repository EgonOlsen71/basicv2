package com.sixtyfour.templating;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.sixtyfour.Loader;

/**
 * A factory for creating Template objects. A template isn't thread-safe, i.e.
 * if you want to serve multiple clients at a time with the same template, you
 * have to create multiple template instances and manage them in a ThreadLocal
 * for example. The TemplateManager class has a basic implementation of this approach.
 * 
 * @author EgonOlsen
 */
public class TemplateFactory {

	/**
	 * Gets the template.
	 * 
	 * @param input
	 *            the inputstream of the template file
	 * @return the template
	 */
	public static Template getTemplate(InputStream input) {
		return getTemplate(input, new HashMap<String, Object>());
	}

	/**
	 * Gets the template.
	 * 
	 * @param input
	 *            the inputstream of the template file
	 * @param variables
	 *            the variables to prefill the template with
	 * @return the template
	 */
	public static Template getTemplate(InputStream input, Map<String, Object> variables) {
		return new Template(Loader.loadText(input), variables);
	}

}
