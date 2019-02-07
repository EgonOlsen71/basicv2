package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.Pattern;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;

/**
 * An optimizer implementation for the 6520 cpu. Because it might run
 * a large number of passes, it will take its time especially on larger
 * programs.
 * 
 * @author EgonOlsen
 * 
 */
public class Optimizer6502 implements Optimizer {
    private List<Pattern> patterns = new ArrayList<Pattern>() {
	private static final long serialVersionUID = 1L;
	{

	    this.add(new Pattern("Simplified setting to 0", new String[] { "LDA #0", "STA {MEM0}", "STA {MEM0}+1" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM"));
	    this.add(new Pattern(false, "Faster logic OR", new String[] { "JSR FASTOR" }, "JSR FACOR"));
	    this.add(new Pattern(false, "Faster logic AND", new String[] { "JSR FASTAND" }, "JSR ARGAND"));
	    this.add(new Pattern(false, "Simple POKE", new String[] { "{LINE0}", "{LINE2}" }, "LDY {MEM0}", "LDA #0",
		    "STY {*}"));
	    this.add(new Pattern("REALOUT + LINEBRK", new String[] { "JSR REALOUTBRK" }, "JSR REALOUT",
		    "JSR LINEBREAK"));
	    this.add(new Pattern("STROUT + LINEBRK", new String[] { "JSR STROUTBRK" }, "JSR STROUT", "JSR LINEBREAK"));
	    this.add(new Pattern("INTOUT + LINEBRK", new String[] { "JSR INTOUTBRK" }, "JSR INTOUT", "JSR LINEBREAK"));
	    this.add(new Pattern("POP, REG0, VAR0", new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}" },
		    "JSR POPREAL", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}",
		    "JSR REALFAC"));

	    this.add(new Pattern(false, "Array index is integer (store)",
		    new String[] { "{LINE10}", "{LINE11}", "{LINE12}", "{LINE13}", "{LINE18}", "{LINE19}", "{LINE20}",
			    "{LINE21}", "{LINE0}", "{LINE1}", "{LINE22}_INT" },
		    "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
		    "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "JSR PUSHREAL", "LDA {*}", "LDY {*}", "STA {REG1}",
		    "STY {REG1}", "JSR POPREAL", "LDX #<{REG2}", "LDY #>{REG2}", "JSR FACMEM", "LDA #<{MEM2}",
		    "LDY #>{MEM2}", "STA G_REG", "STY G_REG+1", "JSR ARRAYSTORE{*}"));
	    this.add(new Pattern(false, "Array index is integer (load)",
		    new String[] { "{LINE6}", "{LINE7}", "{LINE8}", "{LINE9}", "{LINE0}", "{LINE1}", "{LINE10}_INT" },
		    "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
		    "LDA #<{MEM1}", "LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "JSR ARRAYACCESS{*}"));
	    this.add(new Pattern(false, "Array content is integer (store)",
		    new String[] { "{LINE0}", "{LINE1}", "STY AS_TMP", "STA AS_TMP+1", "{LINE6}", "{LINE7}", "{LINE8}",
			    "{LINE9}", "JSR ARRAYSTORE_INT_INTEGER" },
		    "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<Y_REG", "LDY #>Y_REG", "JSR FACMEM",
		    "LDA #<{MEM1}", "LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "JSR ARRAYSTORE_INTEGER"));

	    this.add(new Pattern("Avoid PUSH/POP", new String[] { "JSR REALFAC" }, "JSR REALFACPUSH", "NOP",
		    "JSR POPREAL"));

	    this.add(new Pattern("Quick copy into REG",
		    new String[] { "{LINE0}", "{LINE1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "{LINE3}", "{LINE4}",
			    "JSR COPY2_XY" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM"));
	    this.add(new Pattern(false, "Simplified CMP with 0", new String[] { "{LINE0}", "LDA $61" }, "JSR REALFAC",
		    "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC",
		    "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC"));
	    this.add(new Pattern("REG0->REG1, REG1->REG0", new String[] { "{LINE0}", "{LINE1}", "{LINE2}" },
		    "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC",
		    "LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM", "LDA #<{REG1}", "LDY #>{REG1}", "JSR REALFAC",
		    "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC"));
	    this.add(new Pattern("REG0->VAR, REG0->REG1", new String[] { "{LINE6}", "{LINE7}", "{LINE8}" },
		    "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC",
		    "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC",
		    "LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM", "LDA #<{REG1}", "LDY #>{REG1}", "JSR REALFAC"));

	    this.add(new Pattern("FAC into REG?, REG? into FAC", null, "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
		    "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC"));

	    this.add(new Pattern("INT to FAC, FAC to INT", new String[] { "{LINE0}", "{LINE1}" }, "LDY {*}", "LDA {*}",
		    "JSR INTFAC", "JSR FACINT"));

	    this.add(new Pattern("STY A...LDY A...STY B", new String[] { "{LINE0}", "{LINE3}" }, "STY {MEM0}",
		    "LDY {MEM0}", "LDA #0", "STY {*}"));
	    this.add(new Pattern("FAC to INT, INT to FAC", null, "JSR INTFAC", "JSR FACINT"));
	    this.add(new Pattern("VAR into FAC, FAC into VAR", null, "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC",
		    "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM"));

	    this.add(new Pattern(false, "CHR with integer constant", new String[] { "LDA {MEM0}", "JSR CHRINT" },
		    "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "JSR CHR"));
	    this.add(new Pattern(false, "NEXT check simplified",
		    new String[] { "JSR NEXT", "LDA A_REG", "{LINE8}", "JMP (JUMP_TARGET)" }, "JSR NEXT", "LDY {MEM0}",
		    "LDA {MEM0}", "CPY A_REG", "BNE {*}", "CMP A_REG+1", "BNE {*}", "{LABEL}", "BNE {*}",
		    "JMP (JUMP_TARGET)"));
	    this.add(new Pattern(false, "Multiple loads of the same value(1)",
		    new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE9}",
			    "{LINE10}", "{LINE11}" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM"));
	    this.add(new Pattern(false, "Multiple loads of the same value(2)",
		    new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}",
			    "{LINE11}", "{LINE12}", "{LINE13}" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
		    "JSR COPY2_XY", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}",
		    "LDY #>{REG1}", "JSR COPY2_XY"));
	    this.add(new Pattern("Value already in X",
		    new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "TXA", "{LINE4}" }, "LDX #<{REG0}", "LDY #>{REG0}",
		    "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}"));
	    this.add(new Pattern(false, "Variable used twice in calculation",
		    new String[] { "{LINE3}", "{LINE4}", "{LINE5}", "TXA", "{LINE10}", "{LINE8}", "{LINE9}", "{LINE10}",
			    "{LINE11}", "{LINE12}" },
		    "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDX #<{REG1}", "LDY #>{REG1}", "JSR COPY2_XY",
		    "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}", "LDY #>{REG1}", "JSR MEMARG",
		    "JSR {*}"));
	    this.add(new Pattern("Avoid INTEGER->REAL conversion", true,
		    new String[] { "LDA #<{CONST0}R", "LDY #>{CONST0}R", "JSR REALFAC" }, "LDY {CONST0}",
		    "LDA {CONST0}", "JSR INTFAC"));
	    this.add(new Pattern(false, "Array value used twice in calculation",
		    new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}",
			    "{LINE7}", "{LINE8}", "{LINE9}", "{LINE10}", "{LINE11}", "{LINE12}", "{LINE13}", "{LINE14}",
			    "{LINE12}", "{LINE13}", "JSR MEMARG" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
		    "JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}",
		    "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "JSR PUSHREAL", "LDA #<{MEM0}", "LDY #>{MEM0}",
		    "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{MEM1}",
		    "LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}", "JSR POPREAL", "LDA #<{REG0}",
		    "LDY #>{REG0}", "JSR MEMARG"));
	    this.add(new Pattern("Constant directly into FAC",
		    new String[] { "LDA #0", "STA $61", "{LINE2}", "{LINE3}", "LDA #0", "STA $63", "STA $64", "STA $65",
			    "LDY #128", "STY $62", "INY", "STY $61", "LDY #$FF", "STY $66", "{LINE6}", "{LINE8}" },
		    "LDA #<REAL_CONST_ZERO", "LDY #>REAL_CONST_ZERO", "JMP {*}", "{LABEL}",
		    "LDA #<REAL_CONST_MINUS_ONE", "LDY #>REAL_CONST_MINUS_ONE", "{LABEL}", "JSR REALFAC", "LDA $61"));
	    this.add(new Pattern(false, "Highly simplified loading for CMP",
		    new String[] { "{LINE0}", "{LINE1}", "JSR REALFAC", "{LINE7}", "{LINE8}", "{LINE19}" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
		    "JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}",
		    "LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}",
		    "LDY #>{REG1}", "JSR CMPFAC"));
	    this.add(new Pattern(false, "Highly simplified loading for calculations",
		    new String[] { "{LINE0}", "{LINE1}", "JSR REALFAC", "{LINE7}", "{LINE8}", "{LINE19}", "{LINE20}" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
		    "JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}",
		    "LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}",
		    "LDY #>{REG1}", "JSR MEMARG", "JSR {*}"));
	    this.add(new Pattern(false, "NEXT with no variable name simplified",
		    new String[] { "LDA #0", "STA A_REG", "STA A_REG+1", "JSR NEXT" }, "LDY {CONST0}", "LDA {CONST0}",
		    "STY A_REG", "STA A_REG+1", "JSR NEXT"));
	    this.add(new Pattern("Improved copy from REG0 to REG1",
		    new String[] { "{LINE0}", "{LINE1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "{LINE3}", "{LINE4}",
			    "JSR COPY2_XY" },
		    "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM"));
	    this.add(new Pattern(false, "Fast SQRT", new String[] { "JSR SQRT" }, "JSR FACSQR"));
	    this.add(new Pattern(false, "Fast address push", new String[] { "{LINE4}", "{LINE5}", "{LINE6}" },
		    "STA {REG0}", "STY {REG0}", "LDA {REG0}", "LDY {REG0}", "STA TMP_ZP", "STY TMP_ZP+1",
		    "JSR PUSHINT"));
	    this.add(new Pattern(false, "Simplified loading of Strings",
		    new String[] { "{LINE4}", "{LINE5}", "{LINE6}", "{LINE7}", "{LINE8}" }, "STA {REG0}", "STY {REG0}",
		    "LDA {REG0}", "LDY {REG0}", "STA TMP_ZP", "STY TMP_ZP+1", "LDA #<{MEM0}", "LDY #>{MEM0}",
		    "JSR COPYSTRING"));
	    this.add(new Pattern("MEM->REG, REG->TMP_ZP", new String[] { "{LINE0}", "{LINE1}", "{LINE6}", "{LINE7}" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "STA {REG0}", "STY {REG0}", "LDA {REG0}", "LDY {REG0}",
		    "STA TMP_ZP", "STY TMP_ZP+1"));
	    this.add(new Pattern("Direct loading of values into FAC", new String[] { "{LINE0}", "{LINE1}", "{LINE9}" },
		    "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<Y_REG", "LDY #>Y_REG",
		    "JSR COPY2_XY", "TXA", "LDY #>Y_REG", "JSR REALFAC"));
	    this.add(new Pattern(false, "POP, REG0, VAR0 -> direct calc",
		    new String[] { "{LINE0}", "{LINE4}", "{LINE5}", "{LINE6}", "{LINE7}" }, "JSR POPREAL",
		    "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG1}", "LDY #>{REG1}", "JSR MEMARG",
		    "JSR {*}"));
	    this.add(new Pattern(false, "POP, REG0, VAR0 -> to WORD", new String[] { "{LINE0}", "{LINE4}" },
		    "JSR POPREAL", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "JSR FACWORD"));
	    this.add(new Pattern(false, "Load and PUSH combined", new String[] { "JSR REALFACPUSH" }, "JSR REALFAC",
		    "JSR PUSHREAL"));
	    this.add(new Pattern(false, "Memory saving copy",
		    new String[] { "{LINE1}", "{LINE2}", "{LINE3}", "JSR COPY2_XYA" }, "STA TMP3_ZP", "STY TMP3_ZP+1",
		    "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY"));
	    this.add(new Pattern(false, "Memory saving array access (real)",
		    new String[] { "{LINE0}", "{LINE1}", "JSR ARRAYACCESS_REAL_S" }, "LDA #<{MEM0}", "LDY #>{MEM0}",
		    "STA G_REG", "STY G_REG+1", "JSR ARRAYACCESS_REAL"));
	    this.add(new Pattern(false, "Memory saving array access (integer)",
		    new String[] { "{LINE0}", "{LINE1}", "JSR ARRAYACCESS_INTEGER_S" }, "LDA #<{MEM0}", "LDY #>{MEM0}",
		    "STA G_REG", "STY G_REG+1", "JSR ARRAYACCESS_INTEGER"));
	    this.add(new Pattern(false, "POPREAL and load X", new String[] { "JSR POPREAL2X" }, "JSR POPREAL",
		    "LDA #<X_REG", "LDY #>X_REG", "JSR MEMARG"));
	    this.add(new Pattern(false, "Simplified CMP redux",
		    new String[] { "{LINE0}", "{LINE2}", "{LINE3}", "LDA #$1", "{LINE14}", "{LINE16}", "{LINE17}", },
		    "LDA #0", "STA $61", "JMP {*}", "{LABEL}", "LDA #0", "STA $63", "STA $64", "STA $65", "LDY #128",
		    "STY $62", "INY", "STY $61", "LDY #$FF", "STY $66", "{LABEL}", "LDA $61", "{LABEL}", "BNE {*}"));
	    this.add(new Pattern(false, "CMP (REG) = 0", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
		    "BEQ {*}", "LDA #0"));
	    this.add(new Pattern(false, "CMP (REG) != 0", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
		    "BNE {*}", "LDA #0"));
	    this.add(new Pattern(false, "CMP (MEM) = 0", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
		    "BEQ {*}", "LDA #0"));
	    this.add(new Pattern(false, "CMP (MEM) != 0", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
		    "BNE {*}", "LDA #0"));

	    this.add(new Pattern(false, "CMP (REG) = 0(2)", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
		    "{LABEL}", "BEQ {*}"));
	    this.add(new Pattern(false, "CMP (REG) != 0(2)", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
		    "{LABEL}", "BNE {*}"));
	    this.add(new Pattern(false, "CMP (MEM) = 0(2)", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
		    "{LABEL}", "BEQ {*}"));
	    this.add(new Pattern(false, "CMP (MEM) != 0(2)", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
		    "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
		    "{LABEL}", "BNE {*}"));
	    this.add(new Pattern(false, "Direct loading of 0", new String[] { "LDA #$0", "STA $61" }, "LDA #<{#0.0}",
		    "LDY #>{#0.0}", "JSR REALFAC"));

	    this.add(new Pattern(false, "FAC into REG?, REG? into FAC (2)",
		    new String[] { "{LINE0}", "{LINE1}", "{LINE2}" }, "LDY #>{REG0}", "LDX #<{REG0}", "JSR FACMEM",
		    "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC"));
	    this.add(new Pattern(false, "Fast INTEGER array access (1)",
		    new String[] { "JSR ARRAYACCESS_INTEGER_SI", "{LINE5}", "{LINE6}" }, "JSR ARRAYACCESS_INTEGER_S",
		    "LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT", "STY {MEM0}", "STA {MEM0}"));

	    this.add(new Pattern(false, "Fast INTEGER array access (2)",
		    new String[] { "JSR ARRAYACCESS_INTEGER_INT_SI", "{LINE5}", "{LINE6}" },
		    "JSR ARRAYACCESS_INTEGER_INT", "LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT",
		    "STY {MEM0}", "STA {MEM0}"));

	    this.add(new Pattern(false, "Fast INTEGER INC", new String[] { "{LINE0}", "{LINE1}", "JSR FIINX" },
		    "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<X_REG", "LDY #>X_REG", "JSR FACMEM", "JSR FINX"));
	    this.add(new Pattern(false, "Fast INTEGER DEC", new String[] { "{LINE0}", "{LINE1}", "JSR FIDEX" },
		    "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<X_REG", "LDY #>X_REG", "JSR FACMEM", "JSR FDEX"));
	    this.add(new Pattern(false, "Even faster INTEGER INC", new String[] { "JSR SUPERFIINX" }, "JSR FIINX",
		    "LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT"));
	    this.add(new Pattern(false, "Even faster INTEGER DEC", new String[] { "JSR SUPERFIDEX" }, "JSR FIDEX",
		    "LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT"));
	    this.add(new Pattern(false, "Store and load", new String[] { "{LINE0}", "{LINE1}", "NOP" }, "STY {MEM0}",
		    "STA {MEM0}", "NOP", "LDY {MEM0}", "LDA {MEM0}"));
	    this.add(new Pattern(false, "Memory saving STROUT", new String[] { "JSR STROUTWL" }, "STA A_REG",
		    "STY A_REG+1", "JSR STROUT"));
	    this.add(new Pattern(false, "Memory saving STROUTBRK", new String[] { "JSR STROUTBRKWL" }, "STA A_REG",
		    "STY A_REG+1", "JSR STROUTBRK"));
	    this.add(new Pattern(false, "Simplified loading of A",
		    new String[] { "{LINE0}", "{LINE1}", "STX A_REG", "STY A_REG+1", "{LINE2}" }, "LDX #<{MEM0}",
		    "LDY #>{MEM0}", "JSR FACMEM", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA A_REG", "STY A_REG+1"));
	}
    };

    @Override
    public List<String> optimize(PlatformProvider platform, List<String> input) {
	return optimize(platform, input, null);
    }

    @Override
    public List<String> optimize(PlatformProvider platform, List<String> input, ProgressListener pg) {
	// if (true) return input;
	Logger.log("Optimizing native assembly code...");
	long s = System.currentTimeMillis();
	Map<String, Integer> type2count = new HashMap<>();
	Map<String, Number> const2Value = extractConstants(input);
	trimLines(input);

	input = trackAndModifyRegisterUsage(input);

	Set<Pattern> used = new HashSet<Pattern>();
	boolean optimized = false;

	int lastPattern = -1;
	int lastLine = input.size();

	int codeEnd = input.size();
	int codeStart = 0;
	for (int i = 0; i < input.size(); i++) {
	    String line = input.get(i);
	    if (line.startsWith("; *** CODE ***")) {
		codeStart = i;
	    }
	    if (line.startsWith("; *** SUBROUTINES ***")) {
		codeEnd = i;
		break;
	    }
	}

	if (codeStart == 0 || codeEnd == input.size()) {
	    Logger.log("WARNING: Unable to determine code start or end: " + codeStart + "/" + codeEnd + "/"
		    + input.size());
	}

	if (pg != null) {
	    pg.start();
	}
	do {
	    optimized = false;
	    if (pg != null) {
		pg.nextStep();
	    }

	    int start = 0;
	    int lastPattern2 = lastPattern;
	    if (lastLine != input.size()) {
		start = lastLine;
		lastLine = input.size();
		lastPattern = -1;
	    }

	    int pcnt = 0;
	    for (Pattern pattern : patterns) {
		pcnt++;
		if (pattern.isLooseTypes() && !platform.useLooseTypes()) {
		    continue;
		}
		if (used.contains(pattern)) {
		    continue;
		}

		int stl = codeStart;
		if (pcnt <= lastPattern2) {
		    stl = start;
		}

		for (int i = stl; i < codeEnd; i++) {
		    String line = input.get(i);
		    int sp = pattern.getPos();
		    boolean matches = pattern.matches(line, i, const2Value);
		    if (matches) {
			String name = pattern.getName();
			Integer cnt = type2count.get(name);
			if (cnt == null) {
			    type2count.put(name, 1);
			} else {
			    type2count.put(name, cnt + 1);
			}
			int oldSize = input.size();
			input = pattern.apply(input);
			codeEnd -= (oldSize - input.size());
			optimized = true;
			int iLine = i - pattern.getSourceSize() - 1;
			if (iLine <= lastLine) {
			    lastLine = iLine;
			    lastPattern = pcnt;
			}
			break;
		    }
		    if (pattern.getPos() == 0 && sp > 1) {
			i--;
		    }
		}
		if (optimized) {
		    break;
		} else {
		    if (!pattern.isSimple()) {
			used.add(pattern);
		    }
		}
	    }
	} while (optimized);

	if (pg != null) {
	    pg.done();
	}

	for (Map.Entry<String, Integer> cnts : type2count.entrySet()) {
	    Logger.log("Optimization " + cnts.getKey() + " applied " + cnts.getValue() + " times!");
	}

	input = applySpecialRules(input);
	input = removeNops(input);
	Logger.log("Assembly code optimized in " + (System.currentTimeMillis() - s) + "ms");
	return input;
    }

    private void trimLines(List<String> input) {
	for (int i = 0; i < input.size(); i++) {
	    String line = input.get(i).trim();
	    if (line.startsWith("; *** SUBROUTINES ***")) {
		break;
	    }
	    input.set(i, line);
	}
    }

    private Map<String, Number> extractConstants(List<String> input) {
	Map<String, Number> const2Value = new HashMap<>();
	for (String line : input) {
	    line = line.replace("\t", " ");
	    if (line.startsWith("CONST_")) {
		int pos = line.indexOf(" ");
		if (pos != -1) {
		    String name = line.substring(0, pos).trim();
		    String right = line.substring(pos + 1).trim();
		    pos = right.indexOf(" ");
		    if (pos != -1) {
			String type = right.substring(0, pos).trim();
			String number = right.substring(pos + 1).trim();
			if (type.equals(".REAL") || type.equals(".WORD")) {
			    try {
				Float num = Float.valueOf(number);
				if (type.equals(".REAL")) {
				    const2Value.put(name, num);
				} else {
				    const2Value.put(name, num.intValue());
				}
			    } catch (Exception e) {
				Logger.log("Failed to parse " + number + " as a number!");
			    }
			}
		    }
		}
	    }
	}
	return const2Value;
    }

    private List<String> removeNops(List<String> input) {
	for (Iterator<String> itty = input.iterator(); itty.hasNext();) {
	    if (itty.next().equals("NOP")) {
		itty.remove();
	    }
	}
	return input;
    }

    private List<String> applySpecialRules(List<String> input) {
	input = simplifyBranches(input);
	return aggregateLoads(input);
    }

    private List<String> aggregateLoads(List<String> input) {
	boolean loadMode = false;
	for (Iterator<String> itty = input.iterator(); itty.hasNext();) {
	    String line = itty.next().trim();
	    if (line.startsWith(";") || line.isEmpty() || line.equals("NOP")) {
		continue;
	    }
	    if (!loadMode && (line.equals("LDA #0") || line.equals("LDA #$0"))) {
		loadMode = true;
	    } else {
		if (loadMode) {
		    if (line.equals("LDA #0") || line.equals("LDA #$0")) {
			itty.remove();
		    } else if (!line.startsWith("STA")) {
			loadMode = false;
		    }
		}
	    }
	}
	return input;
    }

    private List<String> trackAndModifyRegisterUsage(List<String> code) {
	Map<String, Integer[]> regState = new HashMap<>();
	Set<Integer> swaps = new HashSet<>();
	String lastReg = "";
	for (int i = 0; i < code.size(); i++) {
	    String line = code.get(i);
	    if (line.startsWith(";")) {
		continue;
	    }

	    if (line.startsWith("JMP") || line.startsWith("B") || line.startsWith("RTS")) {
		regState.clear();
		lastReg = "";
	    }

	    if (line.startsWith("L") && line.endsWith("_REG")) {
		String reg = line.substring(line.indexOf(" ")).trim();
		lastReg = reg;
		Integer[] state = regState.get(reg);

		if (state == null) {
		    regState.put(reg, new Integer[] { 0, i }); // Unknown
							       // stage...yet
		} else {
		    if (code.get(i + 2).startsWith("JSR FACMEM")) {
			regState.put(reg, new Integer[] { 1, i });
		    }
		}
	    } else {
		Integer[] state = regState.get(lastReg);
		if (state != null) {
		    if (line.startsWith("JSR FACMEM")) {
			regState.put(lastReg, new Integer[] { 1, state[1] });
		    } else {
			if (line.startsWith("JSR REALFAC") || line.startsWith("JSR MEMARG")) {

			    if (state[0] < 2) {
				regState.put(lastReg, new Integer[] { 2, state[1] });
			    } else {
				if (!swaps.contains(state[1])) {
				    // The value from the register is read
				    // without
				    // being written before again...don't
				    // optimize
				    // the initial setter away...
				    // ...so we swap the order of that setter to
				    // prevent this.
				    String l1 = code.get(state[1]);
				    String l0 = code.get(state[1] - 1);
				    code.set(state[1] - 1, l1);
				    code.set(state[1], l0);

				    Logger.log("Swapped: " + l0 + "/" + l1 + "@" + state[1]);
				    swaps.add(state[1]);
				}
			    }
			} else {
			    lastReg = "";
			}
		    }
		} else {
		    lastReg = "";
		}
	    }
	}
	return code;
    }

    private List<String> simplifyBranches(List<String> input) {
	List<String> ret = new ArrayList<String>();
	for (int i = 0; i < input.size() - 2; i++) {
	    String line = trimLine(input, i);
	    String line2 = trimLine(input, i + 1);
	    String line3 = trimLine(input, i + 2);
	    if (line.startsWith("; *** SUBROUTINES ***")) {
		ret.addAll(input.subList(i, input.size()));
		break;
	    }
	    boolean skip = false;
	    int add = 1;
	    if (line2.startsWith(";")) {
		line2 = line3;
		add = 2;
	    }
	    if (line.contains("BNE LINE_NSKIP") && line2.contains("JMP LINE_SKIP")) {
		for (int p = i + 1; p < Math.min(input.size(), i + 30); p++) {
		    String subLine = input.get(p);
		    if (subLine.startsWith("LINE_SKIP")) {
			ret.add(line2.replace("JMP LINE_SKIP", "BEQ LINE_SKIP"));
			ret.add("; Simplified conditional branch");
			skip = true;
			i += add;
			break;
		    }
		}
	    }
	    if (skip) {
		continue;
	    }
	    ret.add(line);
	}
	return ret;
    }

    private String trimLine(List<String> input, int i) {
	String line3 = input.get(i);
	line3 = line3.replace("\t", " ").trim();
	return line3;
    }
}
