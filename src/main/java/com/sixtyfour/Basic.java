package com.sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Rem;
import com.sixtyfour.parser.Line;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.plugins.InputProvider;
import com.sixtyfour.plugins.MemoryListener;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;


/**
 * Basic is for parsing/compiling and executing BASIC V2 programs. The program will be compiled into some object code.
 * Albeit the machine offers a 64kb array of memory, the actual basic program doesn't reside in it.
 * 
 * @author EgonOlsen
 * 
 */
public class Basic
  implements ProgramExecutor
{

  /** The code. */
  private String[] code = null;

  /** The lines. */
  private Map<Integer, Line> lines = new HashMap<Integer, Line>();

  /** The line numbers. */
  private List<Integer> lineNumbers = new ArrayList<Integer>();

  /** The machine. */
  private Machine machine = null;

  /** Has it been compiled already? */
  private boolean compiled = false;

  /** Should it stop? */
  private boolean stop = false;

  /** The print line numbers. */
  private boolean printLineNumbers = false;

  private boolean paused;

  private boolean running;


  /**
   * Instantiates a new instance for a BASIC program. No interpretation/compilation will take place at this stage.
   * 
   * @param code
   *          the basic code
   */
  public Basic(String code)
  {
    this(code.split("\n"));
  }


  /**
   * Instantiates a new instance for a BASIC program. No interpretation/compilation will take place at this stage.
   * 
   * @param code
   *          the basic code
   * @param machine
   *          the machine instance that should be used to run the code. If null is given, a new one will be created.
   */
  public Basic(String code, Machine machine)
  {
    this(code.split("\n"), machine);
  }


  /**
   * Instantiates a new instance for a BASIC program. No interpretation/compilation will take place at this stage. This
   * constructor takes an array of code lines as input. Each code line should represent a line in the BASIC program.
   * 
   * @param code
   *          the basic code
   */
  public Basic(String[] code)
  {
    this(code, null);
  }


  /**
   * Instantiates a new instance for a BASIC program. No interpretation/compilation will take place at this stage. This
   * constructor takes an array of code lines as input. Each code line should represent a line in the BASIC program.
   * 
   * @param code
   *          the basic code
   * @param machine
   *          the machine instance that should be used to run the code. If null is given, a new one will be created.
   */
  public Basic(String[] code, Machine machine)
  {
    this.code = Arrays.copyOf(code, code.length);
    if (machine == null)
    {
      this.machine = new Machine();
    }
    else
    {
      this.machine = machine;
    }
  }


  /**
   * Gets the machine.
   * 
   * @return the machine
   */
  @Override
  public Machine getMachine()
  {
    return machine;
  }


  /**
   * Sets a new machine.
   * 
   * @param machine
   *          the new machine
   */
  public void setMachine(Machine machine)
  {
    this.machine = machine;
  }


  /**
   * Gets the machine's cpu. This cpu is used to execute machine language code, not for running basic programs.
   * 
   * @return
   */
  @Override
  public Cpu getCpu()
  {
    return machine.getCpu();
  }


  /**
   * Gets the value of a string variable.
   * 
   * @param name
   *          the name of the variable including the "$" postfix, case doesn't matter
   * @return the variable's value or null, if the variable doesn't exist (yet).
   */
  public String getStringVariable(String name)
  {
    Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
    if (VarUtils.isString(obj))
    {
      return (String) obj;
    }
    return null;
  }


  /**
   * Gets the value of an integer variable.
   * 
   * @param name
   *          the name of the variable including the "%" postfix, case doesn't matter
   * @return the variable's value or null, if the variable doesn't exist (yet).
   */
  public Integer getIntegerVariable(String name)
  {
    Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
    if (VarUtils.isInteger(obj))
    {
      return (Integer) obj;
    }
    return null;
  }


  /**
   * Gets the value of a floating point variable.
   * 
   * @param name
   *          the name of the variable, case doesn't matter
   * @return the variable's value or null, if the variable doesn't exist (yet).
   */
  public Float getFloatVariable(String name)
  {
    Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
    if (VarUtils.isFloat(obj))
    {
      return (Float) obj;
    }
    return null;
  }


  /**
   * Gets the value of an array variable. The actual datatype depends on the type of the variable and is either String,
   * Integer or Float.
   * 
   * @param name
   *          the name of the variable, [] postfix is optional, case doesn't matter
   * @return the variable's value or null, if the variable doesn't exist (yet).
   */
  @SuppressWarnings("unchecked")
  public Object[] getArrayVariable(String name)
  {
    if (!name.endsWith("[]"))
    {
      name = name + "[]";
    }
    Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
    if (obj.getClass().isArray())
    {
      return ((ArrayList<Object>) obj).toArray();
    }
    return null;
  }


  /**
   * Compiles the code. This can be called before calling the actual run method to precompile the code. It doesn't have
   * to though, because run() will call it on its own if needed.
   */
  @Override
  public void compile()
  {
    compile(true);
  }


  /**
   * Compiles the code. This can be called before calling the actual run method to precompile the code. It doesn't have
   * to though, because run() will call it on its own if needed.
   * 
   * @param resetMachine
   *          if true, the compile will happen on a clean machine. If false, it it will reuse existing variable
   *          definitions
   */
  public void compile(boolean resetMachine)
  {
    long start = System.nanoTime();
    if (resetMachine)
    {
      machine.resetMemory();
    }
    Line cl = null;
    int lastLineNumber = -1;
    lines.clear();
    lineNumbers.clear();
    for (String line : code)
    {
      try
      {
        line = line.replaceAll("^\\s+", "");
        if (line.isEmpty())
        {
          continue;
        }
        cl = Line.getLine(line);
        if (lines.containsKey(cl.getNumber()))
        {
          throw new RuntimeException("Duplicate line number in: " + line);
        }
        if (cl.getNumber() < 0 || cl.getNumber() < lastLineNumber)
        {
          throw new RuntimeException("Faulty line number in: " + line);
        }
        lastLineNumber = cl.getNumber();
        int lineCnt = lineNumbers.size();
        cl.setCount(lineCnt);

        lines.put(cl.getNumber(), cl);
        lineNumbers.add(cl.getNumber());

        boolean looseEnding = cl.getLine().trim().endsWith(":");
        if (looseEnding)
        {
          cl.addDummyRemark();
        }
        String[] parts = Parser.getParts(cl, machine);

        int pos = 0;
        for (String part : parts)
        {
          do
          {
            if (part.trim().length() > 0)
            {
              Command command = Parser.getCommand(part);
              if (command == null)
              {
                throw new RuntimeException("Syntax error: " + cl.getNumber() + " " + cl.getLine());
              }
              if (!command.keepSpaces())
              {
                part = Parser.removeWhiteSpace(part);
              }
              part = command.parse(part, lineCnt, cl.getNumber(), pos, (pos == parts.length - 1), machine);

              machine.addCommand(command);
              cl.addCommand(command);
              pos++;
              if (Rem.REM_MARKER.equals(part))
              {
                break;
              }
            }
            else
            {
              part = null;
            }
          }
          while (part != null);
          if (Rem.REM_MARKER.equals(part))
          {
            break;
          }
        }
      }
      catch (Throwable t)
      {
        String msg = t.getMessage();
        String err = "Error in line " + (cl != null ? cl.getNumber() : "??") + (msg != null ? (": " + msg) : "");
        machine.getOutputChannel().println(0, err);
        throw t;
      }
    }
    compiled = true;
    Logger.log(
        machine.getCommandList().size() + " commands compiled in: " + (System.nanoTime() - start) / 1000000L + "ms");
  }


  /**
   * Starts a previously compiled BASIC program. This method is similar to run() with the exception that it requires the
   * code to be compiled already. If it isn't, it will exit with a RuntimeException. This can be useful, it you want to
   * re-run the same program multiple times without compiling it over and over again.
   */
  @Override
  public void start()
  {
    stop = false;
    if (!compiled)
    {
      throw new RuntimeException("Code not compiled! Either call compile();start(); or run()!");
    }
    runInternal();
  }


  /**
   * Runs the program. If needed, this will call compile() as well. This will wipe the memory clear and resets all
   * variables as well. If you don't want this, use start() instead or call compile() before calling run().
   */
  @Override
  public void run()
  {
    stop = false;
    if (!compiled)
    {
      compile();
    }
    if (compiled)
    {
      runInternal();
      compiled = false;
    }
    else
    {
      machine.getOutputChannel().println(0, "\nREADY.");
    }
  }


  /**
   * Resets the memory. This will clean the 64KB of main memory as well as all variables.
   */
  public void resetMemory()
  {
    machine.resetMemory();
  }


  /**
   * Stops a currently running program after the next commands has been executed.
   */
  @Override
  public void runStop()
  {
    stop = true;
  }


  /**
   * Returns the RAM's content. The RAM is a representation of 64KB of 8bit wide memory. However, the returned array is
   * of type int[]. It will contains values in the range of[0..255] only though.
   * 
   * @return the RAM
   */
  @Override
  public int[] getRam()
  {
    return machine.getRam();
  }


  /**
   * Returns the input provider. The input provider implements the methods for reading keyboard input. The default
   * implementation is based on the Java console, which has only limited support for reading single key strokes.
   * 
   * @return the input provider
   */
  public InputProvider getInputProvider()
  {
    return machine.getInputProvider();
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
    machine.setInputProvider(inputProvider);
  }


  /**
   * Returns the output channel. By default, this is the console.
   * 
   * @return the output channel
   */
  public OutputChannel getOutputChannel()
  {
    return machine.getOutputChannel();
  }


  /**
   * Sets the output channel. By default, this is the console.
   * 
   * @param outputChannel
   *          the new output channel
   */
  public void setOutputChannel(OutputChannel outputChannel)
  {
    machine.setOutputChannel(outputChannel);
  }


  /**
   * Returns the system call listener. The system call listener listens for SYS calls of the program. The default
   * implementation just ignores these calls.
   * 
   * @return the system call listener
   */
  public SystemCallListener getSystemCallListener()
  {
    return machine.getSystemCallListener();
  }


  /**
   * Sets the system call listener. The system call listener listens for SYS calls of the program. The default
   * implementation just ignores these calls.
   * 
   * @param scl
   *          the new system call listener
   */
  public void setSystemCallListener(SystemCallListener scl)
  {
    machine.setSystemCallListener(scl);
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
    return machine.getMemoryListener();
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
    machine.setMemoryListener(memoryListener);
  }


  /**
   * Returns true, if line numbers should be printed out at runtime.
   * 
   * @return true, if yes. Default is false.
   */
  public boolean isPrintLineNumbers()
  {
    return printLineNumbers;
  }


  /**
   * If set to true, the current line number will be printed out at runtime.
   * 
   * @param printLineNumbers
   *          Should line numbers be printed out?
   */
  public void setPrintLineNumbers(boolean printLineNumbers)
  {
    this.printLineNumbers = printLineNumbers;
  }


  public void setPause(boolean paused)
  {
    this.paused = paused;
  }


  public boolean isPaused()
  {
    return paused;
  }


  /**
   */
  private void runInternal()
  {
    long start = System.nanoTime();
    execute(0, 0);
    long end = System.nanoTime();
    machine.getOutputChannel().println(0, "\nREADY. (" + ((end - start) / 1000000L) + "ms)");
  }


  /**
   * @param lineCnt
   *          the line cnt
   * @param pos
   *          the pos
   */
  private void execute(int lineCnt, int pos)
  {
    if (lineNumbers.size() == 0)
    {
      return;
    }
    Integer num = null;
    running = true;
    try
    {
      do
      {
        num = lineNumbers.get(lineCnt);
        if (printLineNumbers)
        {
          Logger.log("[" + num + "]");
        }
        Line line = lines.get(num);

        for (int i = pos; i < line.getCommands().size(); i++)
        {

          if (stop)
          {
            machine.getOutputChannel().println(0, "\nBREAK IN " + num);
            break;
          }

          while (paused)
          {
            try
            {
              Thread.sleep(1);
            }
            catch (InterruptedException e)
            {
              //
            }
          }

          Command command = line.getCommands().get(i);
          machine.setCurrentCommand(command);
          BasicProgramCounter pc = command.execute(machine);
          machine.setCurrentCommand(null);
          if (pc != null)
          {
            if (pc.isEnd() || pc.isStop())
            {
              lineCnt = lines.size();
              if (pc.isStop())
              {
                this.machine.getOutputChannel().println(0, "Break in " + num);
              }
              break;
            }
            if (pc.isList())
            {
              for (String cl : code)
              {
                this.machine.getOutputChannel().println(0, cl);
              }
            }
            else
            {
              if (pc.isSkip())
              {
                break;
              }
              if (pc.getLineNumber() == -1)
              {
                // Line index is known (FOR...NEXT/RETURN/RUN
                // w/o
                // line)
                lineCnt = pc.getLineCnt();
                num = lineNumbers.get(lineCnt);
                line = lines.get(num);
                i = pc.getLinePos();
                if (i >= line.getCommands().size() - 1)
                {
                  lineCnt++;
                  num = lineNumbers.get(lineCnt);
                  line = lines.get(num);
                  i = -1;
                }
              }
              else
              {
                // Line number is known (GOTO/GOSUB/RUN w/ line)
                num = pc.getLineNumber();
                line = lines.get(num);
                i = -1;
                if (line == null)
                {
                  throw new RuntimeException("Undef'd statement error: " + command);
                }
                lineCnt = line.getCount();
              }
            }
          }
        }
        lineCnt++;
      }
      while (lineCnt < lines.size());
    }
    catch (Throwable t)
    {
      String msg = t.getMessage();
      String err = "Error in line " + (num != null ? num : "??") + (msg != null ? (": " + msg) : "");
      machine.getOutputChannel().println(0, err);
      running = false;
      throw t;
    }
    running = false;
  }


  @Override
  public boolean isRunning()
  {
    return running;
  }

}
