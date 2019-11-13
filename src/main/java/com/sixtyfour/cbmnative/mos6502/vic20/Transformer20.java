package com.sixtyfour.cbmnative.mos6502.vic20;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.mos6502.AbstractTransformer;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.Machine;

/**
 * The transformer for the VIC20 target platform. It generates 6502 assembly
 * code linked together with a VIC20 specific runtime (which is in fact the same
 * one as the C64 uses for now).
 * 
 * @author EgonOlsen
 * 
 */
public class Transformer20 extends AbstractTransformer {

	/**
	 * 
	 */
	public Transformer20() {
		variableStart = -1;
		runtimeStart = -1;
		stringMemoryEnd = 0; // will be adjusted in the runtime according to 55/56
		startAddress = 4632; // will be adjusted according to the values that Platform20 provides
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

		res.add("SGNFAC = $DC2B"); // ok
		res.add("MEMARG = $DA8C"); // ok
		res.add("ARGADD = $D86A"); // ok
		res.add("ARGAND = $CFE9"); // ok
		res.add("ARGDIV = $DB14"); // ok
		res.add("FACMUL = $DA30"); // ok
		res.add("MEMMUL = $DA28"); // ok
		res.add("FACADD = $D867"); // ok
		res.add("FACLOG = $D9EA"); // ok
		res.add("FACSQR = $DF71"); // ok
		res.add("FACEXP = $DFED"); // ok
		res.add("FACABS = $DC58"); // ok
		res.add("FACSIN = $E268"); // ok
		res.add("FACCOS = $E261"); // ok
		res.add("FACTAN = $E2B1"); // ok
		res.add("FACATN = $E30B"); // ok
		res.add("FACSIG = $DC39"); // ok
		res.add("FACNOT = $CED4"); // ok
		res.add("FACRND = $E094"); // ok
		res.add("FACWORD = $D7F7"); // ok
		res.add("FACDIV = $DB0F"); // ok
		res.add("BASINT = $DCCC"); // ok
		res.add("FACPOW = $DF7B"); // ok
		res.add("FACSUB = $D853"); // ok
		res.add("MEMSUB = $D850"); // ok
		res.add("FACOR = $CFE6"); // ok
		res.add("FACMEM = $DBD7"); // ok
		res.add("ARGFAC = $DBFC"); // ok
		res.add("FACARG = $DC0C"); // ok
		res.add("FACSTR = $DDDF"); // ok
		res.add("FACINT = $D1AA"); // ok
		res.add("RNDFAC = $DC1B"); // ok
		res.add("REALFAC = $DBA2"); // ok
		res.add("INTFAC = $D391"); // ok
		res.add("WRITETIS = $C9E7"); // ok
		res.add("GETTI = $DE68"); // ok
		res.add("GETTIME = $CF7E"); // ok
		res.add("COPYTIME = $CF87"); // ok
		res.add("TI2FAC = $CF84"); // ok
		res.add("CHROUT = $FFD2"); // ok
		res.add("PRINTSTRS = $CB25"); // ok
		res.add("VALS = $D7B5"); // ok
		res.add("CMPFAC = $DC5B"); // ok
		res.add("BYTEFAC = $D3A2"); // ok
		res.add("CRSRPOS = $FFF0"); // ok
		res.add("CRSRRIGHT = $CB3B"); // ok
		res.add("GETIN = $FFE4"); // ok
		res.add("INPUT = $C560"); // ok
		res.add("OPENCH = $FFC0"); // ok
		res.add("CLOSECH = $FFC3"); // ok
		res.add("CHKIN = $FFC6"); // ok
		res.add("CHKOUT = $FFC9"); // ok
		res.add("CLRCH = $FFCC"); // ok
		res.add("LOADXX = $FFD5"); // ok
		res.add("SAVEXX = $FFD8"); // ok
		res.add("TWAIT = $FFE1"); // ok
		res.add("ERRALL = $C437"); // ok
		res.add("ERRIQ = $D248"); // ok
		res.add("ERREI = $CCF4"); // ok
		res.add("ERRSYN = $CF08"); // ok
		res.add("ERRFNF = $F1E2"); // ok

		addMemoryLocations(res);

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

		addStructures(config, machine, platform, code, res, consts, vars, mnems, subs);
		return res;
	}
}
