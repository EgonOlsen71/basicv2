package com.sixtyfour.templating;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import com.sixtyfour.Loader;

/**
 * A factory for creating Template objects.
 * 
 * @author Foerster-H
 */
public class TemplateFactory {
	
	/**
	 * Gets the template.
	 * 
	 * @param input
	 *            the input
	 * @return the template
	 */
	public static Template getTemplate(InputStream input) {
		return getTemplate(input, new HashMap<String, Object>());
	}

	/**
	 * Gets the template.
	 * 
	 * @param input
	 *            the input
	 * @param variables
	 *            the variables
	 * @return the template
	 */
	public static Template getTemplate(InputStream input, Map<String, Object> variables) {
		return new Template(Loader.loadText(input), variables);
	}

}
