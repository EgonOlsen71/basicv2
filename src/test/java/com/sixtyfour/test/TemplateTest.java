package com.sixtyfour.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.templating.Template;
import com.sixtyfour.templating.TemplateManager;

/**
 * A basic template example/test.
 */
public class TemplateTest {
	private static CompilerConfig config = new CompilerConfig();

	public static void main(String[] args) throws Exception {
		testTemplate();
		testTemplateInclude();
		testLabeledTemplate();
	}

	private static void testTemplateInclude() {
		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("M", "This is a text");
		vars.put("EN", 8);
		vars.put("ST", 5);
		TemplateManager tm = TemplateManager.getInstance();
		Template templ = tm.getTemplate("src/test/resources/templates/includer.cbm");
		templ.setVariablesWithType(vars);
		String res = templ.process(config);
		System.out.println(res);
	}

	private static void testTemplate() throws Exception {
		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("CN", 10);
		vars.put("NA$", "Test");
		vars.put("TT$", "At least better than PHP!");

		TemplateManager tm = TemplateManager.getInstance();
		Template templ = tm.getTemplate("src/test/resources/templates/html.cbm");
		templ.setVariables(vars);
		String res = templ.process(config);
		System.out.println(res);
	}

	private static void testLabeledTemplate() throws Exception {
		final TemplateManager tm = TemplateManager.getInstance();

		List<Thread> ts = new ArrayList<Thread>();
		for (int i = 0; i < 10; i++) {
			Thread tr = new Thread() {
				@Override
				public void run() {
					Template templ = tm.getTemplate("src/test/resources/templates/htmlwithlabels.cbm");

					Map<String, Object> vars = new HashMap<String, Object>();
					vars.put("CN", 10);
					vars.put("NA$", "Test");
					vars.put("TT$", "At least better than PHP!");

					templ.setVariables(vars);
					String res = templ.process(config);
					System.out.println(res);
				}
			};
			tr.start();
			ts.add(tr);
		}

		for (Thread t : ts) {
			t.join();
		}

	}
}
