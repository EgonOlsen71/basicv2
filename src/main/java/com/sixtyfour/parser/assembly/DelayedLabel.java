package com.sixtyfour.parser.assembly;

public class DelayedLabel {

	private String label;
	private boolean low;
	private boolean high;

	public DelayedLabel(String label, boolean low, boolean high) {
		this.label = label;
		this.low = low;
		this.high = high;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public boolean isLow() {
		return low;
	}

	public void setLow(boolean low) {
		this.low = low;
	}

	public boolean isHigh() {
		return high;
	}

	public void setHigh(boolean high) {
		this.high = high;
	}

}
