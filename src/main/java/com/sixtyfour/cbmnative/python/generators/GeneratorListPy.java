package com.sixtyfour.cbmnative.python.generators;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.cbmnative.Generator;

/**
 * 
 * @author EgonOlsen
 *
 */
public class GeneratorListPy {

	private static final Generator LINE_NUMBER_GENERATOR = new LineNumberGeneratorPy();

	private final static List<Generator> GENERATORS = Collections.unmodifiableList(new ArrayList<Generator>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new NopPy());
			this.add(new RtsPy());
			this.add(new JsrPy());
			this.add(new JmpPy());
			this.add(new JnePy());
			this.add(new JePy());
			this.add(new MovPy());
			this.add(new MovbPy());
			this.add(new AddPy());
			this.add(new SubPy());
			this.add(new MulPy());
			this.add(new DivPy());
			this.add(new PopPy());
			this.add(new PushPy());
			this.add(new ShrPy());
			this.add(new ShlPy());
			this.add(new EqPy());
			this.add(new LtPy());
			this.add(new GtPy());
			this.add(new NeqPy());
			this.add(new GteqPy());
			this.add(new LteqPy());
			this.add(new CmpPy());
			this.add(new AndPy());
			this.add(new IntPy());
			this.add(new AbsPy());
			this.add(new AtnPy());
			this.add(new CosPy());
			this.add(new SinPy());
			this.add(new NotPy());
			this.add(new TanPy());
			this.add(new RndPy());
			this.add(new SqrPy());
			this.add(new PowPy());
			this.add(new SgnPy());
			this.add(new BrkPy());
			this.add(new OrPy());
			this.add(new LogPy());
			this.add(new ExpPy());
			this.add(new XorPy());
			this.add(new NegPy());
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
