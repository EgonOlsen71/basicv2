package com.sixtyfour.test;

import java.util.Arrays;

import com.sixtyfour.Assembler;
import com.sixtyfour.Loader;

public class AssemblerTest {
	public static void main(String[] args) {
		// testAssembler();
		testLda();
		testLdx();
		testLdy();
		testSta();
		testStx();
		testSty();
		testTransfer();
		testAnd();
		testOra();
		testEor();
		testAdc();
		testSbc();
		testCmp();
		testIncDec();
		testInxDex();
	}

	private static void testInxDex() {
		String line = "*=$c000  \n";
		line += "inx \n";
		line += "dex \n";
		line += "iny \n";
		line += "dey \n";
		printResults(line);
	}

	private static void testIncDec() {
		String line = "*=$c000  \n TEST=%1100110011 \n inc $c001\n";
		line += "inc $ffff,x \n";
		line += "inc $fe \n";
		line += "inc $fd,X \n";
		line += "inc TEST \n";
		line += "dec $ffff,x \n";
		line += "dec $fe \n";
		line += "dec $fd,X \n";
		line += "dec TEST \n";
		printResults(line);
	}

	private static void testCmp() {
		String line = "*=$c000  \n TEST=$a001 \n  cmp #$c011 \n";
		line += "cmp $ffff \n";
		line += "cmp $fe \n";
		line += "cmp $fd,X \n";
		line += "cmp ($fc,X) \n";
		line += "cmp ($fb),y \n";
		line += "cmp TEST \n";
		printResults(line);
	}

	private static void testAnd() {
		String line = "*=$c000  \n TEST=$a001 \n  and #$c011 \n";
		line += "and $ffff \n";
		line += "and $fe \n";
		line += "and $fd,X \n";
		line += "and ($fc,X) \n";
		line += "and ($fb),y \n";
		line += "and TEST \n";
		printResults(line);
	}

	private static void testOra() {
		String line = "*=$c000  \n TEST=$a001 \n  ora #$c011 \n";
		line += "ora $ffff \n";
		line += "ora $fe \n";
		line += "ora $fd,X \n";
		line += "ora ($fc,X) \n";
		line += "ora ($fb),y \n";
		line += "ora TEST \n";
		printResults(line);
	}

	private static void testEor() {
		String line = "*=$c000  \n TEST=$a001 \n  eor #$c011 \n";
		line += "eor $ffff \n";
		line += "eor $fe \n";
		line += "eor $fd,X \n";
		line += "eor ($fc,X) \n";
		line += "eor ($fb),y \n";
		line += "eor TEST \n";
		printResults(line);
	}

	private static void testAdc() {
		String line = "*=$c000  \n TEST=$a001 \n  adc #$c011 \n";
		line += "adc $ffff \n";
		line += "adc $fe \n";
		line += "adc $fd,X \n";
		line += "adc ($fc,X) \n";
		line += "adc ($fb),y \n";
		line += "adc TEST \n";
		printResults(line);
	}

	private static void testSbc() {
		String line = "*=$c000  \n TEST=$a001 \n  sbc #$c011 \n";
		line += "sbc $ffff \n";
		line += "sbc $fe \n";
		line += "sbc $fd,X \n";
		line += "sbc ($fc,X) \n";
		line += "sbc ($fb),y \n";
		line += "sbc TEST \n";
		printResults(line);
	}

	private static void testTransfer() {
		String line = "*=$c000  \n";
		line += "tax \n";
		line += "tay \n";
		line += "tsx \n";
		line += "txa \n";
		line += "tya \n";
		line += "txs \n";
		printResults(line);
	}

	private static void printResults(String line) {
		int[] bin = new Assembler(line).compile().getCode();
		System.out.println(Arrays.toString(bin));
	}

	private static void testStx() {
		String line = "*=$c000  \n TEST=$a001 \n  stx $c011 \n";
		line += "stx $ffff \n";
		line += "stx $fe \n";
		line += "stx $fd,Y \n";
		line += "stx TEST \n";
		printResults(line);
	}

	private static void testSty() {
		String line = "*=$c000  \n TEST=$a001 \n  sty $c011 \n";
		line += "sty $ffff \n";
		line += "sty $fe \n";
		line += "sty $fd,X \n";
		line += "sty TEST \n";
		printResults(line);
	}

	private static void testSta() {
		String line = "*=$c000  \n TEST=$a001 \n  sta $c011 \n";
		line += "sta $ffff \n";
		line += "sta $fe \n";
		line += "sta $fd,X \n";
		line += "sta ($fc,X) \n";
		line += "sta ($fb),y \n";
		line += "sta TEST \n";
		printResults(line);
	}

	private static void testLda() {
		String line = "*=$c000  \n TEST=$a001 \n  lda #$c011 \n";
		line += "lda $ffff \n";
		line += "lda $fe \n";
		line += "lda $fd,X \n";
		line += "lda ($fc,X) \n";
		line += "lda ($fb),y \n";
		line += "lda TEST \n";
		printResults(line);
	}

	private static void testLdx() {
		String line = "*=$c000  \n TEST=$a001 \n  ldx #$c011 \n";
		line += "ldx $ffff \n";
		line += "ldx $fe \n";
		line += "ldx $fd,Y \n";
		line += "ldx $bbbb,y \n";
		line += "ldx TEST \n";
		printResults(line);
	}

	private static void testLdy() {
		String line = "*=$c000  \n TEST=$a001 \n  ldy #$c011 \n";
		line += "ldy $ffff \n";
		line += "ldy $fe \n";
		line += "ldy $fd,x \n";
		line += "ldy $bbbb,x \n";
		line += "ldy TEST \n";
		printResults(line);
	}

	private static void testAssembler() {
		String[] code = Loader.loadProgram("src/test/resources/asm/example.asm");
		Assembler asm = new Assembler(code);
		int[] binary = asm.compile().getCode();
	}

}
