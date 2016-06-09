package sixtyfour.elements.commands;

import sixtyfour.Memory;
import sixtyfour.Parser;
import sixtyfour.elements.ProgramCounter;
import sixtyfour.elements.Type;


public class Print
  extends AbstractCommand
{

  public Print()
  {
    super("PRINT");
  }


  @Override
  public Type getType()
  {
    return term.getType();
  }


  @Override
  public void parse(String linePart, int lineCnt, int lineNumber, int linePos, Memory memory)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, memory);
    term = Parser.getTerm(this, linePart, memory);
  }


  @Override
  public ProgramCounter execute(Memory memory)
  {
    System.out.println(term.eval(memory));
    return null;
  }

}
