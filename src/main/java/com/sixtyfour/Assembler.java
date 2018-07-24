package com.sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantValue;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelAndCode;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;
import com.sixtyfour.system.ProgramPart;
import com.sixtyfour.util.MemoryException;
import com.sixtyfour.util.VarUtils;

/**
 * Assembler is for parsing/compiling and executing 6502 assembler programs. The
 * program will be compiled into actual 6502 binary code. When running it, it
 * will be copied into the machines 64kb of memory and executed from there by
 * using a 6502 emulation layer.
 * 
 * @author EgonOlsen
 */
public class Assembler implements ProgramExecutor {
	private String[] code = null;
	private int codeStart = -1;
	private int startAddr = 0;
	private Machine machine = null;
	private Program program = null;
	private boolean running = false;
	private Map<Integer, String> addr2code = new HashMap<Integer, String>();

	/**
	 * Instantiates a new compiler for an assembler program. No
	 * interpretation/compilation will take place at this stage.
	 * 
	 * @param code
	 *            the assembler code
	 */
	public Assembler(String code) {
		this(code.split("\n"));
	}

	/**
	 * Instantiates a new compiler for an assembler program. No
	 * interpretation/compilation will take place at this stage. This
	 * constructor takes an array of code lines as input. Each code line should
	 * represent a line in the assembler program.
	 * 
	 * @param code
	 *            the assembler code
	 */
	public Assembler(String[] code) {
		this(code, null);
	}

	/**
	 * Instantiates a new compiler for an assembler program. No
	 * interpretation/compilation will take place at this stage. This
	 * constructor takes an list of code lines as input. Each code line should
	 * represent a line in the assembler program.
	 * 
	 * @param code
	 *            the assembler code
	 */
	public Assembler(List<String> code) {
		this(code.toArray(new String[code.size()]), null);
	}

	/**
	 * Instantiates a new compiler for an assembler program. No
	 * interpretation/compilation will take place at this stage.
	 * 
	 * @param code
	 *            the assembler code
	 * @param machine
	 *            the machine instance that should be used to run the code. If
	 *            null is given, a new one will be created.
	 */
	public Assembler(String code, Machine machine) {
		this(code.split("\n"), machine);
	}

	/**
	 * Instantiates a new compiler for an assembler program. No
	 * interpretation/compilation will take place at this stage. This
	 * constructor takes an array of code lines as input. Each code line should
	 * represent a line in the assembler program.
	 * 
	 * @param code
	 *            the assembler code
	 * @param machine
	 *            the machine instance that should be used to run the code. If
	 *            null is given, a new one will be created.
	 */
	public Assembler(String[] code, Machine machine) {
		this.code = Arrays.copyOf(code, code.length);
		if (machine == null) {
			this.machine = new Machine();
		} else {
			this.machine = machine;
		}
	}

