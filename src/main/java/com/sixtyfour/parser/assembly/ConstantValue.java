package com.sixtyfour.parser.assembly;

import com.sixtyfour.system.Machine;


public interface ConstantValue
{
  String getName();

  int getValue();

  int apply(Machine machine, int address);
}
