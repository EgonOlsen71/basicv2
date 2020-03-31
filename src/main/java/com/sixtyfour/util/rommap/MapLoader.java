package com.sixtyfour.util.rommap;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.Loader;

/**
 * Helper class to load various ROM call and symbol mapping files.
 * 
 * @author EgonOlsen71
 *
 */
public class MapLoader {

	/**
	 * Loads the given symbol mapping files and creates a map containing addresses
	 * as keys and corresponding labels as values.
	 * 
	 * @param files the input streams to the symbol files. Will be closed
	 *              automatically.
	 * @return the mapping
	 */
	public static Map<String, List<String>> getSymbolMapping(InputStream... files) {
		Map<String, List<String>> symbols = new HashMap<>();
		for (InputStream file : files) {
			String[] lines = Loader.loadProgram(file);
			for (String line : lines) {
				String[] parts = line.split(" ");
				String addr = parts[1].trim();
				String label = parts[2].trim();
				if (addr.startsWith("00")) {
					addr = addr.substring(2);
				}
				String key = addr.toLowerCase(Locale.ENGLISH);
				List<String> labels = symbols.get(key);
				if (labels == null) {
					labels = new ArrayList<>();
				}
				labels.add(label.toLowerCase(Locale.ENGLISH));
				symbols.put(key, labels);
			}
		}
		return symbols;
	}

	/**
	 * Returns a mapping between a label and an address read from a given file.
	 * 
	 * @param file the input stream to the file. Will be closed automatically.
	 * @return the mapping
	 */
	public static Map<String, String> getRomCalls(InputStream file) {
		Map<String, String> calls = new HashMap<>();

		String[] lines = Loader.loadProgram(file);
		for (String line : lines) {
			String[] parts = line.split("=");
			if (parts.length < 2) {
				continue;
			}
			String label = parts[0].trim();
			String addr = parts[1].trim();
			int pos = addr.indexOf(";");
			if (pos != -1) {
				addr = addr.substring(0, pos).trim();
			}
			if (addr.startsWith("$")) {
				addr = addr.substring(1);
			}
			calls.put(label.toLowerCase(Locale.ENGLISH), addr.toLowerCase(Locale.ENGLISH));
		}

		return calls;
	}

}
