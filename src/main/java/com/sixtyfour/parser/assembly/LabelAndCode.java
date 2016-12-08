package com.sixtyfour.parser.assembly;

public class LabelAndCode
{

  private String label;
  private String code;


  public LabelAndCode(String label, String code)
  {
    this.setLabel(label);
    this.setCode(code);
  }


  public String getLabel()
  {
    return label;
  }


  public void setLabel(String label)
  {
    this.label = label;
  }


  public String getCode()
  {
    return code;
  }


  public void setCode(String code)
  {
    this.code = code;
  }


  @Override
  public String toString()
  {
    return "Label: " + label + " / Code: " + code;
  }

}
