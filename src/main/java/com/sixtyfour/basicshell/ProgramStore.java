package com.sixtyfour.basicshell;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Comparator;
import java.util.Locale;
import java.util.TreeSet;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.parser.cbmnative.UnTokenizer;

/**
 * The storage for the edited program.
 * 
 * @author nietoperz809
 */
public class ProgramStore {
	public static final String ERROR = "ERROR.\n";
	public static final String OK = "READY.\n";

	private final TreeSet<String> store = new TreeSet<>(new LineComparator());

	private int getLineNumber(String in) throws NumberFormatException {
		StringBuilder buff = new StringBuilder();
		for (int s = 0; s < in.length(); s++) {
			char c = in.charAt(s);
			if (!Character.isDigit(c))
				break;
			buff.append(c);
		}
		return Integer.parseInt(buff.toString());
	}

	@SuppressWarnings("unchecked")
	private void removeLine(int num) {
		TreeSet<String> clone = (TreeSet<String>) store.clone(); // avoid
		// java.util.ConcurrentModificationException
		for (String s : clone) {
			if (getLineNumber(s) == num)
				store.remove(s);
		}
	}

	@SuppressWarnings("unchecked")
	public String[] toArray() {
		TreeSet<String> clone = (TreeSet<String>) store.clone(); // avoid
		// java.util.ConcurrentModificationException
		String[] arr = new String[clone.size()];
		int n = 0;
		for (String s : clone) {
			arr[n++] = s;
		}
		return arr;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String toString() {
		TreeSet<String> clone = (TreeSet<String>) store.clone(); // avoid
		// java.util.ConcurrentModificationException
		StringBuilder sb = new StringBuilder();
		for (String s : clone) {
			sb.append(s).append('\n');
		}
		return sb.toString();
	}

	@SuppressWarnings("unused")
	public boolean insert(String s) {
		if (s != null && s.trim().length() > 0) {
			try // Must begin with number
			{
				int num = getLineNumber(s);
				try {
					int num2 = Integer.parseInt(s); // Number only?
					removeLine(num);
				} catch (NumberFormatException ex) {
					addLine(s);
				}
			} catch (NumberFormatException ex) {
				return false;
			}
		}
		return true;
	}

	private void addLine(String s) {
		removeLine(getLineNumber(s));
		store.add(s);
	}

	public void clear() {
		store.clear();
	}

	public String load(String srcFile) {
		store.clear();
		try {
			String[] lines = null;
			if (srcFile.toLowerCase(Locale.ENGLISH).endsWith(".prg")) {
				try {
					Logger.log("Looks like a PRG file, trying to convert it...");
					byte[] data = Loader.loadBlob(srcFile);
					UnTokenizer unto = new UnTokenizer();
					lines = unto.getText(data, true).toArray(new String[0]);
					Logger.log("PRG file converted into ASCII, proceeding!");
					srcFile = srcFile.replace(".prg", ".bas");
				} catch (Exception e) {
					Logger.log("Failed to convert PRG file: " + e.getMessage());
					Logger.log("Proceeding as if it was ASCII instead!");
				}
			} else {
				lines = Loader.loadProgram(srcFile);
			}
			
			for (String line : lines) {
				insert(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return OK;
	}

	public String save(String path) {
		boolean ok = true;
		String txt = this.toString();
		FileWriter outFile = null;
		try {
			outFile = new FileWriter(path);
		} catch (IOException e) {
			e.printStackTrace();
			ok = false;
		}
		if (ok) {
			try {
				PrintWriter out1 = new PrintWriter(outFile);
				try {
					out1.append(txt);
				} finally {
					out1.close();
				}
			} finally {
				try {
					outFile.close();
				} catch (IOException e) {
					e.printStackTrace();
					ok = false;
				}
			}
		}
		return ok ? OK : ERROR;
	}

	class LineComparator implements Comparator<String> {
		@Override
		public int compare(String s1, String s2) {
			return getLineNumber(s1) - getLineNumber(s2);
		}
	}
}
