package sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import sixtyfour.elements.commands.Command;
import sixtyfour.elements.commands.Rem;
import sixtyfour.parser.Line;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Interpreter {

	private String[] code = null;
	private Map<Integer, Line> lines = new HashMap<Integer, Line>();
	private List<Integer> lineNumbers = new ArrayList<Integer>();
	private Machine machine = null;
	private boolean parsed = false;

	public Interpreter(String code) {
		this(code.split("\n"));
	}

	public Interpreter(String[] code) {
		this.code = Arrays.copyOf(code, code.length);
	}

	public Machine getMachine() {
		return machine;
	}

	public String getStringVariable(String name) {
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (obj instanceof String) {
			return (String) obj;
		}
		return null;
	}

	public Integer getIntegerVariable(String name) {
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (obj instanceof Integer) {
			return (Integer) obj;
		}
		return null;
	}

	public Float getFloatVariable(String name) {
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (obj instanceof String) {
			return (Float) obj;
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public Object[] getArrayVariable(String name) {
		if (!name.endsWith("[]")) {
			name = name + "[]";
		}
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (obj.getClass().isArray()) {
			return ((ArrayList<Object>) obj).toArray();
		}
		return null;
	}

	public void parse() {
		long start = System.nanoTime();
		machine = new Machine();
		Line cl = null;
		for (String line : code) {
			try {
				cl = Parser.getLine(line);
				if (lines.containsKey(cl.getNumber())) {
					throw new RuntimeException("Duplicate line number in: " + line);
				}

				int lineCnt = lineNumbers.size();
				cl.setCount(lineCnt);

				lines.put(cl.getNumber(), cl);
				lineNumbers.add(cl.getNumber());
				String[] parts = Parser.getParts(cl, machine);

				int pos = 0;
				for (String part : parts) {
					do {
						if (part.trim().length() > 0) {
							Command command = Parser.getCommand(part);
							if (command == null) {
								throw new RuntimeException("Syntax error: " + cl.getNumber() + " " + cl.getLine());
							}
							part = command.parse(part, lineCnt, cl.getNumber(), pos, machine);

							machine.addCommand(command);
							cl.addCommand(command);
							pos++;
							if (Rem.REM_MARKER.equals(part)) {
								break;
							}
						} else {
							part = null;
						}
					} while (part != null);
					if (Rem.REM_MARKER.equals(part)) {
						break;
					}
				}
			} catch (Throwable t) {
				String msg = t.getMessage();
				String err = "Error in line " + (cl != null ? cl.getNumber() : "??") + (msg != null ? (": " + msg) : "");
				machine.getOutputChannel().println(err);
				throw t;
			}
		}
		parsed = true;
		Logger.log(machine.getCommandList().size() + " commands parsed in: " + (System.nanoTime() - start) / 1000000L + "ms");
	}

	public void run() {
		if (!parsed) {
			parse();
		}
		if (parsed) {
			long start = System.nanoTime();
			execute(0, 0);
			long end = System.nanoTime();
			machine.getOutputChannel().println("READY. (" + ((end - start) / 1000000L) + "ms)");
		} else {
			machine.getOutputChannel().println("READY.");
		}

	}

	public void execute(int lineCnt, int pos) {
		if (lineNumbers.size() == 0) {
			return;
		}
		Integer num = null;
		try {
			do {
				num = lineNumbers.get(lineCnt);
				Line line = lines.get(num);
				for (int i = pos; i < line.getCommands().size(); i++) {
					Command command = line.getCommands().get(i);
					machine.setCurrentCommand(command);
					ProgramCounter pc = command.execute(machine);
					machine.setCurrentCommand(null);
					if (pc != null) {
						if (pc.isEnd() || pc.isStop()) {
							lineCnt = lines.size();
							if (pc.isStop()) {
								this.machine.getOutputChannel().println("Break in " + num);
							}
							break;
						}
						if (pc.isSkip()) {
							break;
						}
						if (pc.getLineNumber() == -1) {
							// Line index is known (FOR...NEXT)
							lineCnt = pc.getLineCnt();
							num = lineNumbers.get(lineCnt);
							line = lines.get(num);
							i = pc.getLinePos();
							if (i >= line.getCommands().size() - 1) {
								lineCnt++;
								num = lineNumbers.get(lineCnt);
								line = lines.get(num);
								i = -1;
							}
						} else {
							// Line number is unknown (GOTO/GOSUB)
							num = pc.getLineNumber();
							line = lines.get(num);
							i = -1;
							if (line == null) {
								throw new RuntimeException("Undef'd statement error: " + command);
							}
							lineCnt = line.getCount();
						}
					}
				}
				lineCnt++;
			} while (lineCnt < lines.size());
		} catch (Throwable t) {
			String msg = t.getMessage();
			String err = "Error in line " + (num != null ? num : "??") + (msg != null ? (": " + msg) : "");
			machine.getOutputChannel().println(err);
			throw t;
		}
	}
}
