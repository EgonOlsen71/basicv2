package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.Machine;
import sixtyfour.elements.Atom;
import sixtyfour.elements.ProgramCounter;
import sixtyfour.elements.Type;
import sixtyfour.parser.Parser;

public class Poke extends AbstractCommand {

	private List<Atom> pars;

	public Poke() {
		super("POKE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, memory);
		term = Parser.getTerm(this, linePart, memory);
		pars = Parser.getParameters(term);

		if (pars.size() != 2) {
			throw new RuntimeException("Syntax error: " + this);
		}

		return null;
	}

	@Override
	public ProgramCounter execute(Machine memory) {
		Atom addr = pars.get(0);
		Atom val = pars.get(1);
		if (addr.getType().equals(Type.STRING) || val.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		int memAddr = ((Number) addr.eval(memory)).intValue();
		int vally = ((Number) val.eval(memory)).intValue();
		if (vally < 0 || vally > 255 || memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}

		memory.getRam()[memAddr] = vally;
		return null;

	}
}
