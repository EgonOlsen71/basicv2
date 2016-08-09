package com.sixtyfour.plugins;

/**
 * The Interface DeviceProvider.
 */
public interface DeviceProvider
  extends PrintConsumer
{
  
  /**
	 * Close.
	 * 
	 * @param fileNumber
	 *            the file number
	 */
  void close(int fileNumber);


  /**
	 * Open.
	 * 
	 * @param fileNumber
	 *            the file number
	 */
  void open(int fileNumber);


  /**
	 * Open.
	 * 
	 * @param fileNumber
	 *            the file number
	 * @param device
	 *            the device
	 */
  void open(int fileNumber, int device);


  /**
	 * Open.
	 * 
	 * @param fileNumber
	 *            the file number
	 * @param device
	 *            the device
	 * @param secondaryAddress
	 *            the secondary address
	 */
  void open(int fileNumber, int device, int secondaryAddress);


  /**
	 * Open.
	 * 
	 * @param fileNumber
	 *            the file number
	 * @param device
	 *            the device
	 * @param secondaryAddress
	 *            the secondary address
	 * @param fileName
	 *            the file name
	 */
  void open(int fileNumber, int device, int secondaryAddress, String fileName);


  /**
	 * Checks if is open.
	 * 
	 * @param fileNumber
	 *            the file number
	 * @return true, if is open
	 */
  boolean isOpen(int fileNumber);


  /**
	 * Dump.
	 * 
	 * @param pc
	 *            the pc
	 * @param file
	 *            the file
	 * @param fileNumber
	 *            the file number
	 */
  void dump(PrintConsumer pc, FileWrapper file, int fileNumber);


  /**
	 * Input string.
	 * 
	 * @param fileNumber
	 *            the file number
	 * @return the string
	 */
  String inputString(int fileNumber);


  /**
	 * Input number.
	 * 
	 * @param fileNumber
	 *            the file number
	 * @return the float
	 */
  Float inputNumber(int fileNumber);


  /**
	 * Gets the char.
	 * 
	 * @param fileNumber
	 *            the file number
	 * @return the char
	 */
  char getChar(int fileNumber);


  /**
	 * Save.
	 * 
	 * @param fileName
	 *            the file name
	 * @param device
	 *            the device
	 * @param secondary
	 *            the secondary
	 */
  void save(String fileName, int device, int secondary);


  /**
	 * Load.
	 * 
	 * @param fileName
	 *            the file name
	 * @param device
	 *            the device
	 * @param secondary
	 *            the secondary
	 */
  void load(String fileName, int device, int secondary);


  /**
	 * Verify.
	 * 
	 * @param fileName
	 *            the file name
	 * @param device
	 *            the device
	 * @param secondary
	 *            the secondary
	 */
  void verify(String fileName, int device, int secondary);

}
