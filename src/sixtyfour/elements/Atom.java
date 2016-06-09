package sixtyfour.elements;

import sixtyfour.Memory;

public interface Atom extends Element {
	Type getType();
	
	Object eval(Memory memory);
}
