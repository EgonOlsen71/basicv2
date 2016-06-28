package sixtyfour.plugins;

import java.util.ArrayList;
import java.util.List;


public class FileWrapper
{
  private int deviceNumber;
  private int secondaryAddress;
  private FileType fileType;
  private String fileName;
  private FileMode mode;
  private int recordLength;
  private List<String> content;


  public FileWrapper()
  {
    content = new ArrayList<String>();
  }


  public int getRecordLength()
  {
    return recordLength;
  }


  public void setRecordLength(int recordLength)
  {
    this.recordLength = recordLength;
  }


  public String getFileName()
  {
    return fileName;
  }


  public void setFileName(String fileName)
  {
    this.fileName = fileName;
  }


  public int getDeviceNumber()
  {
    return deviceNumber;
  }


  public void setDeviceNumber(int deviceNumber)
  {
    this.deviceNumber = deviceNumber;
  }


  public int getSecondaryAddress()
  {
    return secondaryAddress;
  }


  public void setSecondaryAddress(int secondaryAddress)
  {
    this.secondaryAddress = secondaryAddress;
  }


  public List<String> getContent()
  {
    return content;
  }


  public void setContent(List<String> content)
  {
    this.content = content;
  }


  public void print(String txt)
  {
    //System.out.print(txt);
    this.content.add(txt);
  }


  public FileType getFileType()
  {
    return fileType;
  }


  public void setFileType(FileType fileType)
  {
    this.fileType = fileType;
  }


  public FileMode getFileMode()
  {
    return mode;
  }


  public void setFileMode(FileMode mode)
  {
    this.mode = mode;
  }

}
