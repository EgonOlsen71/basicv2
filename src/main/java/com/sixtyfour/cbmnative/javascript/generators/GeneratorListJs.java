package com.sixtyfour.cbmnative.javascript.generators;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.cbmnative.Generator;

public class GeneratorListJs {

	private static final Generator LINE_NUMBER_GENERATOR = new LineNumberGeneratorJs();

	private final static List<Generator> GENERATORS = Collections.unmodifiableList(new ArrayList<Generator>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new NopJs());
			this.add(new RtsJs());
			this.add(new JsrJs());
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
		if (line.endsWith(":")) {
			return LINE_NUMBER_GENERATOR;
		}
		return NAME_2_GEN.get(line);
	}
}
