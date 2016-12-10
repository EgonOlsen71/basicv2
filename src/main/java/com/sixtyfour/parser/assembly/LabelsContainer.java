package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.elements.mnemonics.MnemonicList;
import com.sixtyfour.system.Machine;

public class LabelsContainer {
	private Map<String, Integer> labels2Addr = new HashMap<String, Integer>();
	private Map<Integer, DelayedLabel> delayed = new HashMap<Integer, DelayedLabel>();
	private Machine machine = null;

	public LabelsContainer(Machine machine) {
		this.machine = machine;
	}

	public void put(String label, int value) {
		labels2Addr.put(label, value);

		// Apply forward-labels
		List<Integer> toRemove = new ArrayList<Integer>();
		for (Entry<Integer, DelayedLabel> entry : delayed.entrySet()) {
			DelayedLabel dl = entry.getValue();
			if (label.equals(dl.getLabel())) {
				toRemove.add(entry.getKey());
				int targetAddr = entry.getKey();
				int[] ram = machine.getRam();

				int opcode = ram[targetAddr];
				if (MnemonicList.getConditonalBranches().contains(opcode)) {
					// System.out.println("Applied conditional delayed Label: "+entry.getValue());
					int offset = value - (targetAddr + 2);
					if (offset <= 127 && offset >= -128) {
						ram[++targetAddr] = AssemblyParser.getLowByte(offset);
					} else {
						throw new RuntimeException("Destination address out of range: " + value + "/" + targetAddr + "/" + offset);
					}
				} else {
					// System.out.println("Applied delayed Label: "+entry.getValue());
					if (dl.isLow()) {
						ram[++targetAddr] = AssemblyParser.getLowByte(value);
					} else if (dl.isHigh()) {
						ram[++targetAddr] = AssemblyParser.getHighByte(value);
					} else {
						ram[++targetAddr] = AssemblyParser.getLowByte(value);
						ram[++targetAddr] = AssemblyParser.getHighByte(value);
					}
				}
			}
		}

		for (Integer tr : toRemove) {
			delayed.remove(tr);
		}
	}

	public boolean hasDelayedLabels() {
		return !delayed.isEmpty();
	}

	public String getFirstDelayedLabel() {
		if (!delayed.isEmpty()) {
			return delayed.entrySet().iterator().next().getValue().getLabel();
		}
		return null;
	}

	public Integer get(String name) {
		return labels2Addr.get(name);
	}

	public void addDelayedLabelRef(int addr, String label, boolean low, boolean high) {
		// System.out.println("Adding delayed Label: "+label+" @"+addr);
		delayed.put(addr, new DelayedLabel(label, low, high));
	}

}
