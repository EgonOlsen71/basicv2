package com.sixtyfour.elements.mnemonics;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


/**
 *
 */
public class MnemonicList
{
  public static final List<Mnemonic> MNEMONICS = Collections.unmodifiableList(new ArrayList<Mnemonic>()
  {
    private static final long serialVersionUID = 1L;

    {
      this.add(new Lda());
      this.add(new Ldx());
      this.add(new Ldy());
    }
  });


  public static List<Mnemonic> getMnemonics()
  {
    return MNEMONICS;
  }

}
