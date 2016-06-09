package sixtyfour.elements.commands;

import sixtyfour.Memory;
import sixtyfour.Parser;
import sixtyfour.elements.ProgramCounter;
import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;


public class Let
  extends AbstractCommand
{
  private Variable var;


  public Let()
  {
    super("LET");
  }


  public Variable getVar()
  {
    return var;
  }


  public void setVar(Variable var)
  {
    this.var = var;
  }


  @Override
  public Type getType()
  {
    return var.getType();
  }


  @Override
  public void parse(String linePart, int lineCnt, int lineNumber, int linePos, Memory memory)
  {
    super.parse(linePart, lineCnt, lineNumber, linePos, memory);
    var = Parser.getVariable(linePart, memory);
    term = Parser.getTerm(linePart, memory);
    if (!var.getType().equals(term.getType())
        && !(var.getType().equals(Type.REAL) && term.getType().equals(Type.INTEGER)))
    {
      throw new RuntimeException("Type mismatch error: " + linePart);
    }
  }


  @Override
  public ProgramCounter execute(Memory memory)
  {
    var = memory.add(var);
    var.setValue(term.eval(memory));
    return null;
  }

}
