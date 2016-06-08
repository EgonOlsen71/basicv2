package sixtyfour;

public class Logger
{
  public static void log(String msg)
  {
    System.out.println(msg);
  }


  public static void log(String msg, Throwable t)
  {
    System.out.println(msg);
    t.printStackTrace();
  }


  public static void log(Throwable t)
  {
    t.printStackTrace();
  }

}
