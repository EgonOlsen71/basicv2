package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class GeneratorList {

	private static final Generator LINE_NUMBER_GENERATOR = new LineNumberGenerator();

	private final static List<Generator> GENERATORS = Collections.unmodifiableList(new ArrayList<Generator>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new Mov());
			this.add(new Movb());
			this.add(new Pop());
			this.add(new Push());
			this.add(new Jmp());
			this.add(new Jsr());
			this.add(new Rts());
			this.add(new Brk());
			this.add(new Jne());
			this.add(new Je());
			this.add(new Cmp());
			this.add(new Eq());
			this.add(new Add());
			this.add(new Sub());
			this.add(new Mul());
			this.add(new Div());
		}
	});

	private final static Map<String, Generator> NAME_2_GEN = new HashMap<String, Generator>() {
		private static final long serialVersionUID = 1L;
		{
			for (Generator gen : GENERATORS) {
				this.put(gen.getMnemonic(), gen);
			}
		}
	};

	public static Generator getGenerator(String line) {
		line = line.trim().split(" ")[0].toUpperCase(Locale.ENGLISH);
		if (line.endsWith(":") && (isNumber(line) || line.startsWith("SKIP") || line.startsWith("NSKIP"))) {
			return LINE_NUMBER_GENERATOR;
		}
		return NAME_2_GEN.get(line);
	}

	private static boolean isNumber(String line) {
		try {
			line = line.replace(":", "");
			Integer.parseInt(line);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
