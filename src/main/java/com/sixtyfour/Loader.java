package com.sixtyfour;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * A simple helper class for loading BASIC programs (or any kind of text file).
 */
public class Loader {

	/**
	 * Loads a text into a String. It assumes that the text is UTF-8 encoded.
	 * 
	 * @param is
	 *            the input stream
	 * @return the text
	 */
	public static String loadText(InputStream is) {
		StringBuilder sb = new StringBuilder();
		try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
			while (br.ready()) {
				sb.append(br.readLine()).append('\n');
			}
		} catch (Exception e) {
			throw new RuntimeException("Failed to text file!", e);
		}
		return sb.toString();
	}

	/**
	 * Load a program from a text file into a String[] array. It assumes that
	 * the text is UTF-8 encoded. Line separator is \n.
	 * 
	 * @param prg
	 *            the program's input stream
	 * @return the string[] the program splitted into it's lines
	 */
	public static String[] loadProgram(InputStream prg) {
		List<String> lines = new ArrayList<String>();
		try (BufferedReader br = new BufferedReader(new InputStreamReader(prg, "UTF-8"))) {
			while (br.ready()) {
				String line = br.readLine();
				if (line != null && line.trim().length() > 0) {
					lines.add(line.trim());
				}
			}
		} catch (Exception e) {
			throw new RuntimeException("Failed to load program file!", e);
		}
		return lines.toArray(new String[lines.size()]);
	}

	/**
	 * Load a program from a text file into a String[] array. It assumes that
	 * the text is UTF-8 encoded. Line separator is \n.
	 * 
	 * @param file
	 *            the program file
	 * @return the string[] the program splitted into it's lines
	 */
	public static String[] loadProgram(String file) {
		try (InputStream is = new FileInputStream(new File(file))) {
			return loadProgram(is);
		} catch (Exception e) {
			throw new RuntimeException("Failed to load program file!", e);
		}
	}
}
