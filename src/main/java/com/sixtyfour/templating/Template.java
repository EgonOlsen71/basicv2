package com.sixtyfour.templating;

import java.util.HashMap;
import java.util.Map;

import com.sixtyfour.Basic;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Line;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * A template. A template can be HTML (but doesn't have to) with BASIC V2 code in it.
 * When parsed the template will be converted into a BASIC program. This requires to add some
 * additional line numbers, so make sure that there's enough number space left between lines.
 * See the test package for an example template.
 */
public class Template {

	/** The vars. */
	private Map<String, Object> vars = new HashMap<String, Object>();

	/** The interpreter. */
	private Basic interpreter = null;

	/** The static parts. */
	private Map<Integer, TemplatePart> staticParts = new HashMap<Integer, TemplatePart>();

	/** The out. */
	private TemplateOutputChannel out;

	/**
	 * Instantiates a new template.
	 * 
	 * @param template
	 *            the template's content
	 * @param variables
	 *            the variables to prefill the template with
	 */
	public Template(String template, Map<String, Object> variables) {
		vars.putAll(variables);
		parseTemplate(template);
	}

	/**
	 * Sets a variable to a new value.
	 * 
	 * @param name
	 *            the name of the variable in the template's basic code
	 * @param value
	 *            the new value
	 */
	public void setVariable(String name, Object value) {
		vars.put(name, value);
	}

	/**
	 * Gets a variable's value.
	 * 
	 * @param name
	 *            the name of the variable in the template's basic code
	 * @return the variable
	 */
	public Object getVariable(String name) {
		Variable var = interpreter.getMachine().getVariable(VarUtils.toUpper(name));
		if (var == null) {
			return null;
		}
		return var.getValue();
	}

	/**
	 * Processes the templates. This resets the underlying machine instance.
	 * 
	 * @return the processed template, i.e. the generated output.
	 */
	public String process() {
		out.reset();
		Machine machine = interpreter.getMachine();
		machine.resetMemory();
		for (Map.Entry<String, Object> var : vars.entrySet()) {
			Variable vary = new Variable(VarUtils.toUpper(var.getKey()), var.getValue());
			machine.addOrSet(vary);
		}
		interpreter.start();
		return out.getResult();
	}

	/**
	 * Parses the template.
	 * 
	 * @param template
	 *            the template
	 */
	private void parseTemplate(String template) {
		template += "<?cbm 9999999 REM end ?>";
		String utemp = VarUtils.toUpper(template);
		int pos = 0;
		int last = 0;
		int lastLine = 0;
		StringBuilder code = new StringBuilder();
		do {
			pos = utemp.indexOf("<?CBM", pos);
			if (pos != -1) {
				int pos2 = -1;
				boolean inString = false;
				for (int i = pos; i < utemp.length() - 1; i++) {
					char c = utemp.charAt(i);
					if (c == '"') {
						inString = !inString;
					}
					if (!inString && c == '?' && utemp.charAt(i + 1) == '>') {
						pos2 = i + 2;
						break;
					}
				}
				if (pos2 == -1) {
					throw new RuntimeException("Syntax error in template, no closing ?> found!");
				}

				String prior = template.substring(last, pos);
				String codePart = template.substring(pos + 5, pos2 - 2);
				int firstLine = -1;
				int endLine = -1;

				String[] lines = codePart.split("\n");
				for (String line : lines) {
					line = line.replace("\t", "").trim();
					if (!line.isEmpty()) {
						Line lo = Line.getLine(line);
						firstLine = lo.getNumber();
						break;
					}
				}

				for (int i = lines.length - 1; i >= 0; i--) {
					String line = lines[i];
					line = line.replace("\t", "").trim();
					if (!line.isEmpty()) {
						Line lo = Line.getLine(line);
						endLine = lo.getNumber();
						break;
					}
				}

				if (firstLine <= lastLine) {
					throw new RuntimeException("Line numbers (" + firstLine + "/" + lastLine + ") too close, can't insert static content into template!");
				}

				if (!prior.isEmpty()) {
					TemplatePart tp = new TemplatePart(prior);
					tp.setFirstLine(lastLine);
					tp.setLastLine(firstLine - 1);
					lastLine++;
					code.append(lastLine).append(" SYS1000,").append(lastLine).append('\n');
					staticParts.put(lastLine, tp);
				}
				code.append(codePart).append('\n');

				lastLine = endLine;
				last = pos2;
				pos = pos2;
			}
		} while (pos != -1);

		// System.out.println(code);
		interpreter = new Basic(code.toString());
		interpreter.compile();
		out = new TemplateOutputChannel();
		interpreter.setOutputChannel(out);
		interpreter.getMachine().setSystemCallListener(new StaticTemplateCallListener(staticParts, out));
	}

}
