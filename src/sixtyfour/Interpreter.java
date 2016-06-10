package sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sixtyfour.elements.Line;
import sixtyfour.elements.ProgramCounter;
import sixtyfour.elements.commands.Command;
import sixtyfour.elements.commands.Rem;

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

			int lineCnt = lineNumbers.size();

			lines.put(cl.getNumber(), cl);
			lineNumbers.add(cl.getNumber());
			String[] parts = Parser.getParts(cl, memory);

			int pos = 0;
			for (String part : parts) {
				do {
					Command command = Parser.getCommand(part);
					if (command == null) {
						throw new RuntimeException("Syntax error: " + cl.getNumber() + " " + cl.getLine());
					}
					part = command.parse(part, lineCnt, cl.getNumber(), pos, memory);

					memory.addCommand(command);
					cl.addCommand(command);
					pos++;
					if (Rem.REM_MARKER.equals(part)) {
						break;
					}
				} while (part != null);
				if (Rem.REM_MARKER.equals(part)) {
					break;
				}
			}
		}
	}

	public void run() {
		long start = System.nanoTime();
		execute(0, 0);
		long end = System.nanoTime();
		Logger.log("READY. (" + ((end - start) / 1000000L) + "ms)");
	}

	public void execute(int lineCnt, int pos) {
		Integer num = lineNumbers.get(lineCnt);
		Line line = lines.get(num);
		for (int i = pos; i < line.getCommands().size(); i++) {
			Command command = line.getCommands().get(i);
			memory.setCurrentCommand(command);
			ProgramCounter pc = command.execute(memory);
			memory.setCurrentCommand(null);
			if (pc != null) {
				num = lineNumbers.get(pc.getLineCnt());
				line = lines.get(num);
				i = pc.getLinePos();
				if (i >= line.getCommands().size() - 1) {
					num = lineNumbers.get(pc.getLineCnt() + 1);
					i = -1;
				}
			}
		}
		if (lineCnt < lines.size() - 1) {
			lineCnt++;
			execute(lineCnt, 0);
		}
	}

}
