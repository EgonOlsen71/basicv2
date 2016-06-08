package sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sixtyfour.elements.Line;
import sixtyfour.elements.commands.Command;

public class Interpreter {

	private String[] code = null;
	private Map<Integer, Line> lines = new HashMap<Integer, Line>();
	private List<Integer> lineNumbers = new ArrayList<Integer>();
	private Memory memory = null;

	public Interpreter(String code) {
		this(code.split("\n"));
	}

	public Interpreter(String[] code) {
		this.code = Arrays.copyOf(code, code.length);
	}

	public Memory getMemory() {
		return memory;
	}

	public void parse() {
		memory = new Memory();
		for (String line : code) {
			Line cl = Parser.getLine(line);
			if (lines.containsKey(cl.getNumber())) {
				throw new RuntimeException("Duplicate line number in: " + line);
			}
			lines.put(cl.getNumber(), cl);
			lineNumbers.add(cl.getNumber());
			String[] parts = Parser.getParts(cl, memory);

			for (String part : parts) {
				Command command = Parser.getCommand(part);
				command.parse(part, memory);
				cl.addCommand(command);
			}
		}
	}

	public void execute() {
		execute(0);
	}

	public void execute(int lineCnt) {
		Integer num = lineNumbers.get(lineCnt);
		Line line = lines.get(num);
		for (Command command : line.getCommands()) {
			command.execute(memory);
		}
		if (lineCnt < lines.size() - 1) {
			lineCnt++;
			execute(lineCnt);
		}
	}

}
