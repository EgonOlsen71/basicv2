/*
 * 
 */
package sixtyfour.plugins;

/**
 * The Interface OutputChannel.
 */
public interface OutputChannel
  extends PrintConsumer
{
  
  /**
	 * Gets the cursor.
	 * 
	 * @return the cursor
	 */
  int getCursor();


  /**
	 * Sets the cursor.
	 * 
	 * @param cursor
	 *            the new cursor
	 */
  void setCursor(int cursor);


  /**
	 * Sets the print consumer.
	 * 
	 * @param otherConsumer
	 *            the other consumer
	 * @param channel
	 *            the channel
	 */
  void setPrintConsumer(PrintConsumer otherConsumer, int channel);
  
  /**
	 * Gets the prints the consumer.
	 * 
	 * @return the prints the consumer
	 */
  PrintConsumer getPrintConsumer();
  
  /**
	 * Gets the channel.
	 * 
	 * @return the channel
	 */
  int getChannel();
  
}
