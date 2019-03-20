package com.sixtyfour.plugins;

/**
 * A channel for outputting text.
 */
public interface OutputChannel extends PrintConsumer {

	/**
	 * Gets the cursor position.
	 * 
	 * @return the cursor position
	 */
	int getCursor();

	/**
	 * Sets the cursor position.
	 * 
	 * @param cursor the new cursor position
	 */
	void setCursor(int cursor);

	/**
	 * Sets the print consumer.
	 * 
	 * @param otherConsumer the print consumer
	 * @param channel       the channel
	 */
	void setPrintConsumer(PrintConsumer otherConsumer, int channel);

	/**
	 * Gets the print consumer.
	 * 
	 * @return the print consumer
	 */
	PrintConsumer getPrintConsumer();

	/**
	 * Gets the channel.
	 * 
	 * @return the channel
	 */
	int getChannel();

}
