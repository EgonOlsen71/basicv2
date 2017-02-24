package com.sixtyfour.templating;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Line;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.plugins.CpuCallListener;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;
import com.sixtyfour.util.VarUtils;

/**
 * A template. A template can be HTML (but doesn't have to) with BASIC V2 code
 * in it. When parsed the template will be converted into a BASIC program. This
 * requires to add some additional line numbers, so make sure that there's
 * enough number space left between lines. See the test package for an example
 * template. A template isn't thread-safe, i.e. if you want to serve multiple
 * clients at a time with the same template, you have to create multiple
 * template instances and manage them in a ThreadLocal for example.
 */
public class Template {

	/** The vars. */
	private Map<String, Object> vars = new HashMap<String, Object>();

	private Basic basic = null;

	private List<Program> prgs = new ArrayList<Program>();

	/** The static parts. */
	private Map<Integer, TemplatePart> staticParts = new HashMap<Integer, TemplatePart>();

	/** The out. */
	private TemplateOutputChannel out;
	
	private String basicCode;
	
	private String path;
	
	/**
	 * Instantiates a new template.
	 * 
	 * @param template
	 *            the template's content
	 * @param variables
	 *            the variables to prefill the template with
	 */
	public Template(String template, Map<String, Object> variables) {
	  if (variables != null) {
	    vars.putAll(variables);
	  }
		parseTemplate(template);
	}

	/**
	 * Sets a variable to a new value.
	 * 
	 * @param name
	 *            the name of the variable in the template's basic code
	 * @param value
	 *            the new value
	 */
	public void setVariable(String name, Object value) {
		vars.put(name, value);
	}

	/**
	 * Sets all variables to new values. Old variables will be cleared before this.
	 * 
	 * @param variables the new variables
	 */
	public void setVariables(Map<String, Object> variables) {
	  vars.clear();
	  vars.putAll(variables);
	}
	
	/**
	 * Similar to setVariables, but the names don't have to follow BASIC's naming conventions. 
	 * This method will take care that they do, i.e. Floats will keeps their name, 
	 * Integers will get a "%" added and Strings a "$".
	 * 
	 * @param variables the new variables
	 */
	public void setVariablesWithType(Map<String, Object> variables) {
    vars.clear();
    Map<String, Object> vars = new HashMap<String, Object>();
    for (Entry<String, Object> entry:variables.entrySet()) {
      String name=entry.getKey();
      Object obj=entry.getValue();
      
      if (obj instanceof Double) {
        obj=((Number) obj).floatValue();
      }
      
      if (obj instanceof Integer && !name.endsWith("%")) {
        name+="%";
      } else if (obj instanceof String && !name.endsWith("$")) {
        name+="$";
      }
      vars.put(name, obj);
    }
    setVariables(vars);
  }
	
	/**
	 * Returns the BASIC code that has been created by parsing the template. This is the code that will actually be compiled and executed.
	 * @return the code
	 */
	public String getBasicCode() {
	  return basicCode;
	}
	
	/**
	 * Gets a variable's value.
	 * 
	 * @param name
	 *            the name of the variable in the template's basic code
	 * @return the variable
	 */
	public Object getVariable(String name) {
		Variable var = basic.getMachine().getVariable(VarUtils.toUpper(name));
		if (var == null) {
			return null;
		}
		return var.getValue();
	}

	/**
	 * Processes the templates. This resets the underlying machine instance.
	 * 
	 * @return the processed template, i.e. the generated output.
	 */
	public String process() {
		out.reset();
		Machine machine = basic.getMachine();
		machine.resetMemory();
		machine.getCpu().reset();
		for (Program prg : prgs) {
			machine.putProgram(prg);
		}
		for (Map.Entry<String, Object> var : vars.entrySet()) {
			Variable vary = new Variable(VarUtils.toUpper(var.getKey()), var.getValue());
			machine.addOrSet(vary);
		}
		basic.start();
		return out.getResult();
	}
	
	
	/**
	 * Gets the path of the template in the file system, if one has been set.
	 * 
	 * @return the path or null, if none has been set
	 */
	public String getPath()
  {
    return path;
  }

  /**
   * Sets the path of the template in the file system. The template itself doesn't do anything with this
   * information, so it doesn't have to exist in all cases.
   * 
   * @param path the path
   */
  public void setPath(String path)
  {
    this.path = path;
  }
  
  /**
   * Gets the current machine instance of the internal Basic instance.
   * 
   * @param machine the machine
   */
  public Machine getMachine() {
    return basic.getMachine();
  }

  /**
   * Injects a new machine instance into the internal Basic instance.
   * 
   * @param machine the machine
   */
  public void setMachine(Machine machine) {
    basic.setMachine(machine);
  }
  
