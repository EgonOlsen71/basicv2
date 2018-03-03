package com.sixtyfour.test.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Assembler;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;

/**
 * @author EgonOlsen
 * 
 */
public class JsrProfiler implements CpuTracer {

	private final Assembler assy;
	private LinkedList<ProfilerData> callStack = new LinkedList<ProfilerData>();
	private Map<String, ProfilerData> knownCalls = new HashMap<String, ProfilerData>();

	public JsrProfiler(Assembler assy) {
		this.assy = assy;
	}

	public List<ProfilerData> getCollectedData() {
		List<ProfilerData> profs = new ArrayList<ProfilerData>(knownCalls.values());
		Collections.sort(profs);
		return profs;
	}

	@Override
	public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc) {
		String line = assy.getCodeLine(opcodePc);

		ProfilerData pd = null;
		if (line != null && line.trim().startsWith("JSR")) {
			if (line.contains(";")) {
				line = line.substring(0, line.indexOf(";"));
			}
			line = line.trim();
			pd = knownCalls.get(line);
			if (pd == null) {
				pd = new ProfilerData();
				pd.setCommand(line);
				knownCalls.put(line, pd);
			}
			pd.called(cpu.getClockTicks());
		}

		if (opcode == 0x20) {
			callStack.push(pd);
		}
		if (opcode == 0x60) {
			if (!callStack.isEmpty()) {
				pd = callStack.pop();
				if (pd != null) {
					pd.returned(cpu.getClockTicks());
				}
			}
		}
	}

	@Override
	public void exception(Cpu cpu, int opcode, int opcodePc, int newPc) {
		// TODO Auto-generated method stub

	}

}
