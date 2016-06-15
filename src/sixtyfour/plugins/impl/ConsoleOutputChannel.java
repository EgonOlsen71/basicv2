package sixtyfour.plugins.impl;

import sixtyfour.plugins.OutputChannel;

public class ConsoleOutputChannel implements OutputChannel {
	private int cursor = 0;

	/* (non-Javadoc)
	 * @see sixtyfour.system.OutputChannel#print(java.lang.String)
	 */
	@Override
	public void print(String txt) {
		print(txt, true);
	}

	/* (non-Javadoc)
	 * @see sixtyfour.system.OutputChannel#print(java.lang.String, boolean)
	 */
	@Override
	public void print(String txt, boolean clean) {
		if (clean) {
			txt = clean(txt);
		}
		setCursor(getCursor() + txt.length());
		System.out.print(txt);
	}

	/* (non-Javadoc)
	 * @see sixtyfour.system.OutputChannel#println(java.lang.String)
	 */
	@Override
	public void println(String txt) {
		println(txt, true);
	}

	/* (non-Javadoc)
	 * @see sixtyfour.system.OutputChannel#println(java.lang.String, boolean)
	 */
	@Override
	public void println(String txt, boolean clean) {
		if (clean) {
			txt = clean(txt);
		}
		System.out.println(txt);
		setCursor(0);
	}

	private String clean(String txt) {
		return txt.replace("\n", "").replace("\r", "");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.system.OutputChannel#getCursor()
	 */
	@Override
	public int getCursor() {
		return cursor;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.system.OutputChannel#setCursor(int)
	 */
	@Override
	public void setCursor(int cursor) {
		this.cursor = cursor;
	}

}
