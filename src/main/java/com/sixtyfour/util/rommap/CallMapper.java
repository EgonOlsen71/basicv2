package com.sixtyfour.util.rommap;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;

/**
 * @author EgonOlsen71
 *
 */
public class CallMapper {

	public static Mapping mapCalls(CompilerConfig config, boolean verbose) {

		Map<String, String> mappedCalls = new HashMap<>();

		Map<String, List<String>> c64 = MapLoader
				.getSymbolMapping(CallMapper.class.getResourceAsStream("/rommap/rom-c64.txt"));
		Map<String, List<String>> x16 = null;
		if (config != null && config.getSymbolTable() != null && !config.getSymbolTable().isEmpty()) {
			Logger.log("Loading symbol table from file: " + config.getSymbolTable());
			try (InputStream is = new FileInputStream(config.getSymbolTable())) {
				x16 = MapLoader.getSymbolMapping(is);
			} catch (Exception e) {
				Logger.log("Failed to load symbol table: " + e.getMessage());
				System.exit(15);
			}
		} else {
			x16 = MapLoader.getSymbolMapping(CallMapper.class.getResourceAsStream("/rommap/rom-x16.txt"));
		}
		Map<String, String> calls = MapLoader.getRomCalls(CallMapper.class.getResourceAsStream("/rommap/runtime.map"));

		Map<String, String> x16r = new HashMap<>();
		List<String> redirs = new ArrayList<>();

		String[] addAddrs = Loader.loadProgram(CallMapper.class.getResourceAsStream("/rommap/runtime_ext.lst"));

		for (Entry<String, List<String>> entries : x16.entrySet()) {
			for (String label : entries.getValue()) {
				x16r.put(label, entries.getKey());
			}
		}

		Logger.log("Mapping runtime calls from c64 rom to x16 rom...");

		for (Entry<String, String> call : calls.entrySet()) {
			String label = call.getKey();
			String addr = call.getValue();
			boolean isKernalCall = isKernalCall(addr);

			String uLabel = label.toUpperCase(Locale.ENGLISH);

			List<String> matchys = c64.get(addr);
			String match = null;
			if (matchys != null && !matchys.isEmpty()) {
				// The c64 rom only has one mapping for label/address
				match = matchys.get(0);
			}
			int add = 0;
			if (match == null) {
				int iaddr = Integer.parseInt(addr, 16);
				int dif = 256;
				String closest = null;
				String claddr = null;
				for (String caddr : c64.keySet()) {
					int ciaddr = Integer.parseInt(caddr, 16);
					if (ciaddr < iaddr && iaddr - ciaddr < dif) {
						dif = iaddr - ciaddr;
						closest = null;
						List<String> closs = c64.get(caddr);
						if (closs != null && !closs.isEmpty()) {
							closest = c64.get(caddr).get(0);
						}
						claddr = caddr;
					}
				}
				if (closest != null) {
					if (verbose) {
						Logger.log("Closest match for " + addr + " / " + label + " in source rom is " + closest + " / "
								+ claddr + " with a delta of " + dif);
					}
					match = closest;
					add = dif;
				} else {
					Logger.log("!!! Failed to match call to " + addr + " / " + label);
					continue;
				}
			}
			String newAddr = x16r.get(match);
			if (newAddr == null) {
				if (verbose) {
					Logger.log("Failed to find symbol " + match + " in target rom");
				}
				continue;
			}
			if (add != 0) {
				int dif = add;
				if (verbose) {
					Logger.log("Call to " + addr + " / " + label + " matches to " + match + " / " + newAddr + " + "
							+ Integer.toHexString(dif) + " in target rom!");
				}
				mappedCalls.put(uLabel,
						("$" + Integer.toHexString(Integer.parseInt(newAddr, 16) + dif)).toUpperCase(Locale.ENGLISH));
			} else {
				if (verbose) {
					Logger.log("Call to " + addr + " / " + label + " matches to " + match + " / " + newAddr
							+ " in target rom!");
				}
				mappedCalls.put(uLabel, "$" + newAddr.toUpperCase(Locale.ENGLISH));
			}

			if (isKernalCall) {
				// This needs an additional redirection to make a jsrfar call instead
				addJarFar(mappedCalls.get(uLabel), redirs, uLabel);
				mappedCalls.remove(uLabel);
			}

		}

		for (String addAddr : addAddrs) {
			if (addAddr.length() > 0) {
				boolean forceBank0 = false;
				if (addAddr.startsWith("*")) {
					forceBank0 = true;
					addAddr = addAddr.substring(1);
				}
				String[] parts = addAddr.split("\\+");
				int add = 0;
				if (parts.length == 2) {
					add = Integer.valueOf(parts[1].trim());
				}
				String addr = x16r.get("." + parts[0].trim().toLowerCase(Locale.ENGLISH));
				if (addr == null) {
					Logger.log("!!! Failed to match additional address " + parts[0]);
				}
				add += Integer.parseInt(addr, 16);
				String val = "$" + Integer.toHexString(add).toUpperCase(Locale.ENGLISH);
				if (!isKernalCall(add) || forceBank0) {
					mappedCalls.put(parts[0].toUpperCase(Locale.ENGLISH), val);
				} else {
					addJarFar(val, redirs, parts[0].toUpperCase(Locale.ENGLISH));
				}
			}
		}

		Mapping mapping = new Mapping();
		mapping.setMap(mappedCalls);
		mapping.setFarCalls(redirs);
		return mapping;
	}

	private static void addJarFar(String addr, List<String> redirs, String uLabel) {
		redirs.add(uLabel + ":");
		redirs.add("JSR JSRFAR");
		redirs.add(".WORD " + addr);
		redirs.add(".BYTE 7");
		//redirs.add(".BYTE $FF");
		redirs.add("RTS");
		redirs.add(";###################################");
	}

	private static boolean isKernalCall(String addr) {
		int addri = Integer.parseInt(addr, 16);
		return addri >= 0xE500 && addri < 0xFF81;
	}

	private static boolean isKernalCall(int addri) {
		return addri >= 0xE500 && addri < 0xFF81;
	}

}
