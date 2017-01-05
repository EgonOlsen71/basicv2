package com.sixtyfour.basicshell;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Comparator;
import java.util.TreeSet;

import com.sixtyfour.Loader;

/**
 * The storage for the edited program.
 * 
 * @author nietoperz809
 */
public class ProgramStore {
	private final TreeSet<String> store = new TreeSet<>(new LineComparator());
	private static final String ERROR = "ERROR.\n";
	private static final String OK = "READY.\n";

	class LineComparator implements Comparator<String> {
		@Override
		public int compare(String s1, String s2) {
			return getLineNumber(s1) - getLineNumber(s2);
		}
	}

	public ProgramStore() {
	}

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

	private void addLine(String s) {
		removeLine(getLineNumber(s));
		store.add(s);
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
			System.err.println("oops");
			return false;
		}
		return true;
	}

	public void clear() {
		store.clear();
	}

	public String load(String path) {
		try {
			String[] lines = Loader.loadProgram(path);
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
		return ok ? OK : ERROR;
	}
}
