package com.sixtyfour.util.rommap;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;

/**
 * @author EgonOlsen71
 *
 */
public class CallMapper {

    public static Map<String, String> mapCalls(boolean verbose) {

	Map<String, String> mappedCalls = new HashMap<>();

	Map<String, String> c64 = MapLoader
		.getSymbolMapping(CallMapper.class.getResourceAsStream("/rommap/rom-c64.txt"));
	Map<String, String> x16 = MapLoader
		.getSymbolMapping(CallMapper.class.getResourceAsStream("/rommap/rom-x16.txt"));
	Map<String, String> calls = MapLoader.getRomCalls(CallMapper.class.getResourceAsStream("/rommap/runtime.map"));

	Map<String, String> x16r = new HashMap<>();

	String[] addAddrs = Loader.loadProgram(CallMapper.class.getResourceAsStream("/rommap/runtime_ext.lst"));

	x16.forEach((k, v) -> x16r.put(v, k));

	Logger.log("Mapping runtime calls from c64 rom to x16 rom...");

	for (Entry<String, String> call : calls.entrySet()) {
	    String label = call.getKey();
	    String addr = call.getValue();
	    String match = c64.get(addr);
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
			closest = c64.get(caddr);
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
		mappedCalls.put(label.toUpperCase(Locale.ENGLISH),
			("$" + Integer.toHexString(Integer.parseInt(newAddr, 16) + dif)).toUpperCase(Locale.ENGLISH));
	    } else {
		if (verbose) {
		    Logger.log("Call to " + addr + " / " + label + " matches to " + match + " / " + newAddr
			    + " in target rom!");
		}
		mappedCalls.put(label.toUpperCase(Locale.ENGLISH), "$" + newAddr.toUpperCase(Locale.ENGLISH));
	    }
	}

	for (String addAddr : addAddrs) {
	    if (addAddr.length() > 0) {
		String[] parts = addAddr.split("\\+");
		int add = 0;
		if (parts.length == 2) {
		    add = Integer.valueOf(parts[1].trim());
		}
		String addr = x16r.get("."+parts[0].trim().toLowerCase(Locale.ENGLISH));
		if (addr == null) {
		    Logger.log("!!! Failed to match additional address " + parts[0]);
		}
		add += Integer.parseInt(addr, 16);
		mappedCalls.put(parts[0].toUpperCase(Locale.ENGLISH),
			"$" + Integer.toHexString(add).toUpperCase(Locale.ENGLISH));
	    }
	}

	return mappedCalls;
    }

}
