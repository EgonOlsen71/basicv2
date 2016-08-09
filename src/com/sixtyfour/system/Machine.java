package com.sixtyfour.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.For;
import com.sixtyfour.elements.systemvars.Pie;
import com.sixtyfour.elements.systemvars.Status;
import com.sixtyfour.elements.systemvars.Time;
import com.sixtyfour.elements.systemvars.TimeDate;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.plugins.InputProvider;
import com.sixtyfour.plugins.MemoryListener;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.plugins.impl.ConsoleInputProvider;
import com.sixtyfour.plugins.impl.ConsoleOutputChannel;
import com.sixtyfour.plugins.impl.MemoryDeviceProvider;
import com.sixtyfour.plugins.impl.NullMemoryListener;
import com.sixtyfour.plugins.impl.NullSystemCallListener;
import com.sixtyfour.util.VarUtils;


/**
 * The Class Machine.
 */
public class Machine
{

  /** The vars. */
  private Map<String, Variable> vars = new HashMap<String, Variable>();

  /** The ram. */
  private int[] ram = new int[65536];

  /** The stack. */
  private Stack<StackEntry> stack = new Stack<StackEntry>();

  /** The command list. */
  private List<Command> commandList = new ArrayList<Command>();

  /** The current command. */
  private Command currentCommand = null;

  /** The current operator. */
  private Operator currentOperator = null;

  /** The functions. */
  private Map<String, Command> functions = new HashMap<String, Command>();

  /** The data. */
  private DataStore data = new DataStore();

  /** The output channel. */
  private OutputChannel outputChannel = null;

  /** The input provider. */
  private InputProvider inputProvider = null;

  /** The memory listener. */
  private MemoryListener memoryListener = null;

  /** The system call listener. */
  private SystemCallListener systemCallListener = null;

  /** The device provider. */
  private DeviceProvider deviceProvider = null;


  /**
   * Instantiates a new machine.
   */
  public Machine()
  {
    inputProvider = new ConsoleInputProvider();
    outputChannel = new ConsoleOutputChannel();
    memoryListener = new NullMemoryListener();
    deviceProvider = new MemoryDeviceProvider(outputChannel);
    setSystemCallListener(new NullSystemCallListener());
    addDefaults();
  }


  /**
   * Sets the function.
   * 
   * @param name
   *          the name
   * @param function
   *          the function
   */
  public void setFunction(String name, Command function)
  {
    functions.put(name, function);
  }


  /**
   * Gets the function.
   * 
   * @param name
   *          the name
   * @return the function
   */
  public Command getFunction(String name)
  {
    return functions.get(name);
  }


  /**
   * Gets the ram.
   * 
   * @return the ram
   */
  public int[] getRam()
  {
    return ram;
  }


  /**
   * Push.
   * 
   * @param command
   *          the command
   */
  public void push(Command command)
  {
    if (stack.size() > 10000)
    {
      throw new RuntimeException("Out of memory error, stack size exceeds 10000!");
    }
    stack.push(new StackEntry(command));
  }


  /**
   * Push for.
   * 
   * @param fory
   *          the fory
   */
  public void pushFor(For fory)
  {
    if (stack.size() > 10000)
    {
      throw new RuntimeException("Out of memory error, stack size exceeds 10000!");
    }
    stack.push(new StackEntry(fory));
  }


  /**
   * Pop for.
   * 
   * @param fory
   *          the fory
   * @return the for
   */
  public For popFor(For fory)
  {
    List<StackEntry> toRemove = new ArrayList<StackEntry>();
    for (int i = stack.size() - 1; i >= 0; i--)
    {
      StackEntry entry = stack.get(i);
      if (entry.getCommand() == fory)
      {
        for (int p = stack.size() - 1; p >= i; p--)
        {
          entry = stack.get(i);
          if (entry.isFor())
          {
            toRemove.add(entry);
          }
        }
        stack.removeAll(toRemove);
        return (For) entry.getCommand();
      }
    }
    return null;
  }


  /**
   * Peek for.
   * 
   * @param varName
   *          the var name
   * @return the for
   */
  public For peekFor(String varName)
  {
    for (int i = stack.size() - 1; i >= 0; i--)
    {
      StackEntry entry = stack.get(i);
      if (entry.isFor() && (varName == null || varName.equalsIgnoreCase(((For) entry.getCommand()).getVar().getName())))
      {
        return (For) entry.getCommand();
      }
    }
    return null;
  }


  /**
   * Gets the caller.
   * 
   * @return the caller
   */
  public StackEntry getCaller()
  {
    for (int i = stack.size() - 1; i >= 0; i--)
    {
      StackEntry entry = stack.get(i);
      if (entry.isSubroutineCall())
      {
        for (int p = 0; p < stack.size() - i; p++)
        {
          stack.pop();
        }
        return entry;
      }
    }
    return null;
  }


  /**
   * Peek.
   * 
   * @return the stack entry
   */
  public StackEntry peek()
  {
    return stack.peek();
  }


  /**
   * Pop.
   * 
   * @return the stack entry
   */
  public StackEntry pop()
  {
    if (stack.isEmpty())
    {
      throw new RuntimeException("Out of memory error, stack is empty!");
    }
    return stack.pop();
  }


