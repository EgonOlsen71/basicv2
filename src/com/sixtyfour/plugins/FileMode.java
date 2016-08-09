/*
 * 
 */
package com.sixtyfour.plugins;

/**
 * The Enum FileMode.
 */
public enum FileMode
{
  
  /** The read. */
  READ('R'), 
 /** The write. */
 WRITE('W'), 
 /** The append. */
 APPEND('A'), 
 /** The modify. */
 MODIFY('M'), 
 /** The status. */
 STATUS('|');

  /** The short cut. */
  private char shortCut;


  /**
	 * Instantiates a new file mode.
	 * 
	 * @param shortCut
	 *            the short cut
	 */
  FileMode(char shortCut)
  {
    this.shortCut = shortCut;
  }


  /**
	 * Gets the file mode.
	 * 
	 * @param mode
	 *            the mode
	 * @return the file mode
	 */
  public static FileMode getFileMode(String mode)
  {
    if (mode == null || mode.isEmpty())
    {
      return READ;
    }
    char c = Character.toUpperCase(mode.charAt(0));
    for (FileMode fm : FileMode.values())
    {
      if (fm.shortCut == c)
      {
        return fm;
      }
    }
    return READ;
  }
}
