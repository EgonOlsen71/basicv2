package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

/**
 * @author Foerster-H
 *
 */
public interface Generator
{
  String getMnemonic();
  
  void generateCode(String line, List<String> nCode, List<String> subCode, Map<String, String> name2label);
}
