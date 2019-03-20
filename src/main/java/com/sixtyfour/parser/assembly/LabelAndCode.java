package com.sixtyfour.parser.assembly;

/**
 * A container object for the label and the code in a line separated into two
 * strings.
 * 
 * @author EgonOlsen
 * 
 */
public class LabelAndCode {

	private String label;
	private String code;

	/**
	 * Creates a new instance.
	 * 
	 * @param label the label
	 * @param code  the code
	 */
	public LabelAndCode(String label, String code) {
		this.setLabel(label);
		this.setCode(code);
	}

	/**
	 * Gets the label
	 * 
	 * @return the label
	 */
	public String getLabel() {
		return label;
	}

	/**
	 * Sets the label
	 * 
	 * @param label the label
	 */
	public void setLabel(String label) {
		this.label = label;
	}

	/**
	 * Gets the code
	 * 
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * Sets the code
	 * 
	 * @param code the code
	 */
	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "Label: " + label + " / Code: " + code;
	}

}
