package sixtyfour.elements.commands;

import java.util.List;
import java.util.Locale;

import sixtyfour.Memory;
import sixtyfour.Parser;
import sixtyfour.elements.ProgramCounter;


public class Next
  extends AbstractCommand
{
  private String varName = null;
  private For myFor = null;


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
  public void parse(String linePart, int lineCnt, int lineNumber, int linePos, Memory memory)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, memory);
    linePart = linePart.substring(4).toUpperCase(Locale.ENGLISH).trim();
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
          return;
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
  public ProgramCounter execute(Memory memory)
  {
    boolean iterate = myFor.next(this, memory);
    if (iterate)
    {
      return new ProgramCounter(myFor.lineCnt, myFor.linePos);
    }
    return null;
  }

}
