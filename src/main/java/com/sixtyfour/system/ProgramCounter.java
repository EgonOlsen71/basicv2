package com.sixtyfour.system;

/**
 * The Class ProgramCounter.
 */
public class ProgramCounter {

	/** The line cnt. */
	private int lineCnt;

	/** The line pos. */
	private int linePos;

	/** The line number. */
	private int lineNumber = -1;

	/** The end. */
	private boolean end = false;

	/** The stop. */
	private boolean stop = false;

	/** The skip. */
	private boolean skip = false;

	/** The list. */
	private boolean list = false;

	/**
	 * Instantiates a new program counter.
	 * 
	 * @param cnt
	 *            the cnt
	 * @param pos
	 *            the pos
	 */
	public ProgramCounter(int cnt, int pos) {
		this.lineCnt = cnt;
		this.linePos = pos;
	}

	/**
	 * Gets the line pos.
	 * 
	 * @return the line pos
	 */
	public int getLinePos() {
		return linePos;
	}

	/**
	 * Sets the line pos.
	 * 
	 * @param linePos
	 *            the new line pos
	 */
	public void setLinePos(int linePos) {
		this.linePos = linePos;
	}

	/**
	 * Gets the line cnt.
	 * 
	 * @return the line cnt
	 */
	public int getLineCnt() {
		return lineCnt;
	}

	/**
	 * Sets the line cnt.
	 * 
	 * @param lineCnt
	 *            the new line cnt
	 */
	public void setLineCnt(int lineCnt) {
		this.lineCnt = lineCnt;
	}

	/**
	 * Checks if is end.
	 * 
	 * @return true, if is end
	 */
	public boolean isEnd() {
		return end;
	}

	/**
	 * Sets the end.
	 * 
	 * @param end
	 *            the new end
	 */
	public void setEnd(boolean end) {
		this.end = end;
	}

	/**
	 * Gets the line number.
	 * 
	 * @return the line number
	 */
	public int getLineNumber() {
		return lineNumber;
	}

	/**
	 * Sets the line number.
	 * 
	 * @param lineNumber
	 *            the new line number
	 */
	public void setLineNumber(int lineNumber) {
		this.lineNumber = lineNumber;
	}

	/**
	 * Checks if is skip.
	 * 
	 * @return true, if is skip
	 */
	public boolean isSkip() {
		return skip;
	}

	/**
	 * Sets the skip.
	 * 
	 * @param skip
	 *            the new skip
	 */
	public void setSkip(boolean skip) {
		this.skip = skip;
	}

	/**
	 * Checks if is stop.
	 * 
	 * @return true, if is stop
	 */
	public boolean isStop() {
		return stop;
	}

	/**
	 * Sets the stop.
	 * 
	 * @param stop
	 *            the new stop
	 */
	public void setStop(boolean stop) {
		this.stop = stop;
	}

	/**
	 * Checks if is list.
	 * 
	 * @return true, if is list
	 */
	public boolean isList() {
		return list;
	}

	/**
	 * Sets the list.
	 * 
	 * @param list
	 *            the new list
	 */
	public void setList(boolean list) {
		this.list = list;
	}
}
