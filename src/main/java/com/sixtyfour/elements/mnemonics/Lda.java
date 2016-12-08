package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;


public class Lda
  extends AbstractMnemonic
{
  public Lda()
  {
    super("LDA");
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
      ram[addr++] = 0xA9;
      addr = store(ram, pars.getValue(), addr);
    }
    else
    {
      if (!pars.isIndirect())
      {
        if (pars.isX())
        {
          // ,X
          if (pars.isZeropage())
          {
            // Direct/Zeropage
            ram[addr++] = 0xB5;
            ram[addr++] = AssemblyParser.getLowByte(pars.getAddr());
          }
          else
          {
            // Direct/Memory
            ram[addr++] = 0xBD;
            addr = store(ram, pars.getAddr(), addr);
          }
        }
        else if (pars.isY())
        {
          // ,Y
          if (pars.isZeropage())
          {
            throw new RuntimeException("Address mode not supported: " + linePart);
          }
          else
          {
            // Direct/Memory
            ram[addr++] = 0xB9;
            addr = store(ram, pars.getAddr(), addr);
          }
        }
        else
        {
          // Direct
          if (pars.isZeropage())
          {
            // Direct/Zeropage
            ram[addr++] = 0xA5;
            ram[addr++] = AssemblyParser.getLowByte(pars.getAddr());
          }
          else
          {
            // Direct/Memory
            ram[addr++] = 0xAD;
            addr = store(ram, pars.getAddr(), addr);
          }
        }
      }
      else
      {
        // Indirect
        if (!pars.isZeropage())
        {
          throw new RuntimeException("Address mode not supported: " + linePart);
        }
        if (pars.isX())
        {
          // ,X
          ram[addr++] = 0xA1;
          ram[addr++] = AssemblyParser.getLowByte(pars.getAddr());
        }
        else if (pars.isY())
        {
          // ,Y
          ram[addr++] = 0xB1;
          ram[addr++] = AssemblyParser.getLowByte(pars.getAddr());
        }
        else
        {
          throw new RuntimeException("Address mode not supported: " + linePart);
        }
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
