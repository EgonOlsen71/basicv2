package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The ON command.
 */
public class On extends AbstractCommand {

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0); // Recycle
																	// instance

	/** The line numbers. */
	private List<Integer> lineNumbers = new ArrayList<Integer>();

	/** The gosub. */
	private boolean gosub = false;

	/**
	 * Instantiates a new on.
	 */
	public On() {
		super("ON");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = linePart.substring(2).trim();
		String uPart = VarUtils.toUpper(linePart);
		int pos = uPart.lastIndexOf("GO");
		if (pos == -1) {
		  syntaxError(this);
		}
		term = Parser.getTerm(linePart.substring(0, pos), machine, false, true);

		if (term.getType().equals(Type.STRING)) {
		  typeMismatch(linePart);
		}

		gosub = uPart.indexOf("GOSUB") != -1;

		int numPos = -1;
		String lines = linePart.substring(pos);
		for (int i = 0; i < lines.length(); i++) {
			char c = lines.charAt(i);
			if (Character.isDigit(c)) {
				numPos = i;
				break;
			}
		}
		if (numPos == -1) {
		  syntaxError(this);
		}
		String[] parts = lines.substring(numPos).split(",");
		for (String part : parts) {
			try {
				if (part.length() == 0) {
					lineNumbers.add(0);
				} else {
					Integer li = Integer.valueOf(part.trim());
					lineNumbers.add(li);
				}
			} catch (Exception e) {
			  syntaxError(this);
			}
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		int index = VarUtils.getInt(term.eval(machine));
		if (index <= 0 || index > lineNumbers.size()) {
			return null;
		}
		pc.setLineNumber(lineNumbers.get(index - 1));
		if (gosub) {
			machine.push(this);
		}
		return pc;
	}

}
