package com.sixtyfour.system;

import java.io.BufferedInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Basic;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.For;
import com.sixtyfour.elements.systemvars.Pie;
import com.sixtyfour.elements.systemvars.Status;
import com.sixtyfour.elements.systemvars.Time;
import com.sixtyfour.elements.systemvars.TimeDate;
import com.sixtyfour.extensions.BasicExtension;
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
import com.sixtyfour.util.Jit;
import com.sixtyfour.util.VarUtils;


/**
 * The machine. In the context of this application, Machine is the closest that you'll get to a real hardware device.
 * Machine wraps the 64KB of memory, the variable memory (which is, unlike in a real machine, decoupled from the 64KB of
 * memory), input and output "devices" and such...
 */
public class Machine
{

  /** The variables */
  private Map<String, Variable> vars = new HashMap<String, Variable>();

  /** The RAM */
  private int[] ram = new int[65536];

  /** The Stack */
  private List<StackEntry> stack = new LinkedList<StackEntry>();

  /** The command list */
  private List<Command> commandList = new ArrayList<Command>();

  /** The current command */
  private Command currentCommand = null;

  /** The current operator */
  private Operator currentOperator = null;

  /** The functions */
  private Map<String, Command> functions = new HashMap<String, Command>();

  /** The data storage */
  private DataStore data = new DataStore();

  /** The output channel */
  private OutputChannel outputChannel = null;

  /** The input provider */
  private InputProvider inputProvider = null;

  /** The memory listener */
  private MemoryListener memoryListener = null;

  /** The system call listener */
  private SystemCallListener systemCallListener = null;

  /** The device provider */
  private DeviceProvider deviceProvider = null;

  private Cpu cpu = null;

  private Jit jit = null;

  private List<StackEntry> toRemove = new ArrayList<StackEntry>();

