package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.elements.mnemonics.MnemonicList;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;


/**
 * A parser for parsing assembler programs.
 *
 * @author EgonOlsen
 */
public class AssemblyParser
{
  /**
   * Gets the mnemonic for a line or null if there is no such thing.
   * 
   * @param linePart
   *          the line
   * @return the mnemonic or null
   */
  public static Mnemonic getMnemonic(String linePart)
  {
    if (linePart.startsWith("."))
    {
      return null;
    }

    List<Mnemonic> mnemonics = MnemonicList.getMnemonics();
    Mnemonic mne = null;

    for (Mnemonic mnee : mnemonics)
    {
      if (mnee.isMnemonic(linePart))
      {
        mne = mnee;
        break;
      }
    }

    return mne;
  }


  /**
   * Removes comments from a line. Comments are marked as ";"
   * 
   * @param linePart
   *          the line
   * @return the line without the comments
   */
  public static String truncateComments(String linePart)
  {
    StringBuilder sb = new StringBuilder();
    boolean inString = false;
    for (int i = 0; i < linePart.length(); i++)
    {
      char c = linePart.charAt(i);
      if (c == '"')
      {
        inString = !inString;
      }
      if (!inString && c == ';')
      {
        return sb.toString();
      }
      sb.append(c);
    }
    return sb.toString().trim();
  }


  /**
   * Gets the label (and code) of a line. If a line contains a label and a mnemonic, getMnemonic() above will return
   * null. This method will return the label and rest of the line, so that the rest can be used to call getMnemonic()
   * again.
   * 
   * @param linePart
   *          the line
   * @return the label and code or null if there is no such thing
   */
  public static LabelAndCode getLabel(String linePart)
  {
    if (linePart.startsWith("."))
    {
      return null;
    }
    String linePart2 = Parser.replaceStrings(linePart, '_').trim();
    int pos = linePart2.indexOf(" ");
    if (pos != -1)
    {
      return new LabelAndCode(linePart.substring(0, pos).replace(":", ""), linePart.substring(pos + 1).trim());
    }
    return null;
  }


  /**
   * Returns the value of an expression in the code. If the expression can't be evaluated to a number, an exeception
   * will occur. If the number is actually a label that hasn't been defined yet, the current address will be returned
   * instead and an information will be added to the LabelsContainer that indicates that additional work has to be done
   * once the label is known later in the parsing process.
   * 
   * @param number
   *          the number
   * @param addr
   *          the current address
   * @param ccon
   *          a container for constants
   * @param lcon
   *          a container for labels
   * @param low
   *          do we want the low byte only?
   * @param high
   *          do we want the high byte only?
   * @return the number
   */
  public static int getValue(String number, int addr, ConstantsContainer ccon, LabelsContainer lcon, boolean low,
      boolean high)
  {
    number = number.trim();
    if (!number.startsWith("$") && !number.startsWith("%") && !Character.isDigit(number.charAt(0)))
    {
      ConstantValue cv = ccon.get(number);
      if (cv != null)
      {
        return cv.getValue();
      }

      if (number.contains("*"))
      {
        number = number.replace("*", String.valueOf(addr));
        return getConstantParsed("", number, ccon).getValue();
      }
      else
      {
        Integer labelAddr = lcon.get(number);
        if (labelAddr != null)
        {
          return labelAddr;
        }
      }

      // No constant and no label found...might be a delayed label...
      lcon.addDelayedLabelRef(addr, number, low, high);
      return addr;

    }

    return getValue(number);
  }


  /**
   * Returns the low byte of a value.
   * 
   * @param val
   *          the value
   * @return the low byte
   */
  public static int getLowByte(int val)
  {
    return val % 256;
  }


  /**
   * Returns the high byte of a value.
   * 
   * @param val
   *          the value
   * @return the high byte
   */
  public static int getHighByte(int val)
  {
    return val / 256;
  }


