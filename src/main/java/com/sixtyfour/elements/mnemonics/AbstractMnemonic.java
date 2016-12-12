package com.sixtyfour.elements.mnemonics;

import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.parser.assembly.Parameters;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;


/**
 * Abstract implementation for mnemonics. 
 * 
 * @author EgonOlsen
 *
 */
public abstract class AbstractMnemonic
  implements Mnemonic
{
  private String name;

  protected int[] opcodes = null;


  /**
   * Creates a new instance for a mnemonic of the given name. The list of opcodes has to have a 
   * length of 12 and has to contain opcodes for all the possible addressing modes that the mnemonic
   * can use. Those that it can't use have to be 0.
   * 
   * @param name the name
   * @param opcodes the list of opcodes
   */
  public AbstractMnemonic(String name, int[] opcodes)
  {
    this.name = name;
    this.opcodes = opcodes;
    if (opcodes.length != 12)
    {
      throw new RuntimeException("Invalid opcode list: " + opcodes.length);
    }
  }


  @Override
  public int parse(String linePart, int addr, Machine machine, ConstantsContainer ccon, LabelsContainer lcon)
  {
    linePart = linePart.trim().substring(3);
    Parameters pars = this.parseParameters(linePart, addr, ccon, lcon);
    if (opcodes[0] == 0 && pars == null)
    {
      raiseSyntaxError(linePart);
    }

    if (opcodes[0] != 0 && pars != null && isSingle())
    {
      raiseSyntaxError(linePart);
    }

    int[] ram = machine.getRam();

    if (pars == null)
    {
      return store(ram, opcodes[0], addr);
    }

    if (pars.getValue() != null)
    {
      // Value
      addr = storeByte(ram, opcodes[1], pars.getValue(), addr);
    }
    else
    {
      if (!pars.isIndirect())
      {
        if (pars.isX())
        {
          // ,X
          if (pars.isZeropage() && opcodes[6] != 0)
          {
            // Direct/Zeropage
            addr = storeByte(ram, opcodes[6], pars.getAddr(), addr);
          }
          else
          {
            // Direct/Memory
            addr = store(ram, opcodes[3], pars.getAddr(), addr);
          }
        }
        else if (pars.isY())
        {
          // ,Y
          if (pars.isZeropage() && opcodes[7] != 0)
          {
            addr = storeByte(ram, opcodes[7], pars.getAddr(), addr);
          }
          else
          {
            // Direct/Memory
            addr = store(ram, opcodes[4], pars.getAddr(), addr);
          }
        }
        else
        {
          // Direct
          if (pars.isZeropage() && opcodes[5] != 0)
          {
            // Direct/Zeropage
            addr = storeByte(ram, opcodes[5], pars.getAddr(), addr);
          }
          else
          {
            // Direct/Memory
            if (!this.isRelative())
            {
              addr = store(ram, opcodes[2], pars.getAddr(), addr);
            }
            else
            {
              int offset = pars.getAddr() - (addr + 2);
              if (offset <= 127 && offset >= -128)
              {
                addr = storeByte(ram, opcodes[11], offset, addr);
              }
              else
              {
                throw new RuntimeException(
                    "Destination address out of range: " + pars.getAddr() + "/" + addr + "/" + offset);
              }
            }
          }
        }
      }
      else
      {
        // Indirect
        if (!pars.isZeropage() && (pars.isX() || pars.isY()))
        {
          raiseAddrError(linePart);
        }
        if (pars.isX())
        {
          // ,X
          addr = storeByte(ram, opcodes[9], pars.getAddr(), addr);
        }
        else if (pars.isY())
        {
          // ,Y
          addr = storeByte(ram, opcodes[10], pars.getAddr(), addr);
        }
        else
        {
          // ...
          addr = store(ram, opcodes[8], pars.getAddr(), addr);
        }
      }
    }

    return addr;
  }


  @Override
  public boolean isMnemonic(String linePart)
  {
    boolean mne = VarUtils.toUpper(linePart.trim()).startsWith(name);
    if (mne && linePart.length() > name.length())
    {
      char c = linePart.charAt(name.length());
      if (Character.isLetter(c))
      {
        return false;
      }
    }
    return mne;
  }


  @Override
  public AbstractMnemonic clone()
  {
    try
    {
      AbstractMnemonic clone = this.getClass().newInstance();
      clone.name = name;
      return clone;
    }
    catch (Exception e)
    {
      throw new RuntimeException("Unable to instantiate mnemonic: " + name);
    }
  }


  @Override
  public boolean isRelative()
  {
    return false;
  }


  @Override
  public boolean isSingle()
  {
    return false;
  }


  @Override
  public boolean isJump()
  {
    return false;
  }


  @Override
  public String toString()
  {
    return name;
  }


  protected void raiseAddrError(String linePart)
  {
    throw new RuntimeException("Address mode not supported: " + linePart);
  }


  protected void raiseSyntaxError(String linePart)
  {
    throw new RuntimeException("Syntax error: " + linePart);
  }


  protected int storeByte(int[] ram, int opcode, int value, int addr)
  {
    checkOpcode(opcode);
    ram[addr++] = opcode(opcode);
    ram[addr++] = AssemblyParser.getLowByte(value);
    return addr;
  }


  private int opcode(int opcode)
  {
    return opcode == -9999 ? 0 : opcode;
  }


  protected int store(int[] ram, int opcode, int value, int addr)
  {
    checkOpcode(opcode);
    ram[addr++] = opcode(opcode);
    ram[addr++] = AssemblyParser.getLowByte(value);
    ram[addr++] = AssemblyParser.getHighByte(value);
    return addr;
  }


  protected int store(int[] ram, int opcode, int addr)
  {
    checkOpcode(opcode);
    ram[addr++] = opcode(opcode);
    return addr;
  }


  protected Parameters parseParameters(String pars, int addr, ConstantsContainer ccon, LabelsContainer lcon)
  {
    pars = Parser.removeWhiteSpace(pars);

    if (pars.isEmpty())
    {
      return null;
    }

    boolean isValue = pars.startsWith("#");
    boolean isIndirect = pars.startsWith("(");
    int indexedPos = pars.indexOf(',');
    boolean indexed = indexedPos != -1;
    pars = pars.replace("#", "");

    boolean lowByte = pars.startsWith("<");
    boolean highByte = pars.startsWith(">");

    pars = pars.replace("<", "").replace(">", "");

    String part1 = indexed ? pars.substring(0, indexedPos) : pars;
    String part2 = indexed ? VarUtils.toUpper(pars.substring(indexedPos + 1)) : "";

    if (isIndirect && !((part2.isEmpty() && part1.endsWith(")")) || (part2.endsWith(")") && part2.startsWith("X"))
        || (part1.endsWith(")") && part2.startsWith("Y"))))
    {
      throw new RuntimeException("Invalid indirect addressing: " + pars);
    }

    part1 = removeBrackets(part1);
    part2 = removeBrackets(part2);

    Parameters par = new Parameters();
    par.setX(part2.startsWith("X"));
    par.setY(part2.startsWith("Y"));
    par.setIndirect(isIndirect);

    int val = AssemblyParser.getValue(part1, addr, ccon, lcon, lowByte, highByte);
    if (lowByte)
    {
      val = AssemblyParser.getLowByte(val);
    }
    else if (highByte)
    {
      val = AssemblyParser.getHighByte(val);
    }

    if (isValue)
    {
      par.setValue(val);
    }
    else
    {
      par.setAddr(val);
      if (val < 256)
      {
        par.setZeropage(true);
      }
    }

    return par;
  }


  protected void raiseOpcodeError(int opcode)
  {
    throw new RuntimeException("Address mode not supported: " + opcode);

  }


  private String removeBrackets(String part1)
  {
    return part1.replace("(", "").replace(")", "");
  }


  private void checkOpcode(int opcode)
  {
    if (opcode == 0)
    {
      raiseOpcodeError(opcode);
    }
  }

}
