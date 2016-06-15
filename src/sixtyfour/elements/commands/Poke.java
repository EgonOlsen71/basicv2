package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Poke extends AbstractCommand {

	private List<Atom> pars;

	public Poke() {
		super("POKE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, machine);
		term = Parser.getTerm(this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.size() != 2) {
			throw new RuntimeException("Syntax error: " + this);
		}

		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		Atom addr = pars.get(0);
		Atom val = pars.get(1);
		if (addr.getType().equals(Type.STRING) || val.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		int memAddr = ((Number) addr.eval(machine)).intValue();
		int vally = ((Number) val.eval(machine)).intValue();
		if (vally < 0 || vally > 255 || memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}

		machine.getRam()[memAddr] = vally;
		machine.getMemoryListener().poke(memAddr, vally);
		return null;

	}
}
