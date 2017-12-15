package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Type;


public class Movb
  implements Generator
{

  @Override
  public String getMnemonic()
  {
    return "MOVB";
  }


  @Override
  public void generateCode(String line, List<String> nCode, List<String> subCode, Map<String, String> name2label)
  {
    Operands ops = new Operands(line, name2label);
    Logger.log(line + " -- " + ops.getTarget() + "  |||  " + ops.getSource());

    Operand source = ops.getSource();
    Operand target = ops.getTarget();

    if (!source.isIndexed() && !target.isIndexed())
    {
      if (target.isRegister())
      {
        throw new RuntimeException("Target of MOVB can't be a register: " + line);
      }

      if (source.getType() == Type.INTEGER)
      {
        // Source is INTEGER

        if (source.isRegister())
        {
          nCode.add("LDA #<" + source.getRegisterName());
          nCode.add("LDY #>" + source.getRegisterName());
        }
        else
        {
          nCode.add("LDA #<" + source.getAddress());
          nCode.add("LDY #>" + source.getAddress());
        }

        if (target.getType() == Type.INTEGER)
        {
          nCode.add("STA <" + target.getAddress());
        }
        else
        {
          nCode.add("; integer in A/Y to FAC");
          nCode.add("JSR $B391"); // integer in A/Y to FAC

          nCode.add("; FAC to A/Y");
          nCode.add("JSR $B1AA"); // FAC to A/Y
          nCode.add("STA <" + target.getAddress());
        }
      }
      else
      {
        // Source is REAL

        if (source.isRegister())
        {
          nCode.add("LDA <" + source.getRegisterName());
          nCode.add("LDY >" + source.getRegisterName());
        }
        else
        {
          nCode.add("LDA <" + source.getAddress());
          nCode.add("LDY >" + source.getAddress());
        }
        nCode.add("; Real in (A/Y) to FAC");
        nCode.add("JSR $BBA2"); // Real in (A/Y) to FAC

        nCode.add("; FAC to integer in A/Y");
        nCode.add("JSR $B1AA"); // FAC to integer in A/Y
        nCode.add("STA <" + target.getAddress());
      }
    }
    else
    {
      // Not supported yet
    }

  }

}
