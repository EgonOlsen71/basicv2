package com.sixtyfour.util;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Pattern;

/**
 * Reads (and writes) optimizer rules.
 * 
 * @author EgonOlsen
 *
 */
public class PatternProcessor {

	private final static String SEP = "\t";
	private final static String COM_SEP = "|";
	private static Map<String, String[]> fileContentCache = new HashMap<String, String[]>();

	public static void main(String[] args) {
		// Optimizer6502 opti = new Optimizer6502();
		// List<Pattern> patterns = opti.getPatterns();
		// new PatternProcessor().writePatterns(patterns,
		// "src/main/resources/optimizer6502.txt");

		List<Pattern> fromFile = new PatternProcessor().getPatterns("optimizer6502.txt");
		// if (fromFile.size() != patterns.size()) {
		// throw new RuntimeException("Size mismatch!");
		// }
		System.out.println(fromFile.size());
	}

	/**
	 * For initial work only, not needed afterwards...
	 */
	public void writePatterns(List<Pattern> patterns, String fileName) {

		int cnt = 0;
		try (PrintWriter pw = new PrintWriter(new FileWriter(new File(fileName), Charset.forName("UTF-8")))) {
			for (Pattern pattern : patterns) {
				Logger.log("Writing pattern: " + pattern.getName());
				List<String> input = pattern.getInputPattern();
				List<String> output = pattern.getOutputPattern();
				boolean skipComments = pattern.isSkipComments();
				boolean isSimple = pattern.isSimple();
				boolean isLooseTypes = pattern.isLooseTypes();
				String name = pattern.getName();
				pw.println("#" + (++cnt) + ": " + name);
				pw.print("\"" + name + "\"");
				pw.print(SEP);
				pw.print(isSimple);
				pw.print(SEP);
				pw.print(isLooseTypes);
				pw.print(SEP);
				pw.print(skipComments);
				pw.print(SEP + "\"");
				for (String com : input) {
					pw.print(com.trim().replace("|", "~"));
					pw.print(COM_SEP);
				}
				pw.print("\"" + SEP + "\"");
				for (String com : output) {
					pw.print(com.trim().replace("|", "~"));
					pw.print(COM_SEP);
				}
				pw.println("\"");
				pw.println();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public List<Pattern> getPatterns(String setName) {
		String[] lines = null;
		synchronized (fileContentCache) {
			lines = fileContentCache.get(setName);
			if (lines == null) {
				Logger.log("Reading optimizer rules from file " + setName);
				lines = Loader.loadProgram(this.getClass().getResourceAsStream("/" + setName));
				fileContentCache.put(setName, lines);
			}
		}
		List<Pattern> patterns = new ArrayList<>();
		for (String line : lines) {
			line = line.trim();
			if (line.startsWith("#") || line.isBlank()) {
				continue;
			}
			String[] parts = line.split(SEP);
			if (parts.length != 6) {
				Logger.log("Syntax error in optimizer rules: " + line);
				throw new RuntimeException();
			}
			String name = cleanUp(parts[0]);
			Boolean simple = Boolean.valueOf(cleanUp(parts[1]));
			Boolean loose = Boolean.valueOf(cleanUp(parts[2]));
			Boolean skip = Boolean.valueOf(cleanUp(parts[3]));
			String input = cleanUp(parts[4]);
			String output = cleanUp(parts[5]);

			Pattern pattern = new Pattern(simple, name, toArray(output), toArray(input));
			pattern.setLooseTypes(loose);
			pattern.setSkipComments(skip);
			patterns.add(pattern);
		}
		return patterns;
	}

	private String[] toArray(String line) {
		List<String> res = new ArrayList<>();
		String[] parts = line.split("\\" + COM_SEP);
		if (parts.length == 0) {
			return null;
		}
		for (String part : parts) {
			part = part.trim();
			if (!part.isBlank()) {
				res.add(part.replace("~", "|"));
			}
		}
		return res.toArray(new String[res.size()]);
	}

	private String cleanUp(String txt) {
		if (txt == null) {
			return "";
		}
		txt = txt.trim();
		if (txt.startsWith("\"") || txt.startsWith("'")) {
			txt = txt.substring(1);
		}
		if (txt.endsWith("\"") || txt.endsWith("'")) {
			txt = txt.substring(0, txt.length() - 1);
		}
		return txt;
	}

}
