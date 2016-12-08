package com.sixtyfour.parser.assembly;

import java.util.List;

import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.elements.mnemonics.MnemonicList;
import com.sixtyfour.parser.Parser;


/**
 *
 */
public class AssemblyParser
{
  public static Mnemonic getMnemonic(String linePart)
  {
    List<Mnemonic> mnemonics = MnemonicList.getMnemonics();
    Mnemonic mne = null;

    for (Mnemonic mnee : mnemonics)
    {
      if (mnee.isMnemonic(linePart))
      {
        mne = mnee.clone();
        break;
      }
    }

    return mne;
  }


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


  public static LabelAndCode getLabel(String linePart)
  {
    String linePart2 = Parser.replaceStrings(linePart, '_').trim();
    int pos = linePart2.indexOf(" ");
    if (pos != -1)
    {
      return new LabelAndCode(linePart.substring(0, pos), linePart.substring(pos + 1).trim());
    }
    return null;
  }


  public static int getValue(String number, ConstantsContainer ccon)
  {
    number = number.trim();
    if (!number.startsWith("$") && !Character.isDigit(number.charAt(0)))
    {
      ConstantValue cv = ccon.get(number);
      if (cv != null)
      {
        return cv.getValue();
      }
    }
    return getValue(number);
  }


  public static int getValue(String number)
  {
    number = number.trim();
    try
    {
      if (number.startsWith("$"))
      {
        return Integer.parseInt(number.substring(1), 16);
      }
      else
      {
        return Integer.parseInt(number);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException("Invalid number: " + number);
    }
  }


  public static int getLowByte(int val)
  {
    return val % 256;
  }


  public static int getHighByte(int val)
  {
    return val / 256;
  }


  public static ConstantValue getConstant(String linePart)
  {
    String linePart2 = Parser.replaceStrings(linePart, '_').trim();
    int pos = linePart2.indexOf("=");
    if (pos != -1)
    {
      String left = linePart.substring(0, pos).trim();
      String right = linePart.substring(pos + 1).trim();

      int val = getValue(right);

      if (val < 256)
      {
        return new ConstantByte(left, val);
      }
      return new ConstantInt(left, val);
    }
    return null;
  }
}
