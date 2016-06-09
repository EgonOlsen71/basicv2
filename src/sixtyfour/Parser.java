package sixtyfour;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import sixtyfour.elements.Line;
import sixtyfour.elements.commands.Command;


public class Parser
{

  private String[] code = null;
  private Map<Integer, Line> lines = new HashMap<Integer, Line>();
  

  public Parser(String[] code)
  {
    this.code = Arrays.copyOf(code, code.length);
  }


  public void parse()
  {
    Memory memory=new Memory();
    for (String line : code)
    {
      Line cl = Lexer.getLine(line);
      if (lines.containsKey(cl.getNumber()))
      {
        throw new RuntimeException("Duplicate line number in: " + line);
      }
      lines.put(cl.getNumber(), cl);
      String[] parts = Lexer.getParts(cl, memory);

      for (String part : parts)
      {
        Command command = Lexer.getCommand(part);
        cl.addCommand(command);
      }
    }
  }

}
