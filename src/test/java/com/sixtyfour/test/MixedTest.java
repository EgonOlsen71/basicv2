package com.sixtyfour.test;

import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.plugins.impl.RamSystemCallListener;
import com.sixtyfour.system.Machine;
import com.sixtyfour.templating.Template;
import com.sixtyfour.templating.TemplateFactory;

/**
 * @author EgonOlsen
 * 
 */
public class MixedTest {
	private static CompilerConfig config = new CompilerConfig();

	public static void main(String[] args) throws Exception {
		testMixed();
		testMixedTemplate();
		testBeerTemplate();
	}

	private static void testBeerTemplate() throws Exception {
		Template templ = TemplateFactory.getTemplate(config, new FileInputStream("src/test/resources/mixed/beer.cbm"), null);
		String res = templ.process(config);
		System.out.println(res);

	}

	private static void testMixedTemplate() throws Exception {
		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("CN", 10);
		vars.put("NA$", "Test");
		vars.put("TT$", "At least better than PHP!");
		Template templ = TemplateFactory.getTemplate(config, new FileInputStream("src/test/resources/mixed/mixedhtml.cbm"), vars);
		String res = templ.process(config);
		System.out.println(res);
	}

	private static void testMixed() {
		String[] basicCode = Loader.loadProgram("src/test/resources/mixed/basicasm.bas");
		String[] asmCode = Loader.loadProgram("src/test/resources/asm/example3.asm");
		Basic basic = new Basic(basicCode);
		Machine machine = basic.getMachine();

		Assembler asm = new Assembler(asmCode, machine);
		asm.compile(config);

		basic.setSystemCallListener(new RamSystemCallListener(machine));
		basic.compile(config);
		machine.getCpu().setExitOnBreak(false);
		machine.putProgram(asm.getProgram());
		basic.run(config);
	}

}
