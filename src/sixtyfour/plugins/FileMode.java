package sixtyfour.plugins;

public enum FileMode
{
  READ('R'), WRITE('W'), APPEND('A'), MODIFY('M'), STATUS('|');

  private char shortCut;


  FileMode(char shortCut)
  {
    this.shortCut = shortCut;
  }


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
