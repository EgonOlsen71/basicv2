package sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class FunctionList {
	public static final List<Function> FUNCTIONS = Collections.unmodifiableList(new ArrayList<Function>() {
		private static final long serialVersionUID = 1L;

		{
			this.add(new Sin());
			this.add(new Cos());
			this.add(new Peek());
			this.add(new Mid());
			this.add(new Spc());
			this.add(new Tab());
			this.add(new Pos());
			this.add(new Int());
			this.add(new Fre());
			this.add(new Rnd());
			this.add(new Usr());
			this.add(new Abs());
			this.add(new Atn());
			this.add(new Exp());
			this.add(new Log());
			this.add(new Sgn());
			this.add(new Sqr());
			this.add(new Tan());
			this.add(new Len());
			this.add(new Asc());
			this.add(new Val());
			this.add(new Chr());
			this.add(new Str());
			this.add(new Left());
			this.add(new Right());
		}
	});

	public static List<Function> getFunctions() {
		return FUNCTIONS;
	}
}