  /**
   * Returns an array containing the binary data defined in the code. Binary data can be defined by either .text or
   * .byte
   * 
   * @param addr
   *          the current address
   * @param data
   *          the data to be parsed
   * @return the actual data
   */
  public static int[] getBinaryData(int addr, String data)
  {
    data = data.trim();
    List<Integer> ram = new ArrayList<Integer>();
    String datupper = VarUtils.toUpper(data);
    if (datupper.startsWith(".TEXT"))
    {
      data = data.substring(5).trim();
      if (data.startsWith("\"") && data.endsWith("\""))
      {
        data = data.substring(1, data.length() - 1);
        for (int i = 0; i < data.length(); i++)
        {
          int val = getLowByte((int) data.charAt(i));
          ram.add(val);
        }
      }
      else
      {
        throw new RuntimeException("Invalid text data: " + data);
      }
    }
    else if (datupper.startsWith(".BYTE"))
    {
      String[] parts = data.substring(5).trim().split(" ");
      for (String part : parts)
      {
        int val = getLowByte(getValue(part));
        ram.add(val);
      }
    }
    else
    {
      throw new RuntimeException("Invalid data definition: " + data);
    }

    int[] res = new int[ram.size()];
    int cnt = 0;
    for (Integer rv : ram)
    {
      res[cnt++] = rv;
    }
    return res;
  }


  /**
   * Returns the constant that is defined in the given line. It's possible to do calculations in the right hand side of
   * the assignment as well.
   * 
   * @param linePart
   *          the constant definition
   * @param ccon
   *          a container for constants
   * @return the new constant or null if there is none
   */
  public static ConstantValue getConstant(String linePart, ConstantsContainer ccon)
  {
    String linePart2 = Parser.replaceStrings(linePart, '_').trim();
    int pos = linePart2.indexOf("=");
    if (pos != -1)
    {
      String left = linePart.substring(0, pos).trim();
      String right = linePart.substring(pos + 1).trim();

      if (ccon != null && (right.contains("+") || right.contains("-") || right.contains("*") || right.contains("/")))
      {
        return getConstantParsed(left, right, ccon);
      }

      int val = getValue(right);

      if (val < 256)
      {
        return new ConstantByte(left, val);
      }
      return new ConstantInt(left, val);
    }
    return null;
  }


  /**
   * Uses the Basic interpreter to parse the right hand side of a constant's assignment.
   * 
   * @param left
   *          the left hand side of the assignment
   * @param right
   *          the right hand side of the assignment
   * @param ccon
   *          a container for constants
   * @return the new constant
   */
  public static ConstantValue getConstantParsed(String left, String right, ConstantsContainer ccon)
  {
    // Uses the Basic parser's term parsing method to evaluate the constant's assignment.
    // Due to limitations in Basic V2, we have to convert the variable names before.
    Map<String, String> names2vars = new HashMap<String, String>();
    StringBuilder sb = new StringBuilder();
    StringBuilder res = new StringBuilder();
    boolean inName = false;
    char varName = 'A';
    right += ";";
    for (int i = 0; i < right.length(); i++)
    {
      char c = right.charAt(i);
      boolean ended = false;
      if (Character.isLetter(c))
      {
        inName = true;
      }
      if (inName && Character.isLetterOrDigit(c) || c == '_')
      {
        sb.append(c);
      }
      else
      {
        ended = true;
      }

      if (ended || i == right.length() - 1)
      {
        inName = false;
        if (sb.length() > 0)
        {
          String name = sb.toString();
          sb.setLength(0);
          String var = names2vars.get(name);
          if (var == null)
          {
            var = "" + (varName++);
            names2vars.put(name, var);
          }
          res.append(var);
        }
        if (c != ';')
        {
          res.append(c);
        }
      }

      if (c == ';')
      {
        break;
      }
    }

    Machine machine = new Machine();

    for (String name : names2vars.keySet())
    {
      ConstantValue cv = ccon.get(name);
      if (cv == null)
      {
        throw new RuntimeException("Undefined constant: " + name);
      }
      machine.add(new Variable(names2vars.get(name), ccon.get(name).getValue()));
    }
    Term ressy = Parser.getTerm(res.toString(), machine, true, true);
    int resultValue = ((Number) ressy.eval(machine)).intValue();

    if (resultValue < 256)
    {
      return new ConstantByte(left, resultValue);
    }
    return new ConstantInt(left, resultValue);
  }


  private static int getValue(String number)
  {
    number = number.trim();
    int val = 0;
    try
    {
      if (number.startsWith("$"))
      {
        val = Integer.parseInt(number.substring(1), 16);
      }
      else
      {
        if (number.startsWith("%"))
        {
          val = Integer.parseInt(number.substring(1), 2);
        }
        else
        {
          val = Integer.parseInt(number);
        }
      }

      if (val < -32768 || val > 65535)
      {
        throw new RuntimeException("Value out of range: " + val);
      }

      return val;
    }
    catch (Exception e)
    {
      throw new RuntimeException("Invalid number: " + number);
    }
  }
}
