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
 * Helper class to map ROM calls from the C64's ROM to the X16's implementation
 * (or any other target that provides a matching symbol table).
 * 
 * @author EgonOlsen71
 *
 */
public class CallMapper {

	/**
	 * Creates a mapping between the C64's ROM calls and the X16's ones.
	 * 
	 * @param config  the current compiler's config
	 * @param verbose if true, the new mapping will be printed on screen
	 * @return the mapping
	 */
	public static Mapping mapCalls(CompilerConfig config, boolean verbose) {

		Map<String, String> mappedCalls = new HashMap<>();

		Map<String, List<String>> c64 = MapLoader.getSymbolMapping(getStream("/rommap/rom-c64.txt"));
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
			x16 = MapLoader.getSymbolMapping(getStream("/rommap/basic-x16.txt"), getStream("/rommap/kernal-x16.txt"));
		}
		Map<String, String> calls = MapLoader.getRomCalls(CallMapper.class.getResourceAsStream("/rommap/runtime.map"));
		Map<String, String> fpLibCalls = MapLoader
				.getRomCalls(CallMapper.class.getResourceAsStream("/rommap/fplib-x16.txt"));

		// fpLibCalls.keySet().forEach(p -> System.out.println(p));

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

			if (addr.startsWith("ff")) {
				if (verbose) {
					Logger.log("Call to " + addr + " / " + label
							+ " seems to be a ROM routine call. Using the same call in the target ROM!");
				}
				match = addr;
				x16r.put(addr, addr); // Hack to add it to the map
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
					String msg = "!!! Failed to match call to " + addr + " / " + label;
					Logger.log(msg);
					throw new RuntimeException(msg);
				}
			}
			String newAddr = x16r.get(match);
			if (newAddr == null) {
				if (verbose) {
					String err = "\n\n\nFailed to find symbol for " + label + ":  " + match + " in target rom\n\n\n\n";
					Logger.log(err);
				}
				continue;
			}
			if (add != 0) {
				int dif = add;
				if (verbose) {
					Logger.log("Call to " + addr + " / " + label + " matches to " + match + " / " + newAddr + " + "
							+ Integer.toHexString(dif) + " in target rom!");
				}

				String poMatch = match.replace(".", "");
				if (fpLibCalls.containsKey(poMatch)) {
					newAddr = fpLibCalls.get(poMatch);
					dif = 0;
					if (verbose) {
						Logger.log(
								"However, it's also part of the fpLib, so we use that instead and ignore the delta anyway: "
										+ newAddr);
					}
				}

				mappedCalls.put(uLabel,
						("$" + Integer.toHexString(Integer.parseInt(newAddr, 16) + dif)).toUpperCase(Locale.ENGLISH));
			} else {
				if (verbose) {
					Logger.log("Call to " + addr + " / " + label + " matches to " + match + " / " + newAddr
							+ " in target rom!");
				}

				String poMatch = match.replace(".", "");
				if (fpLibCalls.containsKey(poMatch)) {
					newAddr = fpLibCalls.get(poMatch);
					if (verbose) {
						Logger.log("However, it's also part of the fpLib, so we use that instead: " + newAddr);
					}
				}
				mappedCalls.put(uLabel, "$" + newAddr.toUpperCase(Locale.ENGLISH));
			}

			if (verbose) {
				Logger.log("---------------------------------------------------------");
			}

			if (isKernalCall(newAddr)) {
				// throw new RuntimeException("JSRFAR call missing!");
				newAddr = "0000";
				if (verbose) {
					Logger.log("WARNING: Call to " + match + " / " + newAddr
							+ " most likely requires a JSRFAR, but doesn't use one!");
					String err = "\n\n\nFailed to properly map symbol for " + label + ":  " + match
							+ " to target rom\n\n\n\n";
					Logger.log(err);
				}
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
				String label = parts[0].trim().toLowerCase(Locale.ENGLISH);
				String uLabel = label.toUpperCase(Locale.ENGLISH);
				String addr = x16r.get("." + label);
				if (addr == null) {
					String msg = "!!! Failed to match additional address " + parts[0];
					Logger.log(msg);
					throw new RuntimeException(msg);
				}
				add += Integer.parseInt(addr, 16);
				String val = "$" + Integer.toHexString(add).toUpperCase(Locale.ENGLISH);

				if (fpLibCalls.containsKey(label)) {
					val = fpLibCalls.get(label);
					if (verbose) {
						Logger.log(label + " is part of the fpLib, so we use that and ignore the delta: " + val);
					}
					val = "$" + val.toUpperCase(Locale.ENGLISH);
					mappedCalls.put(uLabel, val);
				} else {
					if (!isKernalCall(add) || forceBank0) {
						mappedCalls.put(uLabel, val);
					} else {
						addJarFar(val, redirs, uLabel);
					}
				}
				if (verbose) {
					Logger.log("Call to " + parts[0] + " matches to " + val + " in target rom!");
				}
			}
		}

		Mapping mapping = new Mapping();
		mapping.setMap(mappedCalls);
		mapping.setFarCalls(redirs);
		return mapping;
	}

	private static InputStream getStream(String name) {
		return CallMapper.class.getResourceAsStream(name);
	}

	private static void addJarFar(String addr, List<String> redirs, String uLabel) {
		redirs.add(uLabel + ":");
		redirs.add("JSR JSRFAR");
		redirs.add(".WORD " + addr);
		redirs.add(".BYTE 0");
		// redirs.add(".BYTE $FF");
		redirs.add("RTS");
		redirs.add(";###################################");
	}

	private static boolean isKernalCall(String addr) {
		int addri = Integer.parseInt(addr, 16);
		return addri >= 0xE500 && addri < 0xFC00;
	}

	private static boolean isKernalCall(int addri) {
		return addri >= 0xE500 && addri < 0xFC00;
	}

}
