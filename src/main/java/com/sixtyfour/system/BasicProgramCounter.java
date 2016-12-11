package com.sixtyfour.system;

/**
 * A BasicProgramCounter indicates a position inside a basic program. In
 * addition, it can signal the interpreter to stop or end a program.
 */
public class BasicProgramCounter {

	/** The line count */
	private int lineCnt;

	/** The line position */
	private int linePos;

	/** The line number */
	private int lineNumber = -1;

	/** End indicator */
	private boolean end = false;

	/** Stop indicator */
	private boolean stop = false;

	/** Skip indicator */
	private boolean skip = false;

	/** List indicator */
	private boolean list = false;

	/**
	 * Instantiates a new program counter.
	 * 
	 * @param cnt
	 *            the line count
	 * @param pos
	 *            the position in the line
	 */
	public BasicProgramCounter(int cnt, int pos) {
		this.lineCnt = cnt;
		this.linePos = pos;
	}

	/**
	 * Returns the position in the line.
	 * 
	 * @return the position
	 */
	public int getLinePos() {
		return linePos;
	}

	/**
	 * Sets the position in the line.
	 * 
	 * @param linePos
	 *            the new line position
	 */
	public void setLinePos(int linePos) {
		this.linePos = linePos;
	}

	/**
	 * Returns the line count.
	 * 
	 * @return the line count
	 */
	public int getLineCnt() {
		return lineCnt;
	}

	/**
	 * Sets the line count.
	 * 
	 * @param lineCnt
	 *            the new line count
	 */
	public void setLineCnt(int lineCnt) {
		this.lineCnt = lineCnt;
	}

	/**
	 * Checks if the program is supposed to end.
	 * 
	 * @return true, if it is.
	 */
	public boolean isEnd() {
		return end;
	}

	/**
	 * Sets if the program is supposed to end.
	 * 
	 * @param end
	 *            Is it?
	 */
	public void setEnd(boolean end) {
		this.end = end;
	}

	/**
	 * Returns the line number.
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
	 * Checks if the program is supposed to skip the rest of the line.
	 * 
	 * @return true, if it is
	 */
	public boolean isSkip() {
		return skip;
	}

	/**
	 * Sets if the program is supposed to skip the rest of the line.
	 * 
	 * @param skip
	 *            Is it?
	 */
	public void setSkip(boolean skip) {
		this.skip = skip;
	}

	/**
	 * Checks if the program is supposed to stop.
	 * 
	 * @return true, if it is
	 */
	public boolean isStop() {
		return stop;
	}

	/**
	 * Sets if the program is supposed to stop.
	 * 
	 * @param stop
	 *            Is it?
	 */
	public void setStop(boolean stop) {
		this.stop = stop;
	}

	/**
	 * Checks if the runtime has encountered a list command.
	 * 
	 * @return true, if it has
	 */
	public boolean isList() {
		return list;
	}

	/**
	 * Sets if the runtime has encountered a list command.
	 * 
	 * @param list
	 *            Has it?
	 */
	public void setList(boolean list) {
		this.list = list;
	}
}
