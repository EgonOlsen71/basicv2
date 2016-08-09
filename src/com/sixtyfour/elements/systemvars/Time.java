package com.sixtyfour.elements.systemvars;

import java.util.Calendar;
import java.util.Date;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.system.Machine;


/**
 * The Class Time.
 * 
 * @author EgonOlsen
 */
public class Time
  extends Variable
{
  
  /**
	 * Instantiates a new time.
	 */
  public Time()
  {
    super("TI", 0);
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.Variable#getValue()
   */
  @Override
  public Object getValue()
  {
    return null;
  }


  /* (non-Javadoc)
   * @see sixtyfour.elements.Variable#eval(sixtyfour.system.Machine)
   */
  @Override
  public Object eval(Machine machine)
  {
    TimeDate tid = (TimeDate) machine.getVariable("TI$");
    Date td = tid.getIntervalValue();
    Calendar cally = Calendar.getInstance();
    cally.setTime(td);
    int h = cally.get(Calendar.HOUR_OF_DAY);
    int m = cally.get(Calendar.MINUTE);
    int s = cally.get(Calendar.SECOND);
    int ss = cally.get(Calendar.MILLISECOND);
    return (int) ((ss + 1000 * s + 1000 * 60 * m + 1000 * 60 * 60 * h) / (1000f / 60f));
  }

}
