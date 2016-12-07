package com.sixtyfour.templating;

/**
 * A part of a template. Used for parsing the template, so there's no need to use this directly.
 */
public class TemplatePart {

	/** The first line. */
	private int firstLine = -1;

	/** The last line. */
	private int lastLine = -1;

	/** The content. */
	private StringBuilder content = new StringBuilder();

	/** The dynamic. */
	private boolean dynamic;

	/**
	 * Instantiates a new template part.
	 */
	public TemplatePart() {
		dynamic = true;
	}

	/**
	 * Instantiates a new template part.
	 * 
	 * @param staticText
	 *            the static text
	 */
	public TemplatePart(String staticText) {
		content.append(staticText);
		dynamic = false;
	}

	/**
	 * Reset.
	 */
	public void reset() {
		if (dynamic) {
			content.setLength(0);
		}
	}

	/**
	 * Append.
	 * 
	 * @param txt
	 *            the txt
	 */
	public void append(String txt) {
		content.append(txt);
	}

	/**
	 * Gets the first line.
	 * 
	 * @return the first line
	 */
	public int getFirstLine() {
		return firstLine;
	}

	/**
	 * Sets the first line.
	 * 
	 * @param firstLine
	 *            the new first line
	 */
	public void setFirstLine(int firstLine) {
		this.firstLine = firstLine;
	}

	/**
	 * Gets the last line.
	 * 
	 * @return the last line
	 */
	public int getLastLine() {
		return lastLine;
	}

	/**
	 * Sets the last line.
	 * 
	 * @param lastLine
	 *            the new last line
	 */
	public void setLastLine(int lastLine) {
		this.lastLine = lastLine;
	}

	/**
	 * Gets the content.
	 * 
	 * @return the content
	 */
	public String getContent() {
		return content.toString();
	}

	/**
	 * Checks if is dynamic.
	 * 
	 * @return true, if is dynamic
	 */
	public boolean isDynamic() {
		return dynamic;
	}
}