  /**
   * Reset memory.
   */
  public void resetMemory()
  {
    for (int i = 0; i < ram.length; i++)
    {
      ram[i] = 0;
    }
    clearVars();
  }


  /**
   * Clear vars.
   */
  public void clearVars()
  {
    for (Variable var : vars.values())
    {
      var.clear();
    }
    addDefaults();
    stack.clear();
  }


  /**
   * Adds the.
   * 
   * @param var
   *          the var
   * @return the variable
   */
  public Variable add(Variable var)
  {
    Variable ret = getVariableUpperCase(var.getUpperCaseName());
    if (ret == null)
    {
      vars.put(var.getUpperCaseName(), var);
      ret = var;
    }
    return ret;
  }


  /**
   * Adds the or set.
   * 
   * @param var
   *          the var
   * @return the variable
   */
  public Variable addOrSet(Variable var)
  {
    Variable ret = getVariableUpperCase(var.getUpperCaseName());
    if (ret == null)
    {
      vars.put(var.getUpperCaseName(), var);
      ret = var;
    }
    else
    {
      ret.setValue(var.getValue());
    }
    return ret;
  }


  /**
   * Gets the variable.
   * 
   * @param name
   *          the name
   * @return the variable
   */
  public Variable getVariable(String name)
  {
    if (name == null)
    {
      throw new RuntimeException("Null variable found!");
    }
    name = VarUtils.toUpper(name);
    return vars.get(name);
  }


  /**
   * @param name
   * @return
   */
  public Variable getVariableUpperCase(String name)
  {
    return vars.get(name);
  }


  /**
   * Adds the command.
   * 
   * @param command
   *          the command
   */
  public void addCommand(Command command)
  {
    commandList.add(command);
  }


  /**
   * Gets the command list.
   * 
   * @return the command list
   */
  public List<Command> getCommandList()
  {
    return commandList;
  }


  /**
   * Sets the command list.
   * 
   * @param commandList
   *          the new command list
   */
  public void setCommandList(List<Command> commandList)
  {
    this.commandList = commandList;
  }


  /**
   * Gets the current command.
   * 
   * @return the current command
   */
  public Command getCurrentCommand()
  {
    return currentCommand;
  }


  /**
   * Sets the current command.
   * 
   * @param currentCommand
   *          the new current command
   */
  public void setCurrentCommand(Command currentCommand)
  {
    this.currentCommand = currentCommand;
  }


  /**
   * Gets the current operator.
   * 
   * @return the current operator
   */
  public Operator getCurrentOperator()
  {
    return currentOperator;
  }


  /**
   * Sets the current operator.
   * 
   * @param currentOperator
   *          the new current operator
   */
  public void setCurrentOperator(Operator currentOperator)
  {
    this.currentOperator = currentOperator;
  }


  /**
   * Gets the output channel.
   * 
   * @return the output channel
   */
  public OutputChannel getOutputChannel()
  {
    return outputChannel;
  }


  /**
   * Sets the output channel.
   * 
   * @param outputChannel
   *          the new output channel
   */
  public void setOutputChannel(OutputChannel outputChannel)
  {
    this.outputChannel = outputChannel;
  }


  /**
   * Gets the memory listener.
   * 
   * @return the memory listener
   */
  public MemoryListener getMemoryListener()
  {
    return memoryListener;
  }


  /**
   * Sets the memory listener.
   * 
   * @param memoryListener
   *          the new memory listener
   */
  public void setMemoryListener(MemoryListener memoryListener)
  {
    this.memoryListener = memoryListener;
  }


  /**
   * Adds the defaults.
   */
  private void addDefaults()
  {
    add(new Pie());
    add(new Time());
    add(new TimeDate());
    add(new Status());
  }


  /**
   * Gets the input provider.
   * 
   * @return the input provider
   */
  public InputProvider getInputProvider()
  {
    return inputProvider;
  }


  /**
   * Sets the input provider.
   * 
   * @param inputProvider
   *          the new input provider
   */
  public void setInputProvider(InputProvider inputProvider)
  {
    this.inputProvider = inputProvider;
  }


  /**
   * Gets the data store.
   * 
   * @return the data store
   */
  public DataStore getDataStore()
  {
    return data;
  }


  /**
   * Sets the data store.
   * 
   * @param data
   *          the new data store
   */
  public void setDataStore(DataStore data)
  {
    this.data = data;
  }


  /**
   * Gets the system call listener.
   * 
   * @return the system call listener
   */
  public SystemCallListener getSystemCallListener()
  {
    return systemCallListener;
  }


  /**
   * Sets the system call listener.
   * 
   * @param systemCallListener
   *          the new system call listener
   */
  public void setSystemCallListener(SystemCallListener systemCallListener)
  {
    this.systemCallListener = systemCallListener;
  }


  /**
   * Gets the device provider.
   * 
   * @return the device provider
   */
  public DeviceProvider getDeviceProvider()
  {
    return deviceProvider;
  }


  /**
   * Sets the device provider.
   * 
   * @param deviceProvider
   *          the new device provider
   */
  public void setDeviceProvider(DeviceProvider deviceProvider)
  {
    this.deviceProvider = deviceProvider;
  }
}
