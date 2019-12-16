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
		Mapping mapping = CallMapper.mapCalls(config, false);

		Map<String, String> calls = mapping.getMap();
		calls.forEach((k, v) -> res.add(k + " = " + v));

		addMemoryLocations(res);

		res.add("TMP_ZP = 96");
		res.add("TMP2_ZP = 101");
		res.add("TMP3_ZP = 106");
		res.add(";make sure that JUMP_TARGET's low can't be $ff");
		res.add("JUMP_TARGET = 111");
		if (preferZeropage) {
			res.add("TMP_REG=116");
			res.add("G_REG=121");
		}
		res.add("*=" + startAddress);
		res.add("TSX");
		res.add("STX SP_SAVE");

		addStructures(config, machine, platform, code, res, consts, vars, mnems, subs, mapping.getFarCalls());
		return res;
	}

	@Override
	protected void addMemoryLocations(List<String> res) {
		res.add("ARGSGN=$E2");
		res.add("ARGLO=$E1");
		res.add("ARGMO=$E0");
		res.add("ARGMOH=$DF");
		res.add("ARGHO=$DE");
		res.add("ARGEXP=$DD");
		res.add("FACSGN=$DB");
		res.add("FACLO=$DA");
		res.add("FACMO=$D9");
		res.add("FACMOH=$D8");
		res.add("FACHO=$D7");
		res.add("FACEXP=$D6");
		res.add("FACOV=$E4");
		res.add("OLDOV=$5F"); // Should be free!?
		res.add("ARISGN=$E3");
		res.add("FAC=$D6");
		res.add("RESLO=$BB");
		res.add("RESMO=$BA");
		res.add("RESMOH=$B9");
		res.add("RESHO=$B8");
		res.add("RESOV=$BC");
		res.add("RESHOP=$E3");
		res.add("FACHOP=$5F"); // Should be free!?
		res.add("ITERCNT=$DC");
		res.add("IOCHANNEL=$2D9");
		res.add("BASICSTART=$BD");
		res.add("BASICEND=$2E5");
		res.add("STATUS=$287");
		res.add("VERCHK=$2D0");
		res.add("SECADDR=$29A");
		res.add("DEVICENUM=$29B");
		res.add("FILELEN=$298");
		res.add("LOGICADDR=$299");
		res.add("FILEADDR=$84");
		res.add("LOADEND=$86"); // Is this correct? Should be memuss, but that is gone in the symbol table albeit it's still in the source code!?
		res.add("KEYNDX=$29E");
		res.add("INDEX1=$B4");
		res.add("VALTYPE=$2D3");
		res.add("LOWDS=$D2");
		res.add("TIMEADDR=$292");
		res.add("BANKGEOS=$3");
		res.add("R0=$02");
		res.add("R0L=$02");
		res.add("R0H=$03");
		res.add("R1=$04");
		res.add("R1L=$04");
		res.add("R1H=$05");
		res.add("R2=$06");
		res.add("R2L=$06");
		res.add("R2H=$07");
		res.add("R3=$08");
		res.add("R3L=$08");
		res.add("R3H=$09");
		res.add("R4=$0A");
		res.add("R4L=$0A");
		res.add("R4H=$0B");
		res.add("R5=$0C");
		res.add("R5L=$0C");
		res.add("R5H=$0D");
		res.add("R11=$18");
		res.add("R11L=$18");
		res.add("R11H=$19");
		res.add("R14=$1E");
		res.add("R14L=$1E");
		res.add("R14H=$1F");
		res.add("R15=$20");
		res.add("R15L=$20");
		res.add("R15H=$21");
	}

}
