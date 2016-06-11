package sixtyfour.system;

public class OutputChannel
{
  private int cursor = 0;

  public void print(String txt)
  {
    txt = clean(txt);
    setCursor(getCursor() + txt.length());
    System.out.print(txt);
  }


  public void println(String txt)
  {
    txt = clean(txt);
    System.out.println(txt);
    setCursor(0);
  }


  private String clean(String txt)
  {
    return txt.replace("\n", "").replace("\r", "");
  }


  public int getCursor()
  {
    return cursor;
  }


  public void setCursor(int cursor)
  {
    this.cursor = cursor;
  }

}
