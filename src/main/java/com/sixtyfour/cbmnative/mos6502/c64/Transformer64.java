package com.sixtyfour.cbmnative.mos6502.c64;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.mos6502.AbstractTransformer;
import com.sixtyfour.system.Machine;

/**
 * The transformer for the C64 target platform. It generates 6502 assembly code linked together with a C64 specific runtime.
 * 
 * @author EgonOlsen
 * 
 */
public class Transformer64 extends AbstractTransformer {

	public Transformer64() {
	    variableStart = -1;
	    runtimeStart = -1;
	    stringMemoryEnd = 0xa000; // will be adjusted in the runtime according to 51/52
	    startAddress = 2072;
	    preferZeropage = true;
	}
	
	@Override
	public List<String> transform(Machine machine, PlatformProvider platform, List<String> code) {
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

		consts.add("; *** CONSTANTS ***");
		if (variableStart >= 0) {
			consts.add("*=$" + Integer.toHexString(variableStart));
		}
		consts.add("CONSTANTS");
		vars.add("; *** VARIABLES ***");
		vars.add("VARIABLES");

		res.add("SGNFAC = $BC2B");
		res.add("MEMARG = $BA8C");
		res.add("ARGADD = $B86A");
		res.add("ARGAND = $AFE9");
		res.add("ARGDIV = $BB14");
		res.add("FACMUL = $BA30");
		res.add("FACADD = $B867");
		res.add("FACLOG = $B9EA");
		res.add("FACSQR = $BF71");
		res.add("FACEXP = $BFED");
		res.add("FACABS = $BC58");
		res.add("FACSIN = $E26B");
		res.add("FACCOS = $E264");
		res.add("FACTAN = $E2B4");
		res.add("FACATN = $E30E");
		res.add("FACSGN = $BC39");
		res.add("FACNOT = $AED4");
		res.add("FACRND = $E097");
		res.add("FACWORD = $B7F7");
		res.add("FACDIV = $BB0F");
		res.add("BASINT = $BCCC");
		res.add("FACPOW = $BF7B");
		res.add("FACSUB = $B853");
		res.add("FACOR = $AFE6");
		res.add("FACMEM = $BBD7");
		res.add("ARGFAC = $BBFC");
		res.add("FACARG = $BC0C");
		res.add("FACSTR = $BDDF");
		res.add("FACINT = $B1AA");
		res.add("RNDFAC = $BC1B");
		res.add("REALFAC = $BBA2");
		res.add("INTFAC = $B391");
		res.add("WRITETIS = $A9E7");
		res.add("GETTI = $BE68");
		res.add("GETTIME = $AF7E");
		res.add("COPYTIME = $AF87");
		res.add("TI2FAC = $AF84");
		res.add("CHROUT = $FFD2");
		res.add("PRINTSTRS = $AB25");
		res.add("VALS = $B7B5");
		res.add("CMPFAC = $BC5B");
		res.add("BYTEFAC = $B3A2");
		res.add("CRSRPOS = $FFF0");
		res.add("CRSRRIGHT = $AB3B");
		res.add("GETIN = $FFE4");
		res.add("INPUT = $A560");
		res.add("OPENCH = $F34A");
		res.add("CLOSECH = $F291");
		res.add("CHKIN = $FFC6");
		res.add("CHKOUT = $FFC9");
		res.add("CLRCH = $FFCC");
		res.add("LOADXX = $F4AB");
		res.add("SAVEXX = $F5ED");
		res.add("TWAIT = $F6ED");

		res.add("TMP_ZP = 105");
		res.add("TMP2_ZP = 107");
		res.add("TMP3_ZP = 34");
		res.add(";make sure that JUMP_TARGET's low can't be $ff");
		res.add("JUMP_TARGET = 69");
		if (preferZeropage) {
			res.add("TMP_REG=71");
		}
		res.add("*=" + startAddress);
		res.add("TSX");
		res.add("STX SP_SAVE");

		addStructures(machine, platform, code, res, consts, vars, mnems, subs);
		return res;
	}

}