  private List<RomInfo> roms;


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
    this.cpu = new Cpu(this);
  }


  /**
   * Loads and adds a C64's KERNAL- and BASIC-ROMs to the machines memory. This might help to execute some assembler
   * programs that call these functions. However, because no actual is simulated here, not all of them might do
   * something reasonable. Consider this to be an experimental feature for now.<br/>
   * Keep in mind that you have to add some instance of SystemCallListener that actually supports calls to machine code
   * like the RamSystemCallListener to call ROM routines from BASIC.
   */
  public void addRoms()
  {
    roms = new ArrayList<RomInfo>();
    roms.add(loadRom("basic.$A000.bin", 0xa000));
    roms.add(loadRom("kernal.$E000.bin", 0xe000));
    copyRoms();
  }


  /**
   * Sets/adds a function. A function is defined in the BASIC program by the DEF FN command.
   * 
   * @param name
   *          the name of the function
   * @param function
   *          the function
   */
  public void setFunction(String name, Command function)
  {
    functions.put(name, function);
  }


  /**
   * Returns a function.
   * 
   * @param name
   *          the name of the function
   * @return the function
   */
  public Command getFunction(String name)
  {
    return functions.get(name);
  }


  /**
   * Returns the RAM's content. The RAM is a representation of 64KB of 8bit wide memory. However, the returned array is
   * of type int[]. It will contains values in the range of[0..255] only though.
   * 
   * @return the RAM
   */
  public int[] getRam()
  {
    return ram;
  }


  /**
   * Pushes a command onto the stack.
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
    stack.add(new StackEntry(command));
  }


  /**
   * Pushes a FOR command onto the stack.
   * 
   * @param fory
   *          the FOR command
   */
  public void pushFor(For fory)
  {
    if (stack.size() > 10000)
    {
      for (int i = 0; i < stack.size(); i++)
      {
        StackEntry se = stack.get(i);
        if (se.isSubroutineCall())
        {
          System.out.println(se.getCommand());
        }
      }
      throw new RuntimeException("Out of memory error, stack size exceeds 10000!");
    }

    // Remove a for with the same variable and all later ones from the stack
    for (int i = 0; i < stack.size(); i++)
    {
      StackEntry cmd = stack.get(i);
      if (cmd.isFor())
      {
        if (((For) cmd.getCommand()).getVar().equals(fory.getVar()))
        {
          popFor((For) cmd.getCommand());
          break;
        }
      }
    }

    // System.out.println(stack.size()+"/"+fory.getVar());
    stack.add(new StackEntry(fory));
  }


  /**
   * Pop a FOR command from the stack. All later FOR commands will be popped as well.
   * 
   * @param fory
   *          the FOR command
   * @return the popped command
   */
  public For popFor(For fory)
  {
    int end = stack.size() - 1;
    for (int i = end; i >= 0; i--)
    {
      StackEntry entry = stack.get(i);
      if (entry.getCommand() == fory)
      {
        if (i == end)
        {
          // Shortcut for FORs that are at the top of the stack
          stack.remove(end);
        }
        else
        {
          toRemove.clear();
          for (int p = end; p >= i; p--)
          {
            entry = stack.get(i);
            if (entry.isFor())
            {
              toRemove.add(entry);
            }
          }
          stack.removeAll(toRemove);
        }
        return (For) entry.getCommand();
      }
    }
    return null;
  }


  /**
   * Peeks on the stack for variable of a certain name and returns the macthing FOR command if any.
   * 
   * @param varName
   *          the variable name
   * @return the corresponding FOR
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
   * Gets the stack entry of the last GOSUB, if there was any.
   * 
   * @return the calling GOSUB
   */
  public StackEntry getCaller()
  {
    for (int i = stack.size() - 1; i >= 0; i--)
    {
      StackEntry entry = stack.get(i);
      if (entry.isSubroutineCall())
      {
        int end = stack.size();
        for (int p = 0; p < end - i; p++)
        {
          stack.remove(stack.size() - 1);
        }
        return entry;
      }
    }
    return null;
  }


  /**
   * Peeks on the last element of the stack.
   * 
   * @return the most current stack entry or null, if it's empty
   */
  public StackEntry peek()
  {
    if (stack.size() > 0)
    {
      return stack.get(stack.size() - 1);
    }
    return null;
  }


  /**
   * Pops the stack
   * 
   * @return the popped stack entry
   */
  public StackEntry pop()
  {
    if (stack.isEmpty())
    {
      throw new RuntimeException("Out of memory error, stack is empty!");
    }
    return stack.remove(stack.size() - 1);
  }


  /**
   * Resets the memory. This will clean the 64KB of main memory as well as all variables. It will not reset the cpu. It
   * will ensure what previously loaded ROM data has been restored.
   */
  public void resetMemory()
  {
    for (int i = 0; i < ram.length; i++)
    {
      ram[i] = 0;
    }
    clearVars();
    for (BasicExtension ex : Basic.getExtensions())
    {
      ex.reset(this);
    }
    copyRoms();
  }


  /**
   * Clears all variables.
   */
  public void clearVars()
  {
    for (Variable var : vars.values())
    {
      var.setPersistent(false);
      var.clear();
    }
    addDefaults();
    stack.clear();
  }


  /**
   * Adds a variable and returns it. If a variable of that name already exists, nothing will be added and the old
   * variable will be returned instead.
   * 
   * @param var
   *          the variable
   * @return either the newly added variable or the old one with the same name
   */
  public Variable add(Variable var)
  {
    if (var.isPersistent())
    {
      return var;
    }
    Variable ret = getVariableUpperCase(var.getUpperCaseName());
    if (ret == null)
    {
      vars.put(var.getUpperCaseName(), var);
      var.setPersistent(true);
      ret = var;
    }
    return ret;
  }


  /**
   * The same as add, but in addition, it will set the value of the new variable to the old one, if it finds it.
   * 
   * @param var
   *          the variable
   * @return either the newly added variable or the old one with the same name
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
   * Returns the variable with the given name. Case doesn't matter.
   * 
   * @param name
   *          the name of the variable
   * @return the variable or null, if it doesn't exist
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
   * Returns a map that contains all known Variables with their names as keys.
   * 
   * @return the map
   */
  public Map<String, Variable> getVariables()
  {
    return new HashMap<String, Variable>(vars);
  }


  /**
   * Returns the variable with the given name in upper case.
   * 
   * @param name
   *          in upper case
   * @return the variable or null, if it doesn't exist
   */
  public Variable getVariableUpperCase(String name)
  {
    return vars.get(name);
  }


  /**
   * Adds a command to the internal command list. This list is more kept for reference reasons rather than for actual
   * runtime reasons.
   * 
   * @param command
   *          the command
   */
  public void addCommand(Command command)
  {
    commandList.add(command);
  }


  /**
   * Returns the command list. This list contains all the commands of the BASIC program in order of parsing.
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
   * Clears the command list.
   */
  public void clearCommandList()
  {
    this.commandList.clear();
  }


  /**
   * Returns the current command. This is the command that the runtime currently executes.
   * 
   * @return the current command
   */
  public Command getCurrentCommand()
  {
    return currentCommand;
  }


  /**
   * Sets the current command. This is the command that the runtime currently executes.
   * 
   * @param currentCommand
   *          the new current command
   */
  public void setCurrentCommand(Command currentCommand)
  {
    this.currentCommand = currentCommand;
    if (jit != null)
    {
      jit.autoCompile();
    }
  }


  /**
   * Returns the current operator. This is the operator that the runtime currently works on.
   * 
   * @return the current operator
   */
  public Operator getCurrentOperator()
  {
    return currentOperator;
  }


  /**
   * Sets the current operator. This is the operator that the runtime currently works on.
   * 
   * @param currentOperator
   *          the new current operator
   */
  public void setCurrentOperator(Operator currentOperator)
  {
    this.currentOperator = currentOperator;
  }


  /**
   * Returns the output channel. By default, this is the console.
   * 
   * @return the output channel
   */
  public OutputChannel getOutputChannel()
  {
    return outputChannel;
  }


  /**
   * Sets the output channel. By default, this is the console.
   * 
   * @param outputChannel
   *          the new output channel
   */
  public void setOutputChannel(OutputChannel outputChannel)
  {
    this.outputChannel = outputChannel;
  }


  /**
   * Returns the memory listener. The memory listener listens for PEEKs and POKEs. In addition to reading from/writing
   * to the RAM, which happens anyway, the listener method get called for each PEEK or POKE. The default implementation
   * does nothing.
   * 
   * @return the memory listener
   */
  public MemoryListener getMemoryListener()
  {
    return memoryListener;
  }


  /**
   * Sets the memory listener. The memory listener listens for PEEKs and POKEs. In addition to reading from/writing to
   * the RAM, which happens anyway, the listener method get called for each PEEK or POKE. The default implementation
   * does nothing.
   * 
   * @param memoryListener
   *          the new memory listener
   */
  public void setMemoryListener(MemoryListener memoryListener)
  {
    this.memoryListener = memoryListener;
  }


  /**
   * Returns the input provider. The input provider implements the methods for reading keyboard input. The default
   * implementation is based on the Java console, which has only limited support for reading single key strokes.
   * 
   * @return the input provider
   */
  public InputProvider getInputProvider()
  {
    return inputProvider;
  }


  /**
   * Returns the input provider. The input provider implements the methods for reading keyboard input. The default
   * implementation is based on the Java console, which has only limited support for reading single key strokes.
   * 
   * @param inputProvider
   *          the new input provider
   */
  public void setInputProvider(InputProvider inputProvider)
  {
    this.inputProvider = inputProvider;
  }


  /**
   * Returns the data store. The data store contains the data stored in the program's DATA lines.
   * 
   * @return the data store
   */
  public DataStore getDataStore()
  {
    return data;
  }


  /**
   * Sets the data store. The data store contains the data stored in the program's DATA lines.
   * 
   * @param data
   *          the new data store
   */
  public void setDataStore(DataStore data)
  {
    this.data = data;
  }


  /**
   * Returns the system call listener. The system call listener listens for SYS calls of the program. The default
   * implementation just ignores these calls.
   * 
   * @return the system call listener
   */
  public SystemCallListener getSystemCallListener()
  {
    return systemCallListener;
  }


  /**
   * Sets the system call listener. The system call listener listens for SYS calls of the program. The default
   * implementation just ignores these calls.
   * 
   * @param scl
   *          the new system call listener
   */
  public void setSystemCallListener(SystemCallListener systemCallListener)
  {
    this.systemCallListener = systemCallListener;
  }


  /**
   * Returns the device provider. This is used to mimic the functionality of disc and tape drives and such. The default
   * implementation provides basic support for disc and tape operation in memory.
   * 
   * @return the device provider
   */
  public DeviceProvider getDeviceProvider()
  {
    return deviceProvider;
  }


  /**
   * Sets the device provider. This is used to mimic the functionality of disc and tape drives and such. The default
   * implementation provides basic support for disc and tape operation in memory.
   * 
   * @param deviceProvider
   *          the new device provider
   */
  public void setDeviceProvider(DeviceProvider deviceProvider)
  {
    this.deviceProvider = deviceProvider;
  }


  /**
   * Returns the cpu that this machine uses for executing assembler (NOT BASIC) programs.
   * 
   * @return the cpu
   */
  public Cpu getCpu()
  {
    return cpu;
  }


  /**
   * Copies a program's binary content in this machine's memory.
   * 
   * @param prg
   *          the program
   */
  public void putProgram(Program prg)
  {
    List<ProgramPart> parts = prg.getParts();
    for (ProgramPart part : parts)
    {
      int[] bin = part.getBytes();
      System.arraycopy(bin, 0, this.getRam(), part.getAddress(), bin.length);
    }
  }


  public Jit getJit()
  {
    return jit;
  }


  public void setJit(Jit jit)
  {
    this.jit = jit;
  }


  /**
   * Adds the default variables
   */
  private void addDefaults()
  {
    add(new Pie());
    add(new Time());
    add(new TimeDate());
    add(new Status());
  }


  private void copyRoms()
  {
    if (roms != null)
    {
      for (RomInfo rom : roms)
      {
        System.arraycopy(rom.data, 0, this.ram, rom.address, rom.data.length);
      }
    }
    ram[53272] = 21;
    ram[648] = 0x04;
    ram[0x326] = 0xca;
    ram[0x327] = 0xf1;
    ram[0x324] = 0x57;
    ram[0x325] = 0xf1;
    ram[0x322] = 0x33;
    ram[0x323] = 0xf3;
    ram[0x320] = 0x50;
    ram[0x321] = 0xf2;
    ram[0x31e] = 0x0E;
    ram[0x31f] = 0xf2;
    ram[0x31C] = 0x91;
    ram[0x31D] = 0xf2;
    ram[0x31A] = 0x4A;
    ram[0x31B] = 0xf3;
    ram[0x328] = 0xED;
    ram[0x329] = 0xf6;
    ram[0x32A] = 0x3E;
    ram[0x32B] = 0xf1;
    ram[0x32C] = 0x2F;
    ram[0x32D] = 0xf3;

    int[] chrget = new int[] { 230, 122, 208, 2, 230, 123, 173, 0, 8, 201, 58, 176, 10, 201, 32, 240, 239, 56, 233, 48,
        56, 233, 208, 96 };
    System.arraycopy(chrget, 0, this.ram, 115, chrget.length);
  }


  private RomInfo loadRom(String rom, int address)
  {
    RomInfo ri = new RomInfo();
    ri.address = address;
    BufferedInputStream br = null;
    byte[] buffer = new byte[8192];
    int[] dest = new int[8192];
    try
    {
      br = new BufferedInputStream(Thread.currentThread().getContextClassLoader().getResourceAsStream(rom));
      int len = 0;
      int cnt = 0;
      do
      {
        len = br.read(buffer);
        if (len > 0)
        {
          for (int i = 0; i < len; i++)
          {
            if (cnt + i >= dest.length)
            {
              throw new RuntimeException("ROM file too large!");
            }
            dest[cnt + i] = buffer[i] & 0xff;
          }
        }
      }
      while (len != -1);
    }
    catch (Exception e)
    {
      throw new RuntimeException("Failed to load ROM file: " + rom, e);
    }
    finally
    {
      try
      {
        if (br != null)
        {
          br.close();
        }
      }
      catch (Exception e)
      {
        //
      }
    }
    ri.data = dest;
    return ri;
  }


  private static class RomInfo
  {
    int[] data;
    int address;
  }
}
