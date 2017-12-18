package com.sixtyfour.parser.assembly;

/**
 * A DelayedLabel is a label that has a reference in the code that is used
 * before it actually gets defined. These can be jumps to labels later in the
 * code and such things. A delayed label's actual value can be used as a 16bit
 * value or as low/high byte only.
 * 
 * @author EgonOlsen
 * 
 */
public class DelayedLabel {

	private String label;
	private boolean low;
	private boolean high;
	private int add;

	/**
	 * Creates a new instance.
	 * 
	 * @param label
	 *            the label's name
	 * @param low
	 *            low byte only?
	 * @param high
	 *            high byte only?
	 */
	public DelayedLabel(String label, boolean low, boolean high, int add) {
		// System.out.println("HONK: Label created: "+label+"/"+add);
		this.label = label;
		this.low = low;
		this.high = high;
		this.add = add;
	}

	/**
	 * Returns the label's name.
	 * 
	 * @return the name
	 */
	public String getLabel() {
		return label;
	}

	/**
	 * Sets the label's name.
	 * 
	 * @param label
	 *            the name
	 */
	public void setLabel(String label) {
		this.label = label;
	}

	/**
	 * Low byte only?
	 * 
	 * @return low byte only?
	 */
	public boolean isLow() {
		return low;
	}

	/**
	 * Sets if low byte only?
	 * 
	 * @param low
	 *            low byte only?
	 */
	public void setLow(boolean low) {
		this.low = low;
	}

	/**
	 * High byte only?
	 * 
	 * @return high byte only?
	 */
	public boolean isHigh() {
		return high;
	}

	/**
	 * Sets if high byte only?
	 * 
	 * @param high
	 *            high byte only?
	 */
	public void setHigh(boolean high) {
		this.high = high;
	}

	@Override
	public String toString() {
		return this.label + "/" + this.high + "/" + this.low;
	}

	/**
	 * @return
	 */
	public int getAdd() {
		return add;
	}

	/**
	 * @param add
	 */
	public void setAdd(int add) {
		this.add = add;
	}

}