  /**
   * Processes a part of a template.
   * 
   * @param out
   * @return
   */
  String processPart() {
      out.reset();
      basic.start();
      return out.getResult();
  }
  
	/**
	 * Parses the template.
	 * 
	 * @param template
	 *            the template
	 */
	private void parseTemplate(String template) {
	  int pl=template.toLowerCase(Locale.ENGLISH).indexOf("<!labels>");
		boolean labels = pl!=-1;
		if (labels) {
			template += "<?cbm REM end ?>";
			template=template.substring(0,pl)+template.substring(pl+9);
		} else {
			template += "<?cbm 9999999 REM end ?>";
		}
		String utemp = VarUtils.toUpper(template);
		int pos = 0;
		int last = 0;
		int lastLine = 0;
		StringBuilder code = new StringBuilder();

		do {
			int opos = pos;
			pos = utemp.indexOf("<?CBM", opos);

			if (pos != -1) {
				int pos2 = -1;
				boolean inString = false;
				for (int i = pos; i < utemp.length() - 1; i++) {
					char c = utemp.charAt(i);
					if (c == '"') {
						inString = !inString;
					}
					if (!inString && c == '?' && utemp.charAt(i + 1) == '>') {
						pos2 = i + 2;
						break;
					}
				}
				if (pos2 == -1) {
					throw new RuntimeException("Syntax error in template, no closing ?> found!");
				}

				String prior = template.substring(last, pos);
				String codePart = template.substring(pos + 5, pos2 - 2);
				int firstLine = -1;
				int endLine = -1;

				boolean asm = codePart.toLowerCase(Locale.ENGLISH).startsWith(":asm");
				if (asm) {
					codePart = codePart.substring(4);
				}

				String[] lines = codePart.split("\n");

				if (!asm) {
					if (!labels) {
						// Normal BASIC code with line numbers
						for (String line : lines) {
							line = line.replace("\t", "").trim();
							if (!line.isEmpty()) {
								Line lo = Line.getLine(line);
								firstLine = lo.getNumber();
								break;
							}
						}

						for (int i = lines.length - 1; i >= 0; i--) {
							String line = lines[i];
							line = line.replace("\t", "").trim();
							if (!line.isEmpty()) {
								Line lo = Line.getLine(line);
								endLine = lo.getNumber();
								break;
							}
						}

						if (firstLine <= lastLine) {
							throw new RuntimeException("Line numbers (" + firstLine + "/" + lastLine + ") too close, can't insert static content into template!");
						}

						lastLine=addStaticPart(lastLine, code, prior, firstLine);
						prior=null;
						lastLine = endLine;
					} else {
						// BASIC code with labels instead of line numbers
						if (!prior.isEmpty()) {
							TemplatePart tp = new TemplatePart(prior);
							prior=null;
							lastLine++;
							code.append("SYS1000,").append(lastLine).append('\n');
							staticParts.put(lastLine, tp);
						}
					}
					code.append(codePart).append('\n');
				} else {
				  lastLine=addStaticPart(lastLine, code, prior, firstLine);
				  prior=null;
					Assembler assem = new Assembler(lines);
					assem.compile();
					prgs.add(assem.getProgram());
				}
				last = pos2;
				pos = pos2;
			}
		} while (pos != -1);

		if (labels) {
			String[] lines = code.toString().split("\n");
			lines = Preprocessor.convertToLineNumbers(lines);
			code.setLength(0);
			for (String line : lines) {
				code.append(line).append('\n');
			}
		}
		// System.out.println(code);
		
		basicCode=code.toString();
		basic = new Basic(basicCode);
		basic.compile();
		out = new TemplateOutputChannel();
		basic.setOutputChannel(out);
		basic.getMachine().setSystemCallListener(new StaticTemplateCallListener(staticParts, out, basic.getMachine()));
		basic.getMachine().setDeviceProvider(new TemplateDeviceProvider(basic, this));
		basic.getMachine().getCpu().setCpuCallListener(new CpuCallListener() {
      @Override
      public boolean jsr(Cpu cpu, int addr)
      {
        if (addr==65490) {
          if (cpu.getAcc()!=0) {
            out.print(0, String.valueOf((char) (cpu.getAcc())));
          }
          return true;
        }
        return false;
      }
    });
	}

  private int addStaticPart(int lastLine, StringBuilder code, String prior, int firstLine)
  {
    if (!prior.isEmpty()) {
      TemplatePart tp = new TemplatePart(prior);
      tp.setFirstLine(lastLine);
      tp.setLastLine(firstLine - 1);
      lastLine++;
      code.append(lastLine).append(" SYS1000,").append(lastLine).append('\n');
      staticParts.put(lastLine, tp);
    }
    return lastLine;
  }
}
