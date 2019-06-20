package com.sixtyfour.cbmnative.powerscript.generators;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.cbmnative.Generator;

public class GeneratorListPs {

	private static final Generator LINE_NUMBER_GENERATOR = new LineNumberGeneratorPs();

	private final static List<Generator> GENERATORS = Collections.unmodifiableList(new ArrayList<Generator>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new NopPs());
			this.add(new RtsPs());
			this.add(new JsrPs());
			this.add(new JmpPs());
			this.add(new JnePs());
			this.add(new JePs());
			this.add(new MovPs());
			this.add(new MovbPs());
			this.add(new AddPs());
			this.add(new SubPs());
			this.add(new MulPs());
			this.add(new DivPs());
			this.add(new PopPs());
			this.add(new PushPs());
			this.add(new ShrPs());
			this.add(new ShlPs());
			this.add(new EqPs());
			this.add(new LtPs());
			this.add(new GtPs());
			this.add(new NeqPs());
			this.add(new GteqPs());
			this.add(new LteqPs());
			this.add(new CmpPs());
			this.add(new AndPs());
			this.add(new IntPs());
			this.add(new AbsPs());
			this.add(new AtnPs());
			this.add(new CosPs());
			this.add(new SinPs());
			this.add(new NotPs());
			this.add(new TanPs());
			this.add(new RndPs());
			this.add(new SqrPs());
			this.add(new PowPs());
			this.add(new SgnPs());
			this.add(new BrkPs());
			this.add(new OrPs());
			this.add(new LogPs());
			this.add(new ExpPs());
			this.add(new XorPs());
			this.add(new NegPs());
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