	/**
	 * Compiles the code. This can be called before calling the actual run
	 * method to precompile the code. It doesn't have to though, because run()
	 * will call it on its own if needed. After compilation, the compiled
	 * program can be obtained via getProgram(); The compiled Program instance
	 * has a starting address set that is based on the first block of actual
	 * opcodes in the assembler listing. If this assumption isn't true for a
	 * particular program, you have to set the value manually before executing
	 * the actual program.
	 */
	@Override
	public void compile(CompilerConfig config) {
		Logger.log("Running assembler...");
		Machine compileMachine = new Machine();
		ConstantsContainer ccon = new ConstantsContainer();
		LabelsContainer lcon = new LabelsContainer(compileMachine);
		int addr = 0;
		int cnt = 0;
		long startTime = System.nanoTime();
		List<Integer> lineBreaks = new ArrayList<Integer>();
		Program prg = new Program();
		prg.setLabelsContainer(lcon);
		boolean initial = true;
		Set<Integer> usedAddrs = new HashSet<>();

		for (String line : code) {
			String oLine = line;
			cnt++;
			line = line.replace('\t', ' ').trim();
			if (line.startsWith(";")) {
				// Ignore comment lines
				continue;
			}

			line = AssemblyParser.truncateComments(line);

			if (line.length() == 0) {
				continue;
			}

			ConstantValue cv = AssemblyParser.getConstant(config, line, ccon);
			if (cv != null) {
				ccon.put(cv);
				if (cv.getName().equals("*")) {
					if (initial) {
						initial = false;
					} else {
						ProgramPart part = new ProgramPart();
						part.setAddress(startAddr);
						part.setEndAddress(addr);
						part.setLineAddresses(createAndResetOpas(lineBreaks));
						prg.addPart(part);
					}
					addr = cv.getValue();
					startAddr = addr;
				}
				continue;
			}

			boolean isData = line.startsWith(".");
			if (!isData) {
				Mnemonic mne = AssemblyParser.getMnemonic(line);
				if (mne == null) {
					LabelAndCode lac = AssemblyParser.getLabel(line);

					if (lac != null) {
						if (lac.getCode().startsWith(".")) {
							isData = true;
						} else {
							mne = AssemblyParser.getMnemonic(lac.getCode());
						}
						lcon.put(lac.getLabel(), addr);
						line = lac.getCode();
					} else {
						raiseError("Syntax error at: " + oLine + "/" + addr, addr, cnt);
					}
				}
				if (!isData) {
					if (mne != null) {
						if (codeStart == -1) {
							codeStart = addr;
						}
						try {
							lineBreaks.add(addr);
							addr2code.put(addr, line);
							int oldAddr = addr;
							addr = mne.parse(config, line, addr, compileMachine, ccon, lcon);
							flagAddress(usedAddrs, oldAddr, addr);
						} catch (RuntimeException re) {
							raiseError("Error at line: " + oLine, re, addr, cnt);
						}
					} else {
						if (!line.trim().isEmpty()) {
							raiseError("Unknown mnemonic in: " + oLine, addr, cnt);
						}
					}
				}
			}
			if (isData) {
				String lineUpper = VarUtils.toUpper(line.trim());
				int[] data = AssemblyParser.getBinaryData(config, addr, line, ccon, lcon);
				lineBreaks.add(addr);
				System.arraycopy(data, 0, compileMachine.getRam(), addr, data.length);
				if (lineUpper.startsWith(".STRG")) {
					// If it's a string, the length might have changed due to
					// place holder conversions to control codes. So we set the
					// actual length here.
					compileMachine.getRam()[addr - 1] = data.length;
				}
				int oldAddr = addr;
				addr += data.length;
				flagAddress(usedAddrs, oldAddr, addr);
			}

		}

		if (lcon.hasDelayedLabels()) {
			raiseError("Undefined label: " + lcon.getFirstDelayedLabel(), addr, cnt);
		}

		if (addr != startAddr) {
			ProgramPart part = new ProgramPart();
			part.setAddress(startAddr);
			part.setEndAddress(addr);
			part.setLineAddresses(createAndResetOpas(lineBreaks));
			prg.addPart(part);
		}

		for (ProgramPart part : prg.getParts()) {
			part.setBytes(Arrays.copyOfRange(compileMachine.getRam(), part.getAddress(), part.getEndAddress()));
		}

		prg.setCodeStart(codeStart == -1 ? startAddr : codeStart);
		program = prg;
		for (int i = 0; i < prg.getParts().size(); i++) {
			ProgramPart pp = prg.getParts().get(i);
			String start = getHex(pp.getAddress());
			String end = getHex(pp.getEndAddress());
			Logger.log("Part " + i + ": " + start + " - " + end);
		}

		Logger.log(cnt + " lines compiled in: " + (System.nanoTime() - startTime) / 1000000L + "ms");
	}

	/**
	 * Runs the program. This will also compile it if needed (i.e. if it hasn't
	 * been done before), unpause and reset the cpu and execute the program in a
	 * 6502 emulation.
	 */
	@Override
	public void run(CompilerConfig config) {
		if (program == null) {
			compile(config);
		}
		Cpu cpu = machine.getCpu();
		cpu.setPaused(false);
		cpu.reset();
		running = true;
		cpu.execute(program);
		running = false;
	}

