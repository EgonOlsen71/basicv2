package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.system.Machine;


/**
 * @author Foerster-H
 *
 */
public class Transformer6502
  implements Transformer
{
  @Override
  public List<String> transform(Machine machine, PlatformProvider platform, List<String> code)
  {
    List<String> res = new ArrayList<>();
    List<String> consts = new ArrayList<String>();
    List<String> vars = new ArrayList<String>();
    List<String> mnems = new ArrayList<String>();
    consts.add("; ***CONSTANTS***");
    vars.add("; ***VARIABLES***");
    Map<String, String> name2label = new HashMap<String, String>();

    res.add("*=" + platform.getStartAddress());
    int cnt = 0;

    for (String line : code)
    {
      line = AssemblyParser.truncateComments(line);
      int sp = line.indexOf(" ");
      if (sp != -1)
      {
        line = line.substring(sp).trim();
      }
      String[] parts = line.split(",");
      for (int p = 0; p < parts.length; p++)
      {
        String part = parts[p];
        if (part.contains("{") && part.endsWith("}"))
        {
          int pos = part.indexOf("{");
          String name = part.substring(0, pos);
          if (name.startsWith("#"))
          {
            if (!name2label.containsKey(name))
            {
              consts.add("; CONST: " + name);
              String label = "CONST_" + (cnt++);
              name2label.put(name, label);

              Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
              name = name.substring(1);
              if (type == Type.INTEGER)
              {
                consts.add(label + "\t" + ".WORD " + name);
              }
              else if (type == Type.REAL)
              {
                consts.add(label + "\t" + ".REAL " + name);
              }
              else if (type == Type.STRING)
              {
                consts.add(label + "\t" + ".BYTE " + name.length());
                consts.add("\t" + ".TEXT \"" + name + "\"");
              }
            }
          }
          else
          {
            if (!name2label.containsKey(name))
            {
              vars.add("; VAR: " + name);
              String label = "VAR_" + name;
              name2label.put(name, label);

              Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
              if (name.contains("[]"))
              {
                Variable var = machine.getVariable(name);
                @SuppressWarnings("unchecked")
                List<Object> vals = (List<Object>) var.getInternalValue();
                if (type == Type.INTEGER)
                {
                  vars.add(label + "\t" + ".BYTE 0");
                  vars.add("\t" + ".WORD " + vals.size() * 2);
                  vars.add("\t" + ".ARRAY " + vals.size() * 2);
                }
                else if (type == Type.REAL)
                {
                  vars.add(label + "\t" + ".BYTE 1");
                  vars.add("\t" + ".WORD " + vals.size() * 5);
                  vars.add("\t" + ".ARRAY " + vals.size() * 5);
                }
                else if (type == Type.STRING)
                {
                  vars.add(label + "\t" + ".BYTE 2");
                  vars.add("\t" + ".WORD " + vals.size() * 2);
                  vars.add(label);
                  for (int pp = 0; pp < vals.size(); pp = pp + 10)
                  {
                    StringBuilder sb = new StringBuilder();
                    sb.append("\t" + ".WORD ");
                    for (int ppp = pp; ppp < vals.size() && ppp < pp + 10; ppp++)
                    {
                      vars.add("STRBUF ");
                    }
                    vars.add(sb.toString());
                    sb.setLength(0);
                  }
                }
              }
              else
              {
                if (type == Type.INTEGER)
                {
                  vars.add(label + "\t" + ".WORD 0");
                }
                else if (type == Type.REAL)
                {
                  vars.add(label + "\t" + ".REAL 0.0");
                }
                else if (type == Type.STRING)
                {
                  vars.add(label + "\t" + ".WORD STRBUF");
                }
              }
            }
          }
        }
      }
    }

    mnems.add("rts");
    
    res.addAll(mnems);
    res.addAll(consts);
    res.addAll(vars);
    res.add("STRBUF .BYTE 0");
    return res;
  }

}
