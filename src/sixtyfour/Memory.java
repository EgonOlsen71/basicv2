package sixtyfour;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Stack;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.elements.commands.Command;


public class Memory
{
  private Map<String, Variable> strings = new HashMap<String, Variable>();
  private Map<String, Variable> ints = new HashMap<String, Variable>();
  private Map<String, Variable> reals = new HashMap<String, Variable>();
  private int[] ram = new int[65536];
  private Stack<StackEntry> stack = new Stack<StackEntry>();
  private List<Command> commandList = new ArrayList<Command>();


  public int[] getRam()
  {
    return ram;
  }


  public void push(Command command)
  {
    if (stack.size() > 1000)
    {
      throw new RuntimeException("Out of memory error, stack size exceeds 1000!");
    }
    stack.push(new StackEntry(command));
  }


  public StackEntry peek()
  {
    return stack.peek();
  }


  public StackEntry pop()
  {
    if (stack.isEmpty())
    {
      throw new RuntimeException("Out of memory error, stack is empty!");
    }
    return stack.pop();
  }


  public void reset()
  {
    for (int i = 0; i < ram.length; i++)
    {
      ram[i] = 0;
    }
    for (Variable var : strings.values())
    {
      var.setValue("");
    }
    for (Variable var : ints.values())
    {
      var.setValue(0);
    }
    for (Variable var : reals.values())
    {
      var.setValue(0f);
    }
    stack.clear();
  }


  public Variable add(Variable var)
  {
    Variable ret = getVariable(var.getName());
    if (ret == null)
    {
      if (var.getType().equals(Type.STRING))
      {
        strings.put(var.getName(), var);
      }
      else if (var.getType().equals(Type.INTEGER))
      {
        ints.put(var.getName(), var);
      }
      else if (var.getType().equals(Type.REAL))
      {
        reals.put(var.getName(), var);
      }
      if (var.getType().equals(Type.ARRAY))
      {
        throw new RuntimeException("Not supported yet!");
      }
      ret = var;
    }
    return ret;
  }


  public Variable getVariable(String name)
  {
    if (name == null)
    {
      throw new RuntimeException("Null variable found!");
    }

    name = name.toUpperCase(Locale.ENGLISH);

    char c = name.charAt(name.length() - 1);
    if (c == '$')
    {
      return strings.get(name);
    }
    else if (c == '%')
    {
      return ints.get(name);
    }
    else if (Character.isAlphabetic(c) || Character.isDigit(c))
    {
      return reals.get(name);
    }
    if (c == ']')
    {
      throw new RuntimeException("Not supported yet!");
    }
    return null;
  }


  public void addCommand(Command command)
  {
    commandList.add(command);
  }


  public List<Command> getCommandList()
  {
    return commandList;
  }


  public void setCommandList(List<Command> commandList)
  {
    this.commandList = commandList;
  }
}
