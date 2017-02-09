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
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;


public class Jit
{
  private StringBuilder code = new StringBuilder();
  private Jitted jitted = null;
  private List<Term> jittedTerms = new ArrayList<Term>();
  private int compileThreshold = 25;
  private boolean failed = false;

  private static Object sync = new Object();


  public Jit()
  {
    this(20);
  }


  public Jit(int compileThreshold)
  {
    this.compileThreshold = compileThreshold;
    code.append(
        "import com.sixtyfour.system.Machine; \npublic class JittedImpl implements com.sixtyfour.util.Jitted { public JittedImpl() {} ");
  }


  public void addMethod(Term term)
  {
    if (jitted == null && !failed)
    {
      if (!jittedTerms.contains(term))
      {
        String cody = term.toCode();
        if (cody == null || cody.length() < 80)
        {
          return;
        }
        code.append("\npublic final static Object m").append(term.getId()).append("(Machine machine) {")
            .append("return ").append(cody).append(";}\n");
        jittedTerms.add(term);

        // Logger.log("Jitted methods: " + jittedTerms.size());

        if (jittedTerms.size() > compileThreshold)
        {
          compile();
        }
      }
    }
  }


  public Object call(Machine machine, Term term)
  {
      Method m = term.getJittedMethod();
      if (m == null)
      {
        throw new RuntimeException("Internal JIT error: " + term);
      }
      try
      {
        return m.invoke(jitted, machine);
      }
      catch (Exception e)
      {
        throw new RuntimeException("Internal JIT error: " + term, e);
      }
    
  }


  public void compile()
  {
    if (jitted == null && !failed)
    {
      synchronized (sync)
      {
        try
        {
          long s = System.currentTimeMillis();
          Logger.log("Running JIT-Compiler...");
          code.append("}");
          String source = code.toString();
          
          File sourceFile = new File("JittedImpl.java");
          Files.write(sourceFile.toPath(), source.getBytes(StandardCharsets.UTF_8));
          JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
          if (compiler == null)
          {
            Logger.log("Unable to run JIT-Compiler! Please run this application using a JDK, not a JRE!");
            failed = true;
          }
          compiler.run(null, null, null, sourceFile.getPath());

          URLClassLoader classLoader = URLClassLoader.newInstance(new URL[] { new File(".").toURI().toURL() });
          Class<?> cls = Class.forName("JittedImpl", true, classLoader);
          jitted = (Jitted) cls.newInstance();
          Logger.log("JIT-Compiler executed in " + (System.currentTimeMillis() - s) + "ms, " + jittedTerms.size()
              + " methods compiled!");
          sourceFile.delete();
          
          for (Term jittedTerm : jittedTerms)
          {
            try
            {
              jittedTerm.setJittedMethod(jitted.getClass().getMethod("m" + jittedTerm.getId(), Machine.class));
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
      }
    }
  }

}
