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
		}
	});

	public static List<Function> getFunctions() {
		return FUNCTIONS;
	}
}
