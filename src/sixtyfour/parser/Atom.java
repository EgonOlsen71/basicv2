package sixtyfour.parser;

import sixtyfour.system.Machine;

public interface Atom {
	Type getType();
	
	Object eval(Machine memory);
}
