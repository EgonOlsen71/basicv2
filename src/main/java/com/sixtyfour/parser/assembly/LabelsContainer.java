package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.system.Machine;


public class LabelsContainer
{
  private Map<String, Integer> labels2Addr = new HashMap<String, Integer>();
  private Map<Integer, String> delayed = new HashMap<Integer, String>();
  private Machine machine = null;


  public LabelsContainer(Machine machine)
  {
    this.machine = machine;
  }


  public void put(String label, int value)
  {
    labels2Addr.put(label, value);
    
    // Apply forward-labels
    List<Integer> toRemove = new ArrayList<Integer>();
    for (Entry<Integer, String> entry : delayed.entrySet())
    {
      if (label.equals(entry.getValue()))
      {
        toRemove.add(entry.getKey());
        int targetAddr = entry.getKey();
        int[] ram = machine.getRam();
        ram[targetAddr++] = AssemblyParser.getLowByte(value);
        ram[targetAddr] = AssemblyParser.getHighByte(value);
      }
    }

    for (Integer tr : toRemove)
    {
      delayed.remove(tr);
    }
  }


  public int get(String name)
  {
    return labels2Addr.get(name);
  }


  public void addDelayedLabelRef(int addr, String label)
  {
    delayed.put(addr, label);
  }

}
