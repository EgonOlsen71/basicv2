package com.sixtyfour.elements.systemvars;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.system.Machine;


/**
 * The Class TimeDate.
 * 
 * @author EgonOlsen
 */
public class TimeDate
  extends Variable
{
  
  /** The sdf. */
  private SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
  
  /** The init time. */
  private long initTime = 0;
  
  /** The set time. */
  private long setTime = 0;


  /**
	 * Instantiates a new time date.
	 */
  public TimeDate()
  {
    super("TI$", "000000");
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.Variable#getValue()
   */
  @Override
  public Object getValue()
  {
    return sdf.format(getIntervalValue());
  }


  /**
	 * Gets the interval value.
	 * 
	 * @return the interval value
	 */
  public Date getIntervalValue()
  {
    long now = System.currentTimeMillis();
    long dif = now - setTime;
    long add = initTime + dif;
    return new java.util.Date(add);
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.Variable#eval(sixtyfour.system.Machine)
   */
  @Override
  public Object eval(Machine machine)
  {
    return getValue();
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.Variable#setValue(java.lang.Object)
   */
  @Override
  public void setValue(Object value)
  {
    super.setValue(value);
    if (value == null || value.toString().isEmpty())
    {
      return;
    }
    try
    {
      SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
      String val = value.toString();
      if (val.length() != 6)
      {
        throw new RuntimeException();
      }
      Date date = sdf.parse(val);
      initTime = date.getTime();
      setTime = System.currentTimeMillis();
    }
    catch (Exception e)
    {
      throw new RuntimeException("Illegal quantity error: " + value);
    }
  }

}
