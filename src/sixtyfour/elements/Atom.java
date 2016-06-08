package sixtyfour.elements;

public interface Atom extends Element {
	Type getType();
	
	Object eval();
}
