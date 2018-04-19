package com.sixtyfour.test;

import java.util.Arrays;

import com.sixtyfour.Assembler;
import com.sixtyfour.Loader;
import com.sixtyfour.plugins.CpuCallListener;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;

public class AssemblerTest {
	public static void main(String[] args) {
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
		testShift();
		testCpxCpy();
		testBit();
		testJumps();
		testReturns();
		testBranches();
		testTheRest();
		testLowByteHighByte();
		testAssembler();
		testAssembler2();
		testCpuRun();
		testMath();
		testSelfModify();
		testCpuCallListener();
		testConstants();
		testE46();
		testFastCopy();
	}

	private static void testFastCopy() {
	    System.out.println("\ntestFastCopy");
		String[] code = Loader.loadProgram("src/test/resources/asm/fastcopy.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		asm.run();
		System.out.println(asm.toString());
		for (int i=49152; i<49250; i++) {
		    System.out.print(Integer.toHexString(asm.getRam()[i])+",");
		}
		System.out.println();
	}

	
	private static void testConstants() {
		String line = "*=$c000  \n";
		line += "CONST=$c000 \n";
		line += "ELSE=$200 \n";
		line += "lda CONST \n";
		line += "lda CONST+100 \n";
		line += "lda CONST-ELSE \n";
		execute(line);
	}

	private static void testCpuCallListener() {
		String[] code = Loader.loadProgram("src/test/resources/asm/calllistener.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		asm.getCpu().setCpuCallListener(new CpuCallListener() {
			@Override
			public boolean jsr(Cpu cpu, int addr) {
				System.out.println("Called JSR " + addr);
				return true;
			}
		});
		asm.run();
		System.out.println("Value written: " + asm.getMachine().getRam()[8192]);
	}

