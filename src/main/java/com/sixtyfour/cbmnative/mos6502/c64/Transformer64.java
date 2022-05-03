package com.sixtyfour.cbmnative.mos6502.c64;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.mos6502.AbstractTransformer;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.config.RuntimeAddition;
import com.sixtyfour.system.Machine;

/**
 * The transformer for the C64 target platform. It generates 6502 assembly code
 * linked together with a C64 specific runtime.
 * 
 * @author EgonOlsen
 * 
 */
public class Transformer64 extends AbstractTransformer {

	private static final String SEP = ";###################################";

	public Transformer64() {
		variableStart = -1;
		runtimeStart = -1;
		stringMemoryEnd = 0; // will be adjusted in the runtime according to 55/56
		startAddress = 2072;
		preferZeropage = true;
		stringRegInZeropage = false;
	}

	@Override
	public List<String> transform(CompilerConfig config, MemoryConfig memConfig, Machine machine,
			PlatformProvider platform, List<String> code) {
		Logger.log("Compiling into native assembly code...");
		List<String> res = new ArrayList<>();
		List<String> consts = new ArrayList<String>();
		List<String> vars = new ArrayList<String>();
		List<String> mnems = new ArrayList<String>();
		List<String> subs = new ArrayList<String>();
		List<String> bigRamCode = null;
		mnems.add("; *** CODE ***");
		if (runtimeStart != -1) {
			subs.add("*=$" + Integer.toHexString(runtimeStart));
		}
		subs.add("; *** SUBROUTINES ***");

		if (config.isBigRam()) {
			bigRamCode = Arrays
					.asList(Loader.loadProgram(this.getClass().getResourceAsStream("/bigram/romhandler.asm")));
			subs.addAll(Arrays.asList(Loader.loadProgram(this.getClass().getResourceAsStream("/bigram/bigram.asm"))));
		}
		subs.addAll(Arrays.asList(Loader.loadProgram(this.getClass().getResourceAsStream("/subroutines.asm"))));
		RuntimeAddition add = config.getRuntimeAddition();
		if (add != null && add.getAdditionalRuntimeCode() != null) {
			Logger.log("Adding user provided runtime code: " + add.getAdditionalRuntimeCode().size() + " lines");
			subs.add(SEP);
			subs.addAll(add.getAdditionalRuntimeCode());
			subs.add(SEP);
		}

		AbstractTransformer.addExtensionSubroutines(subs, "asm64");

		consts.add("; *** CONSTANTS ***");
		if (variableStart >= 0) {
			consts.add("*=$" + Integer.toHexString(variableStart));
		}
		consts.add("CONSTANTS");
		vars.add(SEP);
		vars.add("; *** VARIABLES ***");
		vars.add("VARIABLES");

		addExtensionConstants(res);

		if (config.isBigRam()) {
			addBigRamRomCalls(res);
		} else {
			addDefaultRomCalls(res);
		}

		res.add("CRSRPOS = $FFF0");
		res.add("CHROUT = $FFD2");
		res.add("GETIN = $FFE4");
		res.add("OPENCH = $FFC0");
		res.add("CLOSECH = $FFC3");
		res.add("CHKIN = $FFC6");
		res.add("CHKOUT = $FFC9");
		res.add("CLRCH = $FFCC");
		res.add("LOADXX = $FFD5");
		res.add("SAVEXX = $FFD8");
		res.add("TWAIT = $FFE1");
		res.add("ERRFNF = $F12F");

		if (config.isBoostMode()) {
			// optional boost on a C128 in C64 mode
			res.add("BOOST = 1");
		}
		addMemoryLocations(res);
		addBasicBuffer(res, platform, memConfig);

		res.add("TMP_ZP = 105");
		res.add("TMP2_ZP = 107");
		res.add("TMP3_ZP = 34");
		res.add(";make sure that JUMP_TARGET's low can't be $ff");
		res.add("JUMP_TARGET = 69");
		if (preferZeropage) {
			res.add("TMP_REG=71");
			res.add("G_REG=73");
			res.add("X_REG=61");
		}
		if (stringRegInZeropage) {
			res.add("A_REG=167");
			res.add("B_REG=169");
		}
		res.add("*=" + startAddress);
		res.add("TSX");
		res.add("STX SP_SAVE");

		addStructures(config, memConfig, machine, platform, code, res, consts, vars, mnems, subs, bigRamCode);
		return res;
	}

