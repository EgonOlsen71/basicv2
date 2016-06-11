package sixtyfour.elements;

import sixtyfour.system.Machine;

public interface Atom extends Element {
	Type getType();
	
	Object eval(Machine memory);
}