	private static void testSelfModify() {
		String[] code = Loader.loadProgram("src/test/resources/asm/selfmodify.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		Machine machine = asm.getMachine();
		int[] ram = machine.getRam();

		ram[0x2000] = 0xff;
		ram[0x2222] = 0xfe;
		ram[0x3567] = 0xfa;

		asm.run();
		System.out.println(ram[0x2000] + ram[0x2222] + ram[0x3567]);

		System.out.println(asm.toString());
	}

	private static void testMath() {
		String[] code = Loader.loadProgram("src/test/resources/asm/math.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		Program prg = asm.getProgram();
		Machine machine = asm.getMachine();
		int[] ram = machine.getRam();

		ram[0x62] = 0x10;
		ram[0x63] = 0x20;

		ram[0x64] = 0x22;
		ram[0x65] = 0x31;

		asm.run();
		System.out.println(ram[0x66] + 256 * ram[0x67]);

		prg.setCodeStart(0xc100);

		ram[0x62] = 0x10;
		ram[0x63] = 0xae;
		asm.run();
		System.out.println(ram[0x66] + 256 * ram[0x67]);
	}

	private static void testLowByteHighByte() {
		String line = "*=$c000  \n TEST=$cf12 \n";
		line += "lda #<TEST \n";
		line += "ldx #>TEST \n";
		execute(line);
	}

	private static void testTheRest() {
		String line = "*=$c000  \n";
		line += "Sec \n";
		line += "Clc \n";
		line += "Sei \n";
		line += "Cli \n";
		line += "Clv \n";
		line += "Sld \n";
		line += "Cld \n";
		line += "Pha \n";
		line += "Pla \n";
		line += "Php \n";
		line += "Plp \n";
		line += "Nop \n";
		line += "Brk \n";
		execute(line);
	}

	private static void testBranches() {
		String line = "*=$c000  \n";
		line += "bcc $c010 \n";
		line += "bne $c080 \n";
		line += "bcs $bff0 \n";
		line += "bmi $c010 \n";
		line += "bpl $c080 \n";
		line += "bvc $bff0 \n";
		line += "bvs $bff0 \n";
		execute(line);
	}

	private static void testReturns() {
		String line = "*=$c000  \n";
		line += "rti \n";
		line += "rts \n";
		execute(line);
	}

	private static void testJumps() {
		String line = "*=$c000  \n";
		line += "jsr $ffff \n";
		line += "jsr $fa \n";
		line += "jmp $fedd \n";
		line += "jmp $fe \n";
		line += "jmp ($fedd) \n";
		execute(line);
	}

	private static void testBit() {
		String line = "*=$c000  \n TEST=$a001 \n ";
		line += "bit $ffff \n";
		line += "bit $fe \n";
		line += "bit TEST \n";
		execute(line);
	}

	private static void testCpxCpy() {
		String line = "*=$c000  \n TEST=$a001 \n  cpx #$c0 \n";
		line += "cpx $ffff \n";
		line += "cpx $fe \n";
		line += "cpx TEST \n";
		line += "cpy #$c0 \n";
		line += "cpy $ffff \n";
		line += "cpy $fe \n";
		line += "cpy TEST \n";
		execute(line);
	}

	private static void testShift() {
		String line = "*=$c000  \n TEST=%1100110011 \n asl $c001\n";
		line += "asl $ffff,x \n";
		line += "asl $fe \n";
		line += "asl $fd,X \n";
		line += "asl TEST \n";
		line += "lsr $ffff,x \n";
		line += "lsr $fe \n";
		line += "lsr $fd,X \n";
		line += "lsr TEST \n";
		line += "ror $ffff,x \n";
		line += "ror $fe \n";
		line += "ror $fd,X \n";
		line += "ror TEST \n";
		line += "rol $ffff,x \n";
		line += "rol $fe \n";
		line += "rol $fd,X \n";
		line += "rol TEST \n";
		line += "asl\n";
		line += "lsr\n";
		line += "ror\n";
		line += "rol\n";
		execute(line);
	}

	private static void testInxDex() {
		String line = "*=$c000  \n";
		line += "inx \n";
		line += "dex \n";
		line += "iny \n";
		line += "dey \n";
		execute(line);
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
		execute(line);
	}

	private static void testCmp() {
		String line = "*=$c000  \n TEST=$a001 \n  cmp #$c0 \n";
		line += "cmp $ffff \n";
		line += "cmp $fe \n";
		line += "cmp $fd,X \n";
		line += "cmp ($fc,X) \n";
		line += "cmp ($fb),y \n";
		line += "cmp TEST \n";
		execute(line);
	}

	private static void testAnd() {
		String line = "*=$c000  \n TEST=$a001 \n  and #$c0 \n";
		line += "and $ffff \n";
		line += "and $fe \n";
		line += "and $fd,X \n";
		line += "and ($fc,X) \n";
		line += "and ($fb),y \n";
		line += "and TEST \n";
		execute(line);
	}

	private static void testOra() {
		String line = "*=$c000  \n TEST=$a001 \n  ora #$c0 \n";
		line += "ora $ffff \n";
		line += "ora $fe \n";
		line += "ora $fd,X \n";
		line += "ora ($fc,X) \n";
		line += "ora ($fb),y \n";
		line += "ora TEST \n";
		execute(line);
	}

	private static void testEor() {
		String line = "*=$c000  \n TEST=$a001 \n  eor #$c0 \n";
		line += "eor $ffff \n";
		line += "eor $fe \n";
		line += "eor $fd,X \n";
		line += "eor ($fc,X) \n";
		line += "eor ($fb),y \n";
		line += "eor TEST \n";
		execute(line);
	}

	private static void testAdc() {
		String line = "*=$c000  \n TEST=$a001 \n  adc #$c0 \n";
		line += "adc $ffff \n";
		line += "adc $fe \n";
		line += "adc $fd,X \n";
		line += "adc ($fc,X) \n";
		line += "adc ($fb),y \n";
		line += "adc TEST \n";
		execute(line);
	}

	private static void testSbc() {
		String line = "*=$c000  \n TEST=$a001 \n  sbc #$c0 \n";
		line += "sbc $ffff \n";
		line += "sbc $fe \n";
		line += "sbc $fd,X \n";
		line += "sbc ($fc,X) \n";
		line += "sbc ($fb),y \n";
		line += "sbc TEST \n";
		execute(line);
	}

	private static void testTransfer() {
		String line = "*=$c000  \n";
		line += "tax \n";
		line += "tay \n";
		line += "tsx \n";
		line += "txa \n";
		line += "tya \n";
		line += "txs \n";
		execute(line);
	}

	private static void execute(String line) {
		Assembler asm = new Assembler(line);
		asm.compile();
		int[] bin = asm.getProgram().getParts().get(0).getBytes();
		System.out.println(Arrays.toString(bin));
	}

	private static void testStx() {
		String line = "*=$c000  \n TEST=$a001 \n  stx $c011 \n";
		line += "stx $ffff \n";
		line += "stx $fe \n";
		line += "stx $fd,Y \n";
		line += "stx TEST \n";
		execute(line);
	}

	private static void testSty() {
		String line = "*=$c000  \n TEST=$a001 \n  sty $c011 \n";
		line += "sty $ffff \n";
		line += "sty $fe \n";
		line += "sty $fd,X \n";
		line += "sty TEST \n";
		execute(line);
	}

	private static void testSta() {
		String line = "*=$c000  \n TEST=$a001 \n  sta $c011 \n";
		line += "sta $ffff \n";
		line += "sta $fe \n";
		line += "sta $fd,X \n";
		line += "sta ($fc,X) \n";
		line += "sta ($fb),y \n";
		line += "sta TEST \n";
		execute(line);
	}

	private static void testLda() {
		String line = "*=$c000  \n TEST=$a001 \n  lda #$c0 \n";
		line += "lda $ffff \n";
		line += "lda $fe \n";
		line += "lda $fd,X \n";
		line += "lda ($fc,X) \n";
		line += "lda ($fb),y \n";
		line += "lda TEST \n";
		execute(line);
	}

	private static void testLdx() {
		String line = "*=$c000  \n TEST=$a001 \n  ldx #$c0 \n";
		line += "ldx $ffff \n";
		line += "ldx $fe \n";
		line += "ldx $fd,Y \n";
		line += "ldx $bbbb,y \n";
		line += "ldx TEST \n";
		execute(line);
	}

	private static void testLdy() {
		String line = "*=$c000  \n TEST=$a001 \n  ldy #$c0 \n";
		line += "ldy $ffff \n";
		line += "ldy $fe \n";
		line += "ldy $fd,x \n";
		line += "ldy $bbbb,x \n";
		line += "ldy TEST \n";
		execute(line);
	}

	private static void testAssembler() {
		String[] code = Loader.loadProgram("src/test/resources/asm/example.asm");
		runAssembler(code);
	}

	private static void testAssembler2() {
		String[] code = Loader.loadProgram("src/test/resources/asm/example2.asm");
		runAssembler(code);
	}

	private static void testE46() {
		String[] code = Loader.loadProgram("src/test/resources/asm/e45.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		System.out.println(asm.toString());
		asm.run();
		for (int i = 1024; i < 1050; i++) {
			System.out.println(asm.getMachine().getRam()[i]);
		}
		int[] bin = asm.getProgram().getParts().get(0).getBytes();
		System.out.println(Arrays.toString(bin));
	}

	private static void testCpuRun() {
		String[] code = Loader.loadProgram("src/test/resources/asm/example3.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		Cpu cpu = asm.getCpu();
		cpu.setExitOnBreak(false);
		System.out.println(asm.toString());
		System.out.println("---------------------------------");
		System.out.println("Running program...");
		cpu.setCpuTracer(new CpuTracer() {
			@Override
			public void commandExecuted(Cpu cpu, int opcode, int lastPc, int pc) {
				System.out.println("@ ." + Integer.toHexString(lastPc) + "\t" + Integer.toHexString(opcode) + "/" + Integer.toBinaryString(cpu.getStatus()));

			}

			@Override
			public void exception(Cpu cpu, int opcode, int opcodePc, int newPc) {
				// TODO Auto-generated method stub

			}
		});
		asm.run();
		outputRunResults(asm.getMachine(), cpu);

		cpu.setCpuTracer(null);
		cpu.reset();
		cpu.setClockTicks(0);
		cpu.execute(49152);
		outputRunResults(asm.getMachine(), cpu);
	}

	private static void outputRunResults(Machine machine, Cpu cpu) {
		System.out.println("Done: " + cpu.getY() + "/" + machine.getRam()[1500] + " in " + cpu.getClockTicks() + " clock ticks!");
		int[] ram = machine.getRam();
		for (int i = 1024; i < 1035; i++) {
			System.out.print((char) ram[i]);
		}
		System.out.println();
		for (int i = 1064; i < 1093; i++) {
			System.out.print((char) ram[i]);
		}
		System.out.println();
	}

	private static void runAssembler(String[] code) {
		Assembler asm = new Assembler(code);
		asm.compile();
		Program prg = asm.getProgram();
		int[] bin = prg.getParts().get(0).getBytes();
		System.out.println(Arrays.toString(bin));
		System.out.println("-----------------------------");
		System.out.println(asm.toString());
		System.out.println("-----------------------------");
	}

}
