package sixtyfour;

public class OutputChannel
{
  private static int cursor = 0;

  public static void print(String txt)
  {
    txt = clean(txt);
    setCursor(getCursor() + txt.length());
    System.out.print(txt);
  }


  public static void println(String txt)
  {
    txt = clean(txt);
    System.out.println(txt);
    setCursor(0);
  }


  private static String clean(String txt)
  {
    return txt.replace("\n", "").replace("\r", "");
  }


  public static int getCursor()
  {
    return cursor;
  }


  public static void setCursor(int cursor)
  {
    OutputChannel.cursor = cursor;
  }

}
