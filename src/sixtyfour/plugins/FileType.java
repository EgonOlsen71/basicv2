package sixtyfour.plugins;

public enum FileType
{
  PRG('P'), SEQ('S'), USR('U'), REL('L');

  private char shortCut;


  FileType(char shortCut)
  {
    this.shortCut = shortCut;
  }


  public static FileType getFileType(String type)
  {
    if (type == null || type.isEmpty())
    {
      return PRG;
    }
    char c = Character.toUpperCase(type.charAt(0));
    for (FileType fm : FileType.values())
    {
      if (fm.shortCut == c)
      {
        return fm;
      }
    }
    return PRG;
  }
}
