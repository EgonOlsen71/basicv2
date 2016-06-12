package sixtyfour.parser;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public interface Atom {
	Type getType();
	
	Object eval(Machine memory);
}
