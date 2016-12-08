package com.sixtyfour.parser.assembly;

import java.util.HashMap;
import java.util.Map;


public class ConstantsContainer
{

  private Map<String, ConstantValue> constants = new HashMap<String, ConstantValue>();


  public void put(ConstantValue val)
  {
    constants.put(val.getName(), val);
  }


  public ConstantValue get(String name)
  {
    return constants.get(name);
  }

}
