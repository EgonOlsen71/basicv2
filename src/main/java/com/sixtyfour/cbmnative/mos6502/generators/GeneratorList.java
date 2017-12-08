package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;


public class GeneratorList
{
  private final static List<Generator> GENERATORS = Collections.unmodifiableList(new ArrayList<Generator>()
  {
    private static final long serialVersionUID = 1L;
    {
      this.add(new Mov());
    }
  });

  private final static Map<String, Generator> NAME_2_GEN = new HashMap<String, Generator>()
  {
    private static final long serialVersionUID = 1L;
    {
      for (Generator gen : GENERATORS)
      {
        this.put(gen.getMnemonic(), gen);
      }
    }
  };


  public static Generator getGenerator(String line)
  {
    line = line.trim().split(" ")[0].toUpperCase(Locale.ENGLISH);
    return NAME_2_GEN.get(line);
  }
}
