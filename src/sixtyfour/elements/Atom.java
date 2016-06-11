package sixtyfour.elements;

import sixtyfour.Machine;

public interface Atom extends Element {
	Type getType();
	
	Object eval(Machine memory);
}
