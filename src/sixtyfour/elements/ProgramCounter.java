package sixtyfour.elements;

public class ProgramCounter {

	private int lineCnt;
	private int linePos;
	private boolean stop = false;

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

	public boolean isStop() {
		return stop;
	}

	public void setStop(boolean stop) {
		this.stop = stop;
	}

}