	private void addDefaultRomCalls(List<String> res) {
		res.add("REALFAC = $BBA2");
		res.add("MEMARG = $BA8C");
		res.add("MEMMUL = $BA28");
		res.add("MEMSUB = $B850");
		res.add("FACMEM = $BBD7");
		res.add("PRINTSTRS = $AB25");
		res.add("VALS = $B7B5");
		res.add("CMPFAC = $BC5B");
		res.add("FACADD = $B867");

		res.add("SGNFAC = $BC2B");
		res.add("ARGADD = $B86A");
		res.add("ARGAND = $AFE9");
		res.add("ARGDIV = $BB14");
		res.add("FACMUL = $BA30");
		res.add("FACLOG = $B9EA");
		res.add("FACSQR = $BF71");
		res.add("FACEXPCALL = $BFED");
		res.add("FACABS = $BC58");
		res.add("FACSIN = $E26B");
		res.add("FACCOS = $E264");
		res.add("FACTAN = $E2B4");
		res.add("FACATN = $E30E");
		res.add("FACSIG = $BC39");
		res.add("FACNOT = $AED4");
		res.add("FACRND = $E097");
		res.add("XFACWORD = $B7F7");
		res.add("FACDIV = $BB0F");
		res.add("BASINT = $BCCC");
		res.add("FACPOW = $BF7B");
		res.add("FACSUB = $B853");
		res.add("FACOR = $AFE6");
		res.add("ARGFAC = $BBFC");
		res.add("FACARG = $BC0C");
		res.add("FACSTR = $BDDF");
		res.add("FACINT = $B1AA");
		res.add("RNDFAC = $BC1B");
		res.add("INTFAC = $B391");
		res.add("WRITETIS = $A9E7");
		res.add("GETTI = $BE68");
		res.add("GETTIME = $AF7E");
		res.add("COPYTIME = $AF87");
		res.add("TI2FAC = $AF84");
		res.add("BYTEFAC = $B3A2");
		res.add("CRSRRIGHT = $AB3B");
		res.add("ERRALL = $A437");
		res.add("ERRIQ = $B248");
		res.add("ERREI = $ACF4");
		res.add("ERRSYN = $AF08");
		res.add("INPUT = $A560");
	}

	private void addBigRamRomCalls(List<String> res) {
		res.add("BRREALFAC = $BBA2");
		res.add("BRMEMARG = $BA8C");
		res.add("BRMEMMUL = $BA28");
		res.add("BRMEMSUB = $B850");
		res.add("BRFACMEM = $BBD7");
		res.add("BRFACDIV = $BB0F");
		res.add("BRPRINTSTRS = $AB25");
		res.add("BRVALS = $B7B5");
		res.add("BRCMPFAC = $BC5B");

		res.add("BRSGNFAC = $BC2B");
		res.add("BRARGADD = $B86A");
		res.add("BRARGAND = $AFE9");
		res.add("BRARGDIV = $BB14");
		res.add("BRFACMUL = $BA30");
		res.add("BRFACADD = $B867");
		res.add("BRFACLOG = $B9EA");
		res.add("BRFACSQR = $BF71");
		res.add("BRFACEXPCALL = $BFED");
		res.add("BRFACABS = $BC58");
		res.add("BRFACSIN = $E26B");
		res.add("BRFACCOS = $E264");
		res.add("BRFACTAN = $E2B4");
		res.add("BRFACATN = $E30E");
		res.add("BRFACSIG = $BC39");
		res.add("BRFACNOT = $AED4");
		res.add("BRFACRND = $E097");
		res.add("BRFACWORD = $B7F7");
		res.add("BRBASINT = $BCCC");
		res.add("BRFACPOW = $BF7B");
		res.add("BRFACSUB = $B853");
		res.add("BRFACOR = $AFE6");
		res.add("BRARGFAC = $BBFC");
		res.add("BRFACARG = $BC0C");
		res.add("BRFACSTR = $BDDF");
		res.add("BRFACINT = $B1AA");
		res.add("BRRNDFAC = $BC1B");
		res.add("BRINTFAC = $B391");
		res.add("BRWRITETIS = $A9E7");
		res.add("BRGETTI = $BE68");
		res.add("BRGETTIME = $AF7E");
		res.add("BRCOPYTIME = $AF87");
		res.add("BRTI2FAC = $AF84");
		res.add("BRBYTEFAC = $B3A2");
		res.add("BRCRSRRIGHT = $AB3B");
		res.add("BRERRALL = $A437");
		res.add("BRERRIQ = $B248");
		res.add("BRERREI = $ACF4");
		res.add("BRERRSYN = $AF08");
		res.add("BRINPUT = $A560");

		res.add("BIGRAM = 1");
		res.add("BRROMSTART = $9F00"); // Actually, this is ROMSTART-256 to handle potentially overlapping data at the
										// cost of some performance
		res.add("BRROMEND = $C000");
	}

}
