package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.elements.mnemonics.MnemonicList;
import com.sixtyfour.system.Machine;


/**
 * A container for labels that occur in an assembler listing. This class manages known labels as well as such labels
 * that the code refers to but that haven't been defined yet. Adding such a delayed label will result in its value to be
 * applied to the compiled code.
 * 
 * @author EgonOlsen
 *
 */
public class LabelsContainer
{
  private Map<String, Integer> labels2Addr = new HashMap<String, Integer>();
  private Map<Integer, DelayedLabel> delayed = new HashMap<Integer, DelayedLabel>();
  private Machine machine = null;


  /**
   * Creates a new LabelsContainer for a machine.
   * 
   * @param machine
   *          the machine
   */
  public LabelsContainer(Machine machine)
  {
    this.machine = machine;
  }


  /**
   * Put a new label with an address into the container.
   * 
   * @param label
   *          the label
   * @param value
   *          its address/value
   */
  public void put(String label, int value)
  {
    labels2Addr.put(label, value);

    // Apply forward-labels
    List<Integer> toRemove = new ArrayList<Integer>();
    for (Entry<Integer, DelayedLabel> entry : delayed.entrySet())
    {
      DelayedLabel dl = entry.getValue();
      if (label.equals(dl.getLabel()))
      {
        toRemove.add(entry.getKey());
        int targetAddr = entry.getKey();
        int[] ram = machine.getRam();

        int opcode = ram[targetAddr];
        if (MnemonicList.getConditonalBranches().contains(opcode))
        {
          // System.out.println("Applied conditional delayed Label: "+entry.getValue());
          int offset = value - (targetAddr + 2);
          if (offset <= 127 && offset >= -128)
          {
            ram[++targetAddr] = AssemblyParser.getLowByte(offset);
          }
          else
          {
            throw new RuntimeException("Destination address out of range: " + value + "/" + targetAddr + "/" + offset);
          }
        }
        else
        {
          // System.out.println("Applied delayed Label: "+entry.getValue());
          if (dl.isLow())
          {
            ram[++targetAddr] = AssemblyParser.getLowByte(value);
          }
          else if (dl.isHigh())
          {
            ram[++targetAddr] = AssemblyParser.getHighByte(value);
          }
          else
          {
            ram[++targetAddr] = AssemblyParser.getLowByte(value);
            ram[++targetAddr] = AssemblyParser.getHighByte(value);
          }
        }
      }
    }

    for (Integer tr : toRemove)
    {
      delayed.remove(tr);
    }
  }


  /**
   * Returns true, if the container still has delayed labels that haven't been applied yet.
   * 
   * @return has it?
   */
  public boolean hasDelayedLabels()
  {
    return !delayed.isEmpty();
  }


  /**
   * Returns the name of the first delayed label or null if there is none.
   * 
   * @return the name or null
   */
  public String getFirstDelayedLabel()
  {
    if (!delayed.isEmpty())
    {
      return delayed.entrySet().iterator().next().getValue().getLabel();
    }
    return null;
  }


  /**
   * Gets the address/value for a label name. If there is no such label, null will be returned.
   * 
   * @param name
   *          the name of the label
   * @return the address or null
   */
  public Integer get(String name)
  {
    return labels2Addr.get(name);
  }


  /**
   * Adds a reference to a label that isn't yet known to the container. Such labels' addresses/values will automatically
   * applied to the code by the container once the label gets known.
   * 
   * @param addr
   *          the address of reference to the label
   * @param label
   *          the label's name
   * @param low
   *          low byte only?
   * @param high
   *          high byte only?
   */
  public void addDelayedLabelRef(int addr, String label, boolean low, boolean high)
  {
    // System.out.println("Adding delayed Label: "+label+" @"+addr);
    delayed.put(addr, new DelayedLabel(label, low, high));
  }

}
