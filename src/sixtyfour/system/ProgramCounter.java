package sixtyfour.system;

public class ProgramCounter {

	private int lineCnt;
	private int linePos;
	private int lineNumber = -1;
	private boolean end = false;
	private boolean stop = false;
	private boolean skip = false;

	public ProgramCounter(int cnt, int pos) {
		this.lineCnt = cnt;
		this.linePos = pos;
	}

	public int getLinePos() {
		return linePos;
	}

	public void setLinePos(int linePos) {
		this.linePos = linePos;
	}

	public int getLineCnt() {
		return lineCnt;
	}

	public void setLineCnt(int lineCnt) {
		this.lineCnt = lineCnt;
	}

	public boolean isEnd() {
		return end;
	}

	public void setEnd(boolean end) {
		this.end = end;
	}

	public int getLineNumber() {
		return lineNumber;
	}

	public void setLineNumber(int lineNumber) {
		this.lineNumber = lineNumber;
	}

	public boolean isSkip() {
		return skip;
	}

	public void setSkip(boolean skip) {
		this.skip = skip;
	}

	public boolean isStop() {
		return stop;
	}

	public void setStop(boolean stop) {
		this.stop = stop;
	}
}
