package com.sixtyfour.cbmnative.mos6502.x16;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.mos6502.AbstractTransformer;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.rommap.CallMapper;

/**
 * The transformer for the Commander X16 target platform. It generates 6502 assembly code
 * linked together with a X16 specific runtime.
 * 
 * @author EgonOlsen
 * 
 */
public class TransformerX16 extends AbstractTransformer {

    public TransformerX16() {
	variableStart = -1;
	runtimeStart = -1;
	stringMemoryEnd = 0xa000; // will be adjusted in the runtime according
				  // to 55/56
	startAddress = 2072;
	preferZeropage = true;
    }

    @Override
    public List<String> transform(CompilerConfig config, Machine machine, PlatformProvider platform,
	    List<String> code) {
	Logger.log("Compiling into native assembly code...");
	List<String> res = new ArrayList<>();
	List<String> consts = new ArrayList<String>();
	List<String> vars = new ArrayList<String>();
	List<String> mnems = new ArrayList<String>();
	List<String> subs = new ArrayList<String>();
	mnems.add("; *** CODE ***");
	if (runtimeStart != -1) {
	    subs.add("*=$" + Integer.toHexString(runtimeStart));
	}
	subs.add("; *** SUBROUTINES ***");

	subs.addAll(Arrays.asList(Loader.loadProgram(this.getClass().getResourceAsStream("/subroutines.asm"))));
	AbstractTransformer.addExtensionSubroutines(subs, "asm");

	consts.add("; *** CONSTANTS ***");
	if (variableStart >= 0) {
	    consts.add("*=$" + Integer.toHexString(variableStart));
	}
	consts.add("CONSTANTS");
	vars.add("; *** VARIABLES ***");
	vars.add("VARIABLES");

	addExtensionConstants(res);

	// Add runtime calls based on rom mapping...might be off...beware!
	Map<String, String> calls = CallMapper.mapCalls(false);
	calls.forEach((k, v) -> res.add(k + " = " + v));

	res.add("TMP_ZP = 105");
	res.add("TMP2_ZP = 107");
	res.add("TMP3_ZP = 34");
	res.add(";make sure that JUMP_TARGET's low can't be $ff");
	res.add("JUMP_TARGET = 69");
	if (preferZeropage) {
	    res.add("TMP_REG=71");
	    res.add("G_REG=73");
	}
	res.add("*=" + startAddress);
	res.add("TSX");
	res.add("STX SP_SAVE");

	addStructures(machine, platform, code, res, consts, vars, mnems, subs);
	return res;
    }

}
