package com.sixtyfour.util.rommap;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.Loader;

/**
 * @author EgonOlsen71
 *
 */
public class MapLoader {

    /**
     * @param fileName
     * @return
     */
    public static Map<String, String> getSymbolMapping(InputStream file) {
	Map<String, String> symbols = new HashMap<>();

	String[] lines = Loader.loadProgram(file);
	for (String line : lines) {
	    String[] parts = line.split(" ");
	    String addr = parts[1].trim();
	    String label = parts[2].trim();
	    if (addr.startsWith("00")) {
		addr = addr.substring(2);
	    }
	    symbols.put(addr.toLowerCase(Locale.ENGLISH), label.toLowerCase(Locale.ENGLISH));
	}
	return symbols;
    }

    /**
     * @param fileName
     * @return
     */
    public static Map<String, String> getRomCalls(InputStream file) {
	Map<String, String> calls = new HashMap<>();

	String[] lines = Loader.loadProgram(file);
	for (String line : lines) {
	    String[] parts = line.split("=");
	    String label = parts[0].trim();
	    String addr = parts[1].trim();
	    if (addr.startsWith("$")) {
		addr = addr.substring(1);
	    }
	    calls.put(label.toLowerCase(Locale.ENGLISH), addr.toLowerCase(Locale.ENGLISH));
	}

	return calls;
    }

}
