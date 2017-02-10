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
 * A JIT compiler that can compile some expressions into actual Java bytecode at
 * runtime. For this to work, the application has to run on a JDK, not a JRE. A
 * JIT might help to improve performance for complex calculations. If your
 * program doesn't do these, it might not even kick in or the additional
 * overhead might slow your program down.
 * 
 * @author EgonOlsen
 * 
 */
public class Jit {
	private StringBuilder code = new StringBuilder();
	private Jitted jitted = null;
	private List<Term> jittedTerms = new ArrayList<Term>();
	private int compileThreshold = 0;
	private boolean failed = false;
	private List<Variable> vars = new ArrayList<Variable>();
	private static Object sync = new Object();

	/**
	 * Creates a new Jit. A Jit has to be assigned to the current instance of
	 * Machine. This constructor creates a JIT with the default count of 19
	 * methods to compile, i.e. the actual bytecode generation kicks in when 19
	 * expressions are marked as potentially jittable.
	 */
	public Jit() {
		this(19);
	}

	/**
	 * Creates a new Jit. A Jit has to be assigned to the current instance of
	 * Machine. This constructor creates a JIT with a user defined count of
	 * "compileThreshold" methods to compile, i.e. the actual bytecode
	 * generation kicks in when compileThreshold expressions are marked as
	 * potentially jittable.
	 * 
	 * @param compileThreshold
	 */
	public Jit(int compileThreshold) {
		this.compileThreshold = compileThreshold;
		code.append("import com.sixtyfour.system.*; import com.sixtyfour.elements.*; \npublic class JittedImpl implements com.sixtyfour.util.Jitted { private Variable[] vars; [vars] public JittedImpl() {} \n public void setVars(Variable[] vars) {this.vars=vars;} ");
	}

	/**
	 * Adds a variable to the compiled code. Used internally, no need to call
	 * this from an application.
	 * 
	 * @param var
	 *            the variable to add
	 * @return the position in the JIT's list
	 */
	public int addVariable(Variable var) {
		if (vars.contains(var)) {
			return vars.indexOf(var);
		}
		vars.add(var);
		return vars.indexOf(var);
	}

	/**
	 * Adds a method that evaluates an expressions. Used internally, no need to
	 * call this from an application.
	 * 
	 * @param term
	 *            the term that forms the expression
	 * @param machine
	 *            the current machine
	 */
	public void addMethod(Term term, Machine machine) {
		if (jitted == null && !failed) {
			if (!jittedTerms.contains(term)) {
				String cody = term.toCode(machine);
				if (cody == null || cody.length() < 80) {
					return;
				}
				code.append("\npublic final Object m").append(term.getId()).append("(Machine machine) {").append("return ").append(cody.trim()).append(";}\n");
				jittedTerms.add(term);

				// Logger.log("Jitted methods: " + jittedTerms.size());

				if (jittedTerms.size() > compileThreshold) {
					compile();
				}
			}
		}
	}

	/**
	 * Calls the actual compiled bytecode of a Term.
	 * 
	 * @param machine
	 *            the current machine
	 * @param term
	 *            the term
	 * @return the result
	 */
	public Object call(Machine machine, Term term) {
		Method m = term.getJittedMethod();
		if (m == null) {
			throw new RuntimeException("Internal JIT error: " + term);
		}
		try {
			return m.invoke(jitted, machine);
		} catch (Exception e) {
			throw new RuntimeException("Internal JIT error: " + term, e);
		}

	}

	private void compile() {
		if (jitted == null && !failed) {
			File sourceFile = null;
			synchronized (sync) {
				try {
					long s = System.currentTimeMillis();
					Logger.log("Running JIT-Compiler...");
					code.append("}");
					String source = code.toString();
					
					StringBuilder varStr=new StringBuilder();
					for (Variable var:vars) {
					  varStr.append("\npublic Variable ").append(var.getName()).append("=null;\n");
					}
					source=source.replace("[vars]", varStr.toString());
					
					//System.out.println(source);

					sourceFile = new File("JittedImpl.java");
					Files.write(sourceFile.toPath(), source.getBytes(StandardCharsets.UTF_8));
					JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
					if (compiler == null) {
						Logger.log("Unable to run JIT-Compiler! Please run this application using a JDK, not a JRE!");
						failed = true;
						return;
					}
					compiler.run(null, null, null, sourceFile.getPath());

					URLClassLoader classLoader = URLClassLoader.newInstance(new URL[] { new File(".").toURI().toURL() });
					Class<?> cls = Class.forName("JittedImpl", true, classLoader);
					jitted = (Jitted) cls.newInstance();
					jitted.setVars(this.vars.toArray(new Variable[vars.size()]));
					
					for (Variable var:vars) {
					  jitted.getClass().getField(var.getName()).set(jitted, var);
					}
					
					Logger.log("JIT-Compiler executed in " + (System.currentTimeMillis() - s) + "ms, " + jittedTerms.size() + " methods compiled!");

					for (Term jittedTerm : jittedTerms) {
						try {
							jittedTerm.setJittedMethod(jitted.getClass().getMethod("m" + jittedTerm.getId(), Machine.class));
						} catch (Exception e) {
							throw new RuntimeException("Internal JIT error: " + jittedTerm, e);
						}
					}
				} catch (Exception e) {
					Logger.log("Failed to run JIT-Compiler!", e);
					failed = true;
				}
				finally {
					if (sourceFile != null) {
						new File("JittedImpl.class").delete();
						if (!sourceFile.delete()) {
							sourceFile.deleteOnExit();
							new File("JittedImpl.class").deleteOnExit();
						}
					}
				}
			}
		}
	}

}
