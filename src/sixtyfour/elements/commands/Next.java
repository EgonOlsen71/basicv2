package sixtyfour.elements.commands;

import java.util.List;
import java.util.Locale;

import sixtyfour.elements.ProgramCounter;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;


public class Next
  extends AbstractCommand
{
  private String varName = null;
  private For myFor = null;
  private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance


  public Next()
  {
    super("NEXT");
  }


  public String getVarName()
  {
    return varName;
  }


  public void setVarName(String varName)
  {
    this.varName = varName;
  }


  @Override
  public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, memory);
    linePart = linePart.substring(4).toUpperCase(Locale.ENGLISH).trim();

    String ret = null;
    String[] vars = linePart.split(",");

    // Handle the i,j,k...case by returning an artifical, new command and includes only j,k...
    if (vars.length > 1)
    {
      linePart = vars[0];
      ret = "NEXT";
      for (int i = 1; i < vars.length; i++)
      {
        if (i > 1)
        {
          ret += ",";
        }
        ret += vars[i];
      }
    }
    varName = Parser.getVariableName(linePart);

    List<Command> prevs = memory.getCommandList();
    int nextCnt = 0;
    for (int i = prevs.size() - 1; i >= 0; i--)
    {
      Command com = prevs.get(i);
      if (com.isCommand("NEXT"))
      {
        nextCnt++;
      }
      if (com.isCommand("FOR"))
      {
        if (nextCnt == 0)
        {
          String forVar = ((For) com).getVar().getName();
          if (varName.length() == 0)
          {
            varName = forVar;
          }
          else if (!varName.equalsIgnoreCase(forVar))
          {
            throw new RuntimeException("Next without for error: " + this + " " + varName);
          }

          myFor = (For) com;
          myFor.setNext(this);
          return ret;
        }
        else
        {
          nextCnt--;
        }
      }
    }
    throw new RuntimeException("Next without for error: " + this);
  }


  @Override
  public ProgramCounter execute(Machine memory)
  {
    boolean iterate = myFor.next(this, memory);
    if (iterate)
    {
      pc.setLineCnt(myFor.lineCnt);
      pc.setLinePos(myFor.linePos);
      return pc;
    }
    return null;
  }

}