	/**
	 * Similar to run(), but the program won't be compiled automatically and the
	 * cpu won't be reset.
	 */
	@Override
	public void start(CompilerConfig config) {
		if (program == null) {
			throw new RuntimeException("Program hasn't been compiled!");
		}
		Cpu cpu = machine.getCpu();
		cpu.setPaused(false);
		running = true;
		cpu.execute(program);
		running = false;
	}

	/**
	 * Gets the machine.
	 * 
	 * @return the machine
	 */
	@Override
	public Machine getMachine() {
		return machine;
	}

	/**
	 * Gets the machine's cpu. This cpu is used to execute machine language
	 * code. It's a 6502 emulation. If you want to add tracing or get more
	 * options/details, this is the place to go.
	 * 
	 * @return
	 */
	@Override
	public Cpu getCpu() {
		return machine.getCpu();
	}

	/**
	 * Returns the RAM's content. The RAM is a representation of 64KB of 8bit
	 * wide memory. However, the returned array is of type int[]. It will
	 * contains values in the range of[0..255] only though.
	 * 
	 * @return the RAM
	 */
	@Override
	public int[] getRam() {
		return machine.getRam();
	}

	/**
	 * Stops a currently running program after the next commands has been
	 * executed.
	 */
	@Override
	public void runStop() {
		machine.getCpu().stop();
	}

	/**
	 * Gets the compiled program. If compile() hasn't been called yet, null will
	 * be returned.
	 * 
	 * @return the program or null
	 */
	public Program getProgram() {
		return program;
	}

	/**
	 * Returns the code line associated to an address.
	 * 
	 * @param addr
	 *            the address
	 * @return the code line or null if none could be found
	 */
	public String getCodeLine(int addr) {
		return addr2code.get(addr);
	}

	/**
	 * Sets a new program. Actually, there's no need to call this method in
	 * normal code.
	 * 
	 * @param program
	 *            the new program
	 */
	public void setProgram(Program program) {
		this.program = program;
	}

	/**
	 * Dumps the compiled program into a kind of monitor view. If the program
	 * hasn't been compiled yet, an empty string will be returned.
	 */
	@Override
	public String toString() {
		if (program == null) {
			return "";
		}
		Program prg = program;
		StringBuilder sb = new StringBuilder();
		int cnt = 1;
		for (ProgramPart part : prg.getParts()) {
			if (sb.length() > 0) {
				sb.append("\n");
			}
			sb.append("Part: " + cnt++);
			int start = part.getAddress();
			int lineIndex = 0;
			for (int i = start; i < start + part.getBytes().length; i++) {
				if (lineIndex < part.getLineAddresses().length && i == part.getLineAddresses()[lineIndex]) {
					lineIndex++;
					sb.append("\n");
					sb.append("." + Integer.toString(i, 16));
					sb.append("\t");
				}
				int val = AssemblyParser.getLowByte(part.getBytes()[i - start]);
				String num = Integer.toString(val, 16);
				if (num.length() == 1) {
					num = "0" + num;
				}
				sb.append(num).append(" ");
			}
		}
		return sb.toString();
	}

	private int[] createAndResetOpas(List<Integer> lineBreaks) {
		int[] opas = new int[lineBreaks.size()];
		int c = 0;
		for (Integer i : lineBreaks) {
			opas[c++] = i;
		}
		lineBreaks.clear();
		return opas;
	}

	private void raiseError(String txt, Throwable t, int addr, int cnt) {
		throw new RuntimeException("Line " + cnt + "\t." + Integer.toHexString(addr) + "\t" + txt, t);
	}

	private void raiseError(String txt, int addr, int cnt) {
		throw new RuntimeException("Line " + cnt + "\t." + Integer.toHexString(addr) + "\t" + txt);
	}

	private String getHex(int inty) {
		String p = Integer.toHexString(inty);
		if (p.length() < 4) {
			p = "000".substring(0, 4 - p.length()) + p;
		}
		return "$" + p;
	}

	private void flagAddress(Set<Integer> used, int start, int endExcl) {
		for (int i = start; i < endExcl; i++) {
			if (used.contains(i)) {
				throw new MemoryException("Overlapping memory addresses @ $" + Integer.toHexString(i));
			}
			used.add(i);
		}
	}

	@Override
	public boolean isRunning() {
		return running;
	}
}
