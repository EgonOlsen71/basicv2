package com.sixtyfour.cbmnative.mos6502.x16;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.mos6502.AbstractTransformer;
import com.sixtyfour.cbmnative.mos6502.StringAdder;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.rommap.CallMapper;
import com.sixtyfour.util.rommap.Mapping;

/**
 * The transformer for the Commander X16 target platform. It generates 6502
 * assembly code linked together with a X16 specific runtime.
 * 
 * @author EgonOlsen
 * 
 */
public class TransformerX16 extends AbstractTransformer {

	public TransformerX16() {
		variableStart = -1;
		runtimeStart = -1;
		stringMemoryEnd = 0; // will be adjusted in the runtime according to BASIC END
		startAddress = 2072;
		preferZeropage = true;
		stringRegInZeropage = false;
	}

	@Override
	public List<String> transform(CompilerConfig config, MemoryConfig memConfig, Machine machine, PlatformProvider platform,
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
		AbstractTransformer.addExtensionSubroutines(subs, "asmx16");

		consts.add("; *** CONSTANTS ***");
		if (variableStart >= 0) {
			consts.add("*=$" + Integer.toHexString(variableStart));
		}
		consts.add("CONSTANTS");
		vars.add(";###############################");
		vars.add("; *** VARIABLES ***");
		vars.add("VARIABLES");

		addExtensionConstants(res);

		// Add runtime calls based on rom mapping...might be off...beware!
		Mapping mapping = CallMapper.mapCalls(config, false);

		Map<String, String> calls = mapping.getMap();
		calls.forEach((k, v) -> res.add(k + " = " + v));

		addMemoryLocations(res);
		addBasicBuffer(res, platform, memConfig);

		res.add("TMP_ZP = 48");
		res.add("TMP2_ZP = 53");
		res.add("TMP3_ZP = 58");
		res.add(";make sure that JUMP_TARGET's low can't be $ff");
		res.add("JUMP_TARGET = 63");
		if (preferZeropage) {
			res.add("TMP_REG=68");
			res.add("G_REG=73");
			res.add("X_REG=78");
		}
		res.add("TMP_BANK=95");
		res.add("*=" + startAddress);
		res.add("TSX");
		res.add("STX SP_SAVE");

		addStructures(config, memConfig, machine, platform, code, res, consts, vars, mnems, subs, mapping.getFarCalls(), null,
				new StringAdder() {
					@Override
					public void addStringVars(List<String> strVars) {
						// Add DA$ if needed.
						if (!strVars.contains("; VAR: DA$")) {
							strVars.add("; VAR: DA$");
							strVars.add("VAR_DA$ .WORD EMPTYSTR");
						}
					}
				});
		return res;
	}

	@Override
	protected void addMemoryLocations(List<String> res) {
		Logger.log("Adding additional runtime labels...");
		String[] labels = Loader.loadProgram(TransformerX16.class.getResourceAsStream("/rommap/memloc-x16.map"));
		addLabels(res, labels);
	}
}
