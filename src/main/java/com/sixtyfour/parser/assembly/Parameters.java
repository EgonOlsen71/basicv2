package com.sixtyfour.parser.assembly;

/**
 * A (typed) parameter entry in the assembler listing.
 * 
 * @author EgonOlsen
 * 
 */
public class Parameters {
	private Integer value;
	private Integer addr;
	private boolean x;
	private boolean y;
	private boolean indirect;
	private boolean zeropage;

	/**
	 * Creates a new instance.
	 */
	public Parameters() {
		//
	}

	/**
	 * Returns the value. Can be null, if it's an address parameter.
	 * 
	 * @return the value
	 */
	public Integer getValue() {
		return value;
	}

	/**
	 * Sets the value. While this takes an Integer as parameter, only byte
	 * values are valid. Everything else will be rejected and cause an
	 * exception.
	 * 
	 * @param value
	 *            the value
	 */
	public void setValue(Integer value) {
		if (value < -128 || value > 255) {
			throw new RuntimeException("Value too large: " + value);
		}
		this.value = value;
	}

	/**
	 * Returns the address. Can be null, if it's a value parameter.
	 * 
	 * @return
	 */
	public Integer getAddr() {
		return addr;
	}

	/**
	 * Sets the address.
	 * 
	 * @param addr
	 *            the address
	 */
	public void setAddr(Integer addr) {
		this.addr = addr;
	}

	/**
	 * Is there an additional X-index applied?
	 * 
	 * @return is there?
	 */
	public boolean isX() {
		return x;
	}

	/**
	 * Sets if there is an additional X-index applied.
	 * 
	 * @param x
	 *            X-index?
	 */
	public void setX(boolean x) {
		this.x = x;
	}

	/**
	 * Is there an additional Y-index applied?
	 * 
	 * @return is there?
	 */
	public boolean isY() {
		return y;
	}

	/**
	 * Sets if there is an additional Y-index applied.
	 * 
	 * @param x
	 *            Y-index?
	 */
	public void setY(boolean y) {
		this.y = y;
	}

	/**
	 * Is indirect addressing being used?
	 * 
	 * @return is it?
	 */
	public boolean isIndirect() {
		return indirect;
	}

	/**
	 * Sets if indirect addressing is used.
	 * 
	 * @param indirect
	 *            indirect addressing?
	 */
	public void setIndirect(boolean indirect) {
		this.indirect = indirect;
	}

	/**
	 * Is this address parameter located in the zeropage?
	 * 
	 * @return is it?
	 */
	public boolean isZeropage() {
		return zeropage;
	}

	/**
	 * Sets if this address parameter is located in the zeropage.
	 * 
	 * @param zeropage
	 *            in the zeoropage?
	 */
	public void setZeropage(boolean zeropage) {
		this.zeropage = zeropage;
	}

}
