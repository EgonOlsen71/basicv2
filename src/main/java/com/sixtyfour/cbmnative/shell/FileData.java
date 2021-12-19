package com.sixtyfour.cbmnative.shell;

/**
 * Simple wrapper around a file
 * 
 * @author EgonOlsen
 *
 */
public class FileData {

	private byte[] data;

	private int address;

	public byte[] getData() {
		return data;
	}

	public void setData(byte[] data) {
		this.data = data;
	}

	public int getAddress() {
		return address;
	}

	public void setAddress(int address) {
		this.address = address;
	}

	public int getLength() {
		return data.length;
	}

}
