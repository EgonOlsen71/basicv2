package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


public class Def
  extends AbstractCommand
{
  private String varName = null;
  private String fnName = null;


  public Def()
  {
    super("DEF");
  }


  @Override
  public Type getType()
  {
    return term.getType();
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine machine)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, machine);
    linePart = Parser.removeWhiteSpace(linePart);
    int pos = linePart.indexOf('(');
    int pos2 = linePart.indexOf(')');
    if (pos == -1 || pos2 == -1 || pos > pos2)
    {
      throw new RuntimeException("Syntax error: " + this);
    }
    fnName = linePart.substring(3, pos).toUpperCase(Locale.ENGLISH);
    if (!fnName.startsWith("FN"))
    {
      throw new RuntimeException("Syntax error: " + this);
    }
    fnName = fnName.substring(2);
    if (fnName.length() > 2)
    {
      fnName = fnName.substring(0, 2);
    }
    varName = linePart.substring(pos + 1, pos2).toUpperCase(Locale.ENGLISH);
    if (varName.length() == 0)
    {
      throw new RuntimeException("Syntax error: " + this);
    }
    if (linePart.length() < pos2 + 2 && linePart.charAt(pos2 + 1) != '=')
    {
      throw new RuntimeException("Syntax error: " + this);
    }
    String term = linePart.substring(pos2 + 2);

    StringBuilder sb = new StringBuilder();
    boolean inString = false;
    term = term + " ";
    String modTerm = term.toUpperCase(Locale.ENGLISH).replace("OR", "##").replace("AND", "###").replace("NOT", "###");
    for (int i = 0; i < modTerm.length(); i++)
    {
      char c = modTerm.charAt(i);
      if (c == '"')
      {
        inString = !inString;
      }
      if (!inString)
      {
        if (Character.isAlphabetic(c) || Character.isDigit(c))
        {
          sb.append(c);
        }
        else
        {
          String tmp = sb.toString().toUpperCase(Locale.ENGLISH);
          if (tmp.equals(varName))
          {
            String add="_"+varName + fnName;
            term = term.substring(0, i - varName.length()) + add + term.substring(i);
            modTerm = modTerm.substring(0, i - varName.length()) + add + modTerm.substring(i);
            i+=add.length();
          }
          sb.setLength(0);
        }
      }
    }

    varName = "_" + varName + fnName;
    System.out.println("New DEF-Term: " + term + " - " + fnName + " - " + varName);
    this.term = Parser.getTerm(term, machine, false, true, null);
    machine.add(new Variable(varName, 0f));
    return null;
  }


  @Override
  public Object eval(Machine machine)
  {
    return term.eval(machine);
  }


  public String getVarName()
  {
    return varName;
  }


  @Override
  public ProgramCounter execute(Machine machine)
  {
    machine.setFunction(fnName, this);
    return null;
  }
}
