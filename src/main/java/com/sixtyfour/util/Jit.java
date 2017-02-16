package com.sixtyfour.util;

import java.io.File;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;


/**
 * A JIT compiler that can compile some expressions into actual Java bytecode at runtime. For this to work, the
 * application has to run on a JDK, not a JRE. A JIT might help to improve performance for complex calculations. If your
 * program doesn't do these, it might not even kick in or the additional overhead might slow your program down.
 * 
 * @author EgonOlsen
 * 
 */
public class Jit
{
  private StringBuilder code = new StringBuilder();
  private List<Term> jittedTerms = new ArrayList<Term>();
  private int compileThreshold = 0;
  private boolean failed = false;
  private List<Variable> vars = new ArrayList<Variable>();
  private static Object sync = new Object();
  private long lastAdd = 0;
  private boolean compilerRunning = false;
  private static int id=0;


  /**
   * Creates a new Jit. A Jit has to be assigned to the current instance of Machine. This constructor creates a JIT with
   * the default threshold of 0, i.e. the JIT compiler will try to auto-detect when to compile.
   */
  public Jit()
  {
    this(0);
  }


  /**
   * Creates a new Jit. A Jit has to be assigned to the current instance of Machine. This constructor creates a JIT with
   * a user defined count of "compileThreshold" methods to compile, i.e. the actual bytecode generation kicks in when
   * compileThreshold expressions are marked as potentially jittable. If the threshold is <=0, then the JIT compiler
   * will try to auto-detect when to compile.
   * 
   * @param compileThreshold
   */
  public Jit(int compileThreshold)
  {
    this.compileThreshold = compileThreshold;
    initCode();
  }

  /**
   * Adds a variable to the compiled code. Used internally, no need to call this from an application.
   * 
   * @param var
   *          the variable to add
   * @return the position in the JIT's list
   */
  public void addVariable(Variable var)
  {
    synchronized(sync) {
      if (compilerRunning) {
        return;
      }
      if (!vars.contains(var))
      {
      vars.add(var);
      }
    }
  }


  /**
   * Adds a method that evaluates an expressions. Used internally, no need to call this from an application.
   * 
   * @param term
   *          the term that forms the expression
   * @param machine
   *          the current machine
   */
  public boolean addMethod(Term term, Machine machine)
  {
    synchronized (sync)
    {
      if (compilerRunning) {
        return false;
      }
    }
    if (!failed)
    {
      if (!jittedTerms.contains(term))
      {
        String cody = term.toCode(machine);
        if (cody == null || cody.length() < 80)
        {
          return true;
        }
        code.append("\npublic final Object m").append(term.getId()).append("() {").append("return ").append(cody.trim())
            .append(";}\n");
        jittedTerms.add(term);
        lastAdd = System.currentTimeMillis();

        if (compileThreshold > 0 && jittedTerms.size() > compileThreshold && !compilerRunning)
        {
          compile();
        }
      }
    } 
    return true;
  }


  /**
   * Triggers the JIT to check if a compilation might be useful to do now. If yes, it will compile the code that it has
   * marked so far. If not, nothing will happen.
   */
  public void autoCompile()
  {
    if (lastAdd > 0 && compileThreshold <= 0 && !failed)
    {
      if (System.currentTimeMillis() - lastAdd >= 200 && !compilerRunning)
      {
        Logger.log("Auto-compilation triggered!");
        compile();
      }
    }
  }


  /**
   * Calls the actual compiled bytecode of a Term.
   * 
   * @param term
   *          the term
   * @return the result
   */
  public Object call(Term term)
  {
    Method m = term.getJittedMethod();
    if (m == null)
    {
      throw new RuntimeException("Internal JIT error: " + term);
    }
    try
    {
      return m.invoke(term.getJittedInstance());
    }
    catch (Exception e)
    {
      throw new RuntimeException("Internal JIT error: " + term, e);
    }

  }


  private void compile()
  {
    if (!failed)
    {
      synchronized (sync)
      {
        if (compilerRunning)
        {
          return;
        }
        compilerRunning = true;
        Thread compileThread = new Thread()
        {
          @Override
          public void run()
          {
            String clazzName="JittedImpl"+(id++);
            File sourceFile = null;
            try
            {

              long s = System.currentTimeMillis();
              Logger.log("Running JIT-Compiler...");
              code.append("}");
              String source = code.toString();

              StringBuilder varStr = new StringBuilder();
              for (Variable var : vars)
              {
                varStr.append("\npublic Variable ").append(var.getName().replace('%', '_').replace("$", "__"))
                    .append("=null;\n");
              }
              source = source.replace("[vars]", varStr.toString());

              // System.out.println(source);

              sourceFile = new File(clazzName+".java");
              Files.write(sourceFile.toPath(), source.getBytes(StandardCharsets.UTF_8));
              JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
              if (compiler == null)
              {
                Logger.log("Unable to run JIT-Compiler! Please run this application using a JDK, not a JRE!");
                failed = true;
                return;
              }
              compiler.run(null, null, null, sourceFile.getPath());

              URLClassLoader classLoader = URLClassLoader.newInstance(new URL[] { new File(".").toURI().toURL() });
              Class<?> cls = Class.forName(clazzName, true, classLoader);
              Jitted jittedCode = (Jitted) cls.newInstance();
              jittedCode.setVars(vars.toArray(new Variable[vars.size()]));

              for (Variable var : vars)
              {
                jittedCode.getClass().getField(var.getName().replace('%', '_').replace("$", "__")).set(jittedCode, var);
              }

              Logger.log("JIT-Compiler executed in " + (System.currentTimeMillis() - s) + "ms, " + jittedTerms.size()
                  + " methods compiled into "+clazzName+".class!");

              for (Term jittedTerm : jittedTerms)
              {
                try
                {
                  jittedTerm.setJittedInstance(jittedCode);
                  jittedTerm.setJittedMethod(jittedCode.getClass().getMethod("m" + jittedTerm.getId()));
                }
                catch (Exception e)
                {
                  throw new RuntimeException("Internal JIT error: " + jittedTerm, e);
                }
              }
            }
            catch (Exception e)
            {
              Logger.log("Failed to run JIT-Compiler!", e);
              failed = true;
            }
            finally
            {
              if (sourceFile != null)
              {
                new File(clazzName+".class").delete();
                if (!sourceFile.delete())
                {
                  sourceFile.deleteOnExit();
                  new File(clazzName+".class").deleteOnExit();
                }
              }
              initCode();
              vars.clear();
              jittedTerms.clear();
              lastAdd=0;
              compilerRunning = false;
            }

          }
        };
        compileThread.start();
      }
    }
  }
  
  private void initCode()
  {
    code.setLength(0);
    code.append(
        "import com.sixtyfour.system.*; import com.sixtyfour.elements.*; \npublic class JittedImpl"+id+" implements com.sixtyfour.util.Jitted { private Variable[] vars; [vars] public JittedImpl"+id+"() {} \n public void setVars(Variable[] vars) {this.vars=vars;} ");
  }

}
