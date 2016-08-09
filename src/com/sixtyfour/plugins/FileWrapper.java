package com.sixtyfour.plugins;

import java.util.ArrayList;
import java.util.List;

/**
 * The Class FileWrapper.
 */
public class FileWrapper {
	
	/** The device number. */
	private int deviceNumber;
	
	/** The secondary address. */
	private int secondaryAddress;
	
	/** The file type. */
	private FileType fileType;
	
	/** The file name. */
	private String fileName;
	
	/** The mode. */
	private FileMode mode;
	
	/** The record length. */
	private int recordLength;
	
	/** The content. */
	private List<String> content;
	
	/** The position. */
	private int position = 0;
	
	/** The pointer. */
	private int pointer = 0;
	
	/** The content as string. */
	private String contentAsString;

	/**
	 * Instantiates a new file wrapper.
	 */
	public FileWrapper() {
		content = new ArrayList<String>();
	}

	/**
	 * Gets the record length.
	 * 
	 * @return the record length
	 */
	public int getRecordLength() {
		return recordLength;
	}

	/**
	 * Sets the record length.
	 * 
	 * @param recordLength
	 *            the new record length
	 */
	public void setRecordLength(int recordLength) {
		this.recordLength = recordLength;
	}

	/**
	 * Gets the file name.
	 * 
	 * @return the file name
	 */
	public String getFileName() {
		return fileName;
	}

	/**
	 * Sets the file name.
	 * 
	 * @param fileName
	 *            the new file name
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * Gets the device number.
	 * 
	 * @return the device number
	 */
	public int getDeviceNumber() {
		return deviceNumber;
	}

	/**
	 * Sets the device number.
	 * 
	 * @param deviceNumber
	 *            the new device number
	 */
	public void setDeviceNumber(int deviceNumber) {
		this.deviceNumber = deviceNumber;
	}

	/**
	 * Gets the secondary address.
	 * 
	 * @return the secondary address
	 */
	public int getSecondaryAddress() {
		return secondaryAddress;
	}

	/**
	 * Sets the secondary address.
	 * 
	 * @param secondaryAddress
	 *            the new secondary address
	 */
	public void setSecondaryAddress(int secondaryAddress) {
		this.secondaryAddress = secondaryAddress;
	}

	/**
	 * Gets the content.
	 * 
	 * @return the content
	 */
	public List<String> getContent() {
		return content;
	}

	/**
	 * Sets the content.
	 * 
	 * @param content
	 *            the new content
	 */
	public void setContent(List<String> content) {
		this.content = content;
		reset();
	}

	/**
	 * Prints the.
	 * 
	 * @param txt
	 *            the txt
	 */
	public void print(String txt) {
		// System.out.print(txt);
		this.content.add(txt);
		position++;
	}

	/**
	 * Gets the file type.
	 * 
	 * @return the file type
	 */
	public FileType getFileType() {
		return fileType;
	}

	/**
	 * Sets the file type.
	 * 
	 * @param fileType
	 *            the new file type
	 */
	public void setFileType(FileType fileType) {
		this.fileType = fileType;
	}

	/**
	 * Gets the file mode.
	 * 
	 * @return the file mode
	 */
	public FileMode getFileMode() {
		return mode;
	}

	/**
	 * Sets the file mode.
	 * 
	 * @param mode
	 *            the new file mode
	 */
	public void setFileMode(FileMode mode) {
		this.mode = mode;
	}

	/**
	 * Gets the position.
	 * 
	 * @return the position
	 */
	public int getPosition() {
		return position;
	}

	/**
	 * Gets the pointer.
	 * 
	 * @return the pointer
	 */
	public int getPointer() {
		return pointer;
	}

	/**
	 * Reset.
	 */
	public void reset() {
		this.position = 0;
		this.pointer = 0;
	}

	/**
	 * Next position.
	 */
	public void nextPosition() {
		position++;
	}

	/**
	 * Inc pointer.
	 */
	public void incPointer() {
		pointer++;
	}

	/**
	 * Gets the content as string.
	 * 
	 * @return the content as string
	 */
	public String getContentAsString() {
		if (contentAsString == null) {
			StringBuilder sb = new StringBuilder();
			for (String line : content) {
				sb.append(line);
			}
			contentAsString = sb.toString();
		}
		return contentAsString;
	}

}
