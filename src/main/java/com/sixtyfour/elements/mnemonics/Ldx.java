package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;


public class Ldx
  extends AbstractMnemonic
{
  public Ldx()
  {
    super("LDX");
  }


  @Override
  public int parse(String linePart, int addr, Machine machine, ConstantsContainer ccon, LabelsContainer lcon)
  {
    linePart = linePart.trim().substring(3);
    Parameters pars = this.parseParameters(linePart, ccon);

    int[] ram = machine.getRam();
    if (pars.getValue() != null)
    {
      // Value
      ram[addr++] = 0xA2;
      addr = store(ram, pars.getValue(), addr);
    }
    else
    {
      if (!pars.isIndirect())
      {
        if (pars.isX())
        {
          // ,X
          throw new RuntimeException("Address mode not supported: " + linePart);
        }
        else if (pars.isY())
        {
          // ,Y
          if (pars.isZeropage())
          {
            // Direct/Zeropage
            ram[addr++] = 0xB6;
            ram[addr++] = AssemblyParser.getLowByte(pars.getAddr());
          }
          else
          {
            // Direct/Memory
            ram[addr++] = 0xBE;
            addr = store(ram, pars.getAddr(), addr);
          }
        }
        else
        {
          // Direct
          if (pars.isZeropage())
          {
            // Direct/Zeropage
            ram[addr++] = 0xA6;
            ram[addr++] = AssemblyParser.getLowByte(pars.getAddr());
          }
          else
          {
            // Direct/Memory
            ram[addr++] = 0xAE;
            addr = store(ram, pars.getAddr(), addr);
          }
        }
      }
      else
      {
        throw new RuntimeException("Address mode not supported: " + linePart);
      }
    }

    return addr;
  }


  private int store(int[] ram, int value, int addr)
  {
    ram[addr++] = AssemblyParser.getLowByte(value);
    ram[addr++] = AssemblyParser.getHighByte(value);
    return addr;
  }

}
