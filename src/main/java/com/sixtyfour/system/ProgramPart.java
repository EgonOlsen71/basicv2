package com.sixtyfour.system;

/**
 * A part of a program.
 * 
 * @author EgonOlsen
 * 
 */
public class ProgramPart {

	private int address;
	private int[] bytes;
	private int[] lineAddresses;

	/**
	 * Creates a new instance.
	 */
	public ProgramPart() {
		//
	}

	/**
	 * Gets the address in memory at which this part belongs.
	 * 
	 * @return the address
	 */
	public int getAddress() {
		return address;
	}

	/**
	 * Returns the address in memory at which this part belongs.
	 * 
	 * @param address
	 *            the address
	 */
	public void setAddress(int address) {
		this.address = address;
	}

	/**
	 * Returns the actual bytes of this part. As usual, this is returned as an
	 * array of int[] but actually contains bytes.
	 * 
	 * @return the bytes
	 */
	public int[] getBytes() {
		return bytes;
	}

	/**
	 * Sets the bytes of this part. As usual, this is set as an array of int[]
	 * but actually has to contain bytes.
	 * 
	 * @param bytes
	 */
	public void setBytes(int[] bytes) {
		this.bytes = bytes;
	}

	/**
	 * Returns the addresses on which the actual opcodes start. This isn't
	 * needed for execution but for debugging output only.
	 * 
	 * @return the addresses
	 */
	public int[] getLineAddresses() {
		return lineAddresses;
	}

	/**
	 * Sets the addresses on which the actual opcodes start.
	 * 
	 * @param lineAddresses
	 *            the addresses
	 */
	public void setLineAddresses(int[] lineAddresses) {
		this.lineAddresses = lineAddresses;
	}

}
