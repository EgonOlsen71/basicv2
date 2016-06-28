package sixtyfour.plugins;

public interface DeviceProvider
  extends PrintConsumer
{
  void close(int fileNumber);


  void open(int fileNumber);


  void open(int fileNumber, int device);


  void open(int fileNumber, int device, int secondaryAddress);


  void open(int fileNumber, int device, int secondaryAddress, String fileName);


  boolean isOpen(int fileNumber);


  void dump(PrintConsumer pc, FileWrapper file, int fileNumber);

}
