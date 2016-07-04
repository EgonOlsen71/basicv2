/*
 * 
 */
package sixtyfour.plugins.impl;

import sixtyfour.plugins.OutputChannel;
import sixtyfour.plugins.PrintConsumer;


/**
 * The Class ConsoleOutputChannel.
 */
public class ConsoleOutputChannel
  implements OutputChannel
{
  
  /** The cursor. */
  private int cursor = 0;
  
  /** The channel. */
  private int channel = 0;
  
  /** The other consumer. */
  private PrintConsumer otherConsumer = null;


  /*
   * (non-Javadoc)
   * @see sixtyfour.plugins.PrintConsumer#print(int, java.lang.String)
   */
  @Override
  public void print(int id, String txt)
  {
    if (otherConsumer != null)
    {
      otherConsumer.print(channel, txt);
    }
    else
    {
      setCursor(getCursor() + txt.length());
      System.out.print(txt);
    }
  }


  /*
   * (non-Javadoc)
   * @see sixtyfour.plugins.PrintConsumer#println(int, java.lang.String)
   */
  @Override
  public void println(int id, String txt)
  {
    if (otherConsumer != null)
    {
      otherConsumer.println(channel, txt);
    }
    else
    {
      System.out.println(txt);
      setCursor(0);
    }
  }


  /*
   * (non-Javadoc)
   * @see sixtyfour.system.OutputChannel#getCursor()
   */
  @Override
  public int getCursor()
  {
    return cursor;
  }


  /*
   * (non-Javadoc)
   * @see sixtyfour.system.OutputChannel#setCursor(int)
   */
  @Override
  public void setCursor(int cursor)
  {
    this.cursor = cursor;
  }


  /*
   * (non-Javadoc)
   * @see sixtyfour.plugins.OutputChannel#setPrintConsumer(sixtyfour.plugins.PrintConsumer, int)
   */
  @Override
  public void setPrintConsumer(PrintConsumer otherConsumer, int channel)
  {
    this.otherConsumer = otherConsumer;
    this.channel = channel;
  }


  /*
   * (non-Javadoc)
   * @see sixtyfour.plugins.OutputChannel#getPrintConsumer()
   */
  @Override
  public PrintConsumer getPrintConsumer()
  {
    return otherConsumer;
  }


  /*
   * (non-Javadoc)
   * @see sixtyfour.plugins.OutputChannel#getChannel()
   */
  @Override
  public int getChannel()
  {
    return channel;
  }

}
