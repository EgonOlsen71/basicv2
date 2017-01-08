package com.sixtyfour.templating;

import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.PrintConsumer;

/** 
 * An output channel for the templates. Template content shouldn't be printed onto the console, so
 * it will be redirected into here instead.
 * 
 * @author EgonOlsen
 */
public class TemplateOutputChannel implements OutputChannel {

	/** The cursor. */
	private int cursor = 0;

	/** The channel. */
	private int channel = 0;
 
	/** The other consumer. */
	private PrintConsumer otherConsumer = null;

	/** The result. */
	private StringBuilder result = new StringBuilder();

	/**
	 * Instantiates a new template output channel.
	 */
	public TemplateOutputChannel() {
		//
	}

	/**
	 * Reset.
	 */
	public void reset() {
		cursor = 0;
		channel = 0;
		otherConsumer = null;
		result.setLength(0);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.PrintConsumer#print(int, java.lang.String)
	 */
	@Override
	public void print(int id, String txt) {
		if (otherConsumer != null) {
			otherConsumer.print(channel, txt);
		} else {
			setCursor(getCursor() + txt.length());
			result.append(txt);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.PrintConsumer#println(int, java.lang.String)
	 */
	@Override
	public void println(int id, String txt) {
		if (otherConsumer != null) {
			otherConsumer.println(channel, txt);
		} else {
			result.append(txt);
			result.append("\n");
			setCursor(0);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.system.OutputChannel#getCursor()
	 */
	@Override
	public int getCursor() {
		return cursor;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.system.OutputChannel#setCursor(int)
	 */
	@Override
	public void setCursor(int cursor) {
		this.cursor = cursor;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.OutputChannel#setPrintConsumer(sixtyfour.plugins.
	 * PrintConsumer, int)
	 */
	@Override
	public void setPrintConsumer(PrintConsumer otherConsumer, int channel) {
		this.otherConsumer = otherConsumer;
		this.channel = channel;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.OutputChannel#getPrintConsumer()
	 */
	@Override
	public PrintConsumer getPrintConsumer() {
		return otherConsumer;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.OutputChannel#getChannel()
	 */
	@Override
	public int getChannel() {
		return channel;
	}

	/**
	 * Gets the result.
	 * 
	 * @return the result
	 */
	public String getResult() {
		return result.toString();
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrint(int, java.lang.String)
	 */
	@Override
	public void systemPrint(int id, String txt) {
		this.print(id, txt);
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrintln(int, java.lang.String)
	 */
	@Override
	public void systemPrintln(int id, String txt) {
		this.println(id, txt);	
	}

}
