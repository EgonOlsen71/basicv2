package sixtyfour.plugins;

public interface OutputChannel
  extends PrintConsumer
{
  int getCursor();


  void setCursor(int cursor);


  void setPrintConsumer(PrintConsumer otherConsumer, int channel);
  
  PrintConsumer getPrintConsumer();
  
  int getChannel();
  
}
