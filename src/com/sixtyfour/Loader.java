package com.sixtyfour;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * The Class Loader.
 */
public class Loader {

	/**
	 * Load text.
	 * 
	 * @param is
	 *            the is
	 * @return the string
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
	 * Load program.
	 * 
	 * @param prg
	 *            the prg
	 * @return the string[]
	 */
	public static String[] loadProgram(InputStream prg) {
		List<String> lines = new ArrayList<String>();
		try (BufferedReader br = new BufferedReader(new InputStreamReader(prg, "UTF-8"))) {
			while (br.ready()) {
				String line = br.readLine();
				if (line.trim().length() > 0) {
					lines.add(line.trim());
				}
			}
		} catch (Exception e) {
			throw new RuntimeException("Failed to load program file!", e);
		}
		return lines.toArray(new String[lines.size()]);
	}

	/**
	 * Load program.
	 * 
	 * @param file
	 *            the file
	 * @return the string[]
	 */
	public static String[] loadProgram(String file) {
		try (InputStream is = new FileInputStream(new File(file))) {
			return loadProgram(is);
		} catch (Exception e) {
			throw new RuntimeException("Failed to load program file!", e);
		}
	}
}
