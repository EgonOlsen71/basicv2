package sixtyfour.elements;

public class Constant<T>
  implements Atom
{
  private T value;


  public Constant(T value)
  {
    this.value = value;
  }


  public T getValue()
  {
    return value;
  }


  public String getStringValue()
  {
    return value.toString();
  }


  public float getRealValue()
  {
    if (value instanceof Float)
    {
      return (Float) value;
    }

    if (value instanceof Integer)
    {
      return Float.valueOf((Integer) value);
    }

    return Float.valueOf(this.getStringValue());
  }


  public int getIntValue()
  {
    if (value instanceof Float)
    {
      return ((Float) value).intValue();
    }

    if (value instanceof Integer)
    {
      return (Integer) value;
    }

    return Integer.valueOf(this.getStringValue());
  }


  @Override
  public String toString()
  {
    return value.toString();
  }

}
