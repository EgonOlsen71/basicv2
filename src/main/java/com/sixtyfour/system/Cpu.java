package com.sixtyfour.system;

import java.util.List;

import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.elements.mnemonics.MnemonicList;
import com.sixtyfour.plugins.CpuCallListener;

/**
 * Cpu is a 6502 emulation. It can be used to run actual binary 6502 code. Cpu
 * can't be instantiated directly but can be obtained from a machine instance.
 * 
 * @author EgonOlsen
 * 
 */
public class Cpu {
	private static final int STACK = 0x100;

	private int acc;
	private int x;
	private int y;
	private int status = 0b00110000;
	private int stackPointer = 0xff;
	private boolean exitOnBreak = true;
	private Machine machine;
	private boolean irq = false;
	private boolean nmi = false;
	private boolean brk = false;
	private int ticks = 0;
	private int pc = 0;
	private int[] ram = null;
	private int tmp = 0;
	private int index = 0;
	private int lo = 0;
	private int hi = 0;
	private int ac = status & 1;
	private boolean paused = false;
	private CpuTracer cpuTracer = null;
	private CpuCallListener cpuCallListener = null;

	/**
	 * Creates a new cpu for a given machine.
	 * 
	 * @param machine
	 *            the machine
	 */
	Cpu(Machine machine) {
		this.machine = machine;
	}

	/**
	 * Gets the cpu tracer. If none has been set, null will be returned.
	 * 
	 * @return the cpu tracer
	 */
	public CpuTracer getCpuTracer() {
		return cpuTracer;
	}

	/**
	 * Sets a new cpu tracer.
	 * 
	 * @param cpuTracer
	 *            the tracer
	 */
	public void setCpuTracer(CpuTracer cpuTracer) {
		this.cpuTracer = cpuTracer;
	}

	/**
	 * Returns the abstract instruction in human readable form.
	 * 
	 * @param opcode
	 *            the opcode to check
	 * @return the instruction
	 */
	public String getInstruction(int opcode) {
		List<Mnemonic> mnes = MnemonicList.getMnemonics();
		for (Mnemonic mne : mnes) {
			String ins = mne.getInstruction(opcode);
			if (ins != null) {
				return ins;
			}
		}
		return null;
	}

	/**
	 * Converts a float from C64 6/7 byte format into Java format.
	 * 
	 * @param addr
	 *            the address, where the float is stored (0x61 for FAC(1))
	 * @return the float value
	 */
	public float convertFloat(int addr) {
		int[] ram = machine.getRam();
		return convertFloat(ram[addr] & 0xff, ram[addr + 5] & 0xff, ram[addr + 4] & 0xff, ram[addr + 3] & 0xff, ram[addr + 2] & 0xff, ram[addr + 1] & 0xff);
	}

	/**
	 * Converts a float from C64 format into Java format.
	 * 
	 * @param exp
	 *            the exponent
	 * @param neg
	 *            the negative flag (either 0 for positive or 0xFF for negative
	 *            values)
	 * @param m1
	 *            the mantissa, part 1
	 * @param m2
	 *            the mantissa, part 2
	 * @param m3
	 *            the mantissa, part 3
	 * @param m4
	 *            the mantissa, part 4
	 * @return the float value
	 */
	public float convertFloat(int exp, int neg, int m1, int m2, int m3, int m4) {
		double expf = exp - 128;
		double man = ((neg != 0 ? -1d : 1d) * ((m4 | 0x80) * Math.pow(2d, -8d) + m3 * (Math.pow(2d, -16d)) + m2 * (Math.pow(2d, -24d)) + m1 * (Math.pow(2d, -32d))));
		return (float) (man * Math.pow(2, expf));
	}

	/**
	 * Returns the number of clock ticks that has passed. Each executed command
	 * will increase this number by the appropriate amount.
	 * 
	 * @return the number of clock ticks
	 */
	public int getClockTicks() {
		return ticks;
	}

	/**
	 * Sets a new clock tick count. This can be used to reset the counter.
	 * Setting this value has no effect on the actual execution of the program.
	 * 
	 * @param ticks
	 *            the new number of ticks
	 */
	public void setClockTicks(int ticks) {
		this.ticks = ticks;
	}

	/**
	 * Causes a none maskable interrupt. This has to be done from a thread other
	 * than the actual execution thread.
	 */
	public synchronized void nmi() {
		nmi = true;
	}

	/**
	 * Causes a maskable interrupt. This has to be done from a thread other than
	 * the actual execution thread.
	 */
	public synchronized void irq() {
		irq = true;
	}

	/**
	 * Stops the exeuction after the next command.
	 */
	public void stop() {
		brk = true;
	}

	/**
	 * Pauses/unpauses the cpu. This has to be done from a thread other than the
	 * actual execution thread.
	 * 
	 * @param paused
	 *            should we pause?
	 */
	public void setPaused(boolean paused) {
		this.paused = paused;
	}

	/**
	 * Returns the current pause state.
	 * 
	 * @return are we paused?
	 */
	public boolean isPaused() {
		return paused;
	}

	/**
	 * Returns the accumulator's content.
	 * 
	 * @return the content
	 */
	public int getAcc() {
		return acc & 0xff;
	}

	/**
	 * Sets the accumulator's content.
	 * 
	 * @param acc
	 *            the new content
	 */
	public void setAcc(int acc) {
		this.acc = acc & 0xff;
	}

	/**
	 * Returns the X register's content.
	 * 
	 * @return the content
	 */
	public int getX() {
		return x & 0xff;
	}

	/**
	 * Sets the X register's content.
	 * 
	 * @param x
	 *            the content
	 */
	public void setX(int x) {
		this.x = x & 0xff;
	}

	/**
	 * Returns the Y register's content.
	 * 
	 * @return the content
	 */
	public int getY() {
		return y & 0xff;
	}

	/**
	 * Sets the Y register's content.
	 * 
	 * @param y
	 *            the content
	 */
	public void setY(int y) {
		this.y = y & 0xff;
	}

	/**
	 * Returns the status register's content.
	 * 
	 * @return the content
	 */
	public int getStatus() {
		return status & 0xff;
	}

	/**
	 * Sets the status register's content.
	 * 
	 * @param status
	 *            the new content
	 */
	public void setStatus(int status) {
		this.status = status & 0xff;
	}

	/**
	 * True, if the carry flag is set.
	 * 
	 * @return is it?
	 */
	public boolean isCarryFlagSet() {
		return (status & 0b00000001) != 0;
	}

	/**
	 * True, if the zero flag is set.
	 * 
	 * @return is it?
	 */
	public boolean isZeroFlagSet() {
		return (status & 0b00000010) != 0;
	}

	/**
	 * True, if the interrupt flag is set.
	 * 
	 * @return is it?
	 */
	public boolean isInterruptFlagSet() {
		return (status & 0b00000100) != 0;
	}

	/**
	 * True, if the decimal flag is set.
	 * 
	 * @return is it?
	 */
	public boolean isDecimalFlagSet() {
		return (status & 0b00001000) != 0;
	}

	/**
	 * True, if the break flag is set.
	 * 
	 * @return is it?
	 */
	public boolean isBreakFlagSet() {
		return (status & 0b00010000) != 0;
	}

	/**
	 * True, if the overflow flag is set.
	 * 
	 * @return is it?
	 */
	public boolean isOverflowFlagSet() {
		return (status & 0b01000000) != 0;
	}

	/**
	 * True, if the negative flag is set.
	 * 
	 * @return is it?
	 */
	public boolean isNegativeFlagSet() {
		return (status & 0b10000000) != 0;
	}

	/**
	 * Dumps the stack's content into an int-array.
	 * 
	 * @return the stack's content
	 */
	public int[] dumpStack() {
		int[] res = new int[0Xff - stackPointer];
		if (res.length == 0) {
			return res;
		}
		System.arraycopy(machine.getRam(), STACK + stackPointer + 1, res, 0, res.length);
		return res;
	}

	/**
	 * Returns the stack pointer.
	 * 
	 * @return the stack pointer
	 */
	public int getStackPointer() {
		return stackPointer;
	}

	/**
	 * Sets the stack pointer.
	 * 
	 * @param stackPointer
	 *            the stack pointer
	 */
	public void setStackPointer(int stackPointer) {
		this.stackPointer = stackPointer;
	}

	/**
	 * Should the execution stops once it encounters a BRK (opcode 0)? Default
	 * is true.
	 * 
	 * @return Should it?
	 */
	public boolean isExitOnBreak() {
		return exitOnBreak;
	}

	/**
	 * Sets if the execution should stop once it encounters a BRK (opcode 0)?
	 * Default is true.
	 * 
	 * @param exitOnBreak
	 *            Should it?
	 */
	public void setExitOnBreak(boolean exitOnBreak) {
		this.exitOnBreak = exitOnBreak;
	}

	/**
	 * Resets the cpu, i.e. resets all its registers to their initial states.
	 */
	public void reset() {
		acc = 0;
		x = 0;
		y = 0;
		status = 0b00110000;
		stackPointer = 0xff;
		irq = false;
		nmi = false;
		brk = false;
		paused = false;
	}

	/**
	 * Runs a program on the cpu.
	 * 
	 * @param prg
	 *            the program
	 */
	public void execute(Program prg) {
		machine.putProgram(prg);
		execute(prg.getCodeStart());
	}

	/**
	 * Runs a program that already resides in the machine's memory.
	 * 
	 * @param startAddress
	 *            the start address of the program in memory
	 */
	public void execute(int startAddress) {
		pc = startAddress;
		ram = machine.getRam();
		brk = false;
		push(ram, 0);
		push(ram, 0);

		do {
			int lastPc = pc;
			int cmd = ram[pc++];
 
			// System.out.println("PC: " + (pc-1) +"("+Integer.toHexString((pc-1))+")"+ "/" +
			// Integer.toHexString(cmd)+" "+this.getInstruction(cmd));

			int xb = x & 0xff;
			int yb = y & 0xff;
			int accb = acc & 0xff;

			while (paused) {
				try {
					Thread.sleep(1);
				} catch (InterruptedException e) {
					//
				}
			}

			boolean decimal = (status & 0b00001000) != 0;

			if (irq) {
				if (!isInterruptFlagSet()) {
					synchronized (this) {
						push(ram, getHigh(pc));
						push(ram, getLow(pc));
						push(ram, status & 0b11101111);
						pc = getWord(ram[0xFFFE], ram[0xFFFF]);
						irq = false;
					}
				}
			}

			if (nmi) {
				synchronized (this) {
					push(ram, getHigh(pc));
					push(ram, getLow(pc));
					push(ram, status & 0b11101111);
					pc = getWord(ram[0xFFFA], ram[0xFFFB]);
					nmi = false;
				}
			}

			// System.out.println("cmd: "+Integer.toHexString(cmd)+"/"+pc);

			switch (cmd) {

			case 0x60:
				// RTS
				int addr = getWord(pop(ram), pop(ram));
				if (addr == 0) {
					brk = true;
				} else {
					pc = ++addr;
				}
				ticks += 6;
				break;
			case 0x00:
				// BRK
				brk();
				break;
			case 0xA9:
				// LDA #$nn
				lda_nn();
				break;
			case 0xAD:
				// LDA $hhll
				lda_hhll();
				break;
			case 0xBD:
				// LDA $hhll,X
				lda_hhll(xb);
				break;
			case 0xB9:
				lda_hhll(yb);
				break;
			case 0xA5:
				// LDA $ll
				lda_ll();
				break;
			case 0xB5:
				// LDA $ll,X
				lda_llx(xb);
				break;
			case 0xA1:
				// LDA ($ll, X)
				lda_ll_x();
				break;
			case 0xB1:
				// LDA ($ll), Y
				lda_lly(yb);
				break;
			case 0xA2:
				// LDX #$nn
				ldx_nn();
				break;
			case 0xAE:
				// LDX $hhll
				ldx_hhll();
				break;
			case 0xBE:
				// LDX $hhll,Y
				ldx_hhllx(yb);
				break;
			case 0xA6:
				// LDX $ll
				ldx_ll();
				break;
			case 0xB6:
				// LDX $ll,Y
				ldx_lly(yb);
				break;
			case 0xA0:
				// LDY #$nn
				ldy_nn();
				break;
			case 0xAC:
				// LDY $hhll
				ldy_hhll();
				break;
			case 0xBC:
				// LDY $hhll,X
				ldy_hhllx(xb);
				break;
			case 0xA4:
				// LDY $ll
				ldy_ll();
				break;
			case 0xB4:
				// LDY $ll,X
				ldy_llx(xb);
				break;
			case 0x8D:
				// STA $hhll
				sta_hhll(accb);
				break;
			case 0x9D:
				// STA $hhll,X
				sta_hhllx(xb, accb);
				break;
			case 0x99:
				sta_hhllx(yb, accb);
				break;
			case 0x85:
				// STA $ll
				sta_ll(accb);
				break;
			case 0x95:
				// STA $ll,X
				sta_llx(xb, accb);
				break;
			case 0x81:
				// STA ($ll, X)
				sta_ll_x(accb);
				break;
			case 0x91:
				// STA ($ll), Y
				sta_lly(accb);
				break;
			case 0x8E:
				// STX $hhll
				sta_hhll(xb);
				break;
			case 0x86:
				// STX $ll
				sta_ll(xb);
				break;
			case 0x96:
				// STX $ll,Y
				sta_llx(yb, xb);
				break;
			case 0x8C:
				// STY $hhll
				sta_hhll(yb);
				break;
			case 0x84:
				// STY $ll
				sta_ll(yb);
				break;
			case 0x94:
				// STY $ll,X
				sta_llx(xb, yb);
				break;
			case 0xAA:
				// TAX
				tax(accb);
				break;
			case 0xA8:
				// TAY
				tay(accb);
				break;
			case 0x8A:
				// TXA
				txa(xb);
				break;
			case 0x98:
				txa(yb);
				break;
			case 0xBA:
				// TSX
				tsx();
				break;
			case 0x9A:
				// TXS
				txs(xb);
				break;
			case 0x29:
				// AND #$nn
				and_nn();
				break;
			case 0x2D:
				// AND $hhll
				and_hhll();
				break;
			case 0x3D:
				// AND $hhll,X
				and_hhllx(xb);
				break;
			case 0x39:
				and_hhllx(yb);
				break;
			case 0x25:
				// AND $ll
				and_ll();
				break;
			case 0x35:
				// AND $ll,X
				and_llx(xb);
				break;
			case 0x21:
				// AND ($ll, X)
				and_ll_x();
				break;
			case 0x31:
				// AND ($ll), Y
				and_lly(yb);
				break;
			case 0x09:
				// OR #$nn
				or_nn();
				break;
			case 0x0D:
				// OR $hhll
				or_hhll();
				break;
			case 0x1D:
				// OR $hhll,X
				or_hhllx(xb);
				break;
			case 0x19:
				or_hhllx(yb);
				break;
			case 0x05:
				// OR $ll
				or_ll();
				break;
			case 0x15:
				// OR $ll,X
				or_llx(xb);
				break;
			case 0x01:
				// OR ($ll, X)
				or_ll_x();
				break;
			case 0x11:
				// OR ($ll), Y
				or_lly(yb);
				break;
			case 0x49:
				// EOR #$nn
				eor_nn();
				break;
			case 0x4D:
				// EOR $hhll
				eor_hhll();
				break;
			case 0x5D:
				// EOR $hhll,X
				eor_hhllx(xb);
				break;
			case 0x59:
				eor_hhllx(yb);
				break;
			case 0x45:
				// EOR $ll
				eor_ll();
				break;
			case 0x55:
				// EOR $ll,X
				eor_llx(xb);
				break;
			case 0x41:
				// EOR ($ll, X)
				eor_ll_x();
				break;
			case 0x51:
				// EOR ($ll), Y
				eor_lly(yb);
				break;
			case 0x69:
				// ADC #$nn
				adc_nn(accb, decimal);
				break;
			case 0x6D:
				// ADC $hhll
				adc_hhll(accb, decimal);
				break;
			case 0x7D:
				// ADC $hhll,X
				adc_hhllx(xb, accb, decimal);
				break;
			case 0x79:
				adc_hhllx(yb, accb, decimal);
				break;
			case 0x65:
				// ADC $ll
				adc_ll(accb, decimal);
				break;
			case 0x75:
				// ADC $ll,X
				adc_llx(xb, accb, decimal);
				break;
			case 0x61:
				// ADC ($ll, X)
				adc_ll_x(accb, decimal);
				break;
			case 0x71:
				// ADC ($ll), Y
				adc_lly(yb, accb, decimal);
				break;
			case 0xE9:
				// SBC #$nn
				sbc_nn(accb, decimal);
				break;
			case 0xED:
				// SBC $hhll
				sbc_hhll(accb, decimal);
				break;
			case 0xFD:
				// SBC $hhll,X
				sbc_hhllx(xb, accb, decimal);
				break;
			case 0xF9:
				sbc_hhllx(yb, accb, decimal);
				break;
			case 0xE5:
				// SBC $ll
				sbc_ll(accb, decimal);
				break;
			case 0xF5:
				// SBC $ll,X
				sbc_llx(xb, accb, decimal);
				break;
			case 0xE1:
				// SBC ($ll, X)
				sbc_ll_x(accb, decimal);
				break;
			case 0xF1:
				// SBC ($ll), Y
				sbc_lly(yb, accb, decimal);
				break;
			case 0xEE:
				// INC $hhll
				inc_hhll();
				break;
			case 0xFE:
				// INC $hhll,X
				inc_hhllx(xb);
				break;
			case 0xE6:
				// INC $ll
				inc_ll();
				break;
			case 0xF6:
				// INC $ll,X
				inc_llx(xb);
				break;
			case 0xCE:
				// DEC $hhll
				dec_hhll();
				break;
			case 0xDE:
				// DEC $hhll,X
				dec_hhllx(xb);
				break;
			case 0xC6:
				// DEC $ll
				dec_ll();
				break;
			case 0xD6:
				// DEC $ll,X
				dec_llx(xb);
				break;
			case 0xE8:
				// INX
				inx(xb);
				break;
			case 0xC8:
				// INY
				iny(yb);
				break;
			case 0xCA:
				// DEX
				dex(xb);
				break;
			case 0x88:
				// DEY
				dey(yb);
				break;
			case 0x0A:
				// ASL
				asl_(accb);
				break;
			case 0x0E:
				// ASL $hhll
				asl_hhll();
				break;
			case 0x1E:
				// ASL $hhll,X
				asl_hhllx(xb);
				break;
			case 0x06:
				// ASL $ll
				asl_ll();
				break;
			case 0x16:
				// ASL $ll,X
				asl_llx(xb);
				break;
			case 0x4A:
				// LSR
				lsr_(accb);
				break;
			case 0x4E:
				// LSR $hhll
				lsr_hhll();
				break;
			case 0x5E:
				// LSR $hhll,X
				lsr_hhllx(xb);
				break;
			case 0x46:
				// LSR $ll
				lsr_ll();
				break;
			case 0x56:
				// LSR $ll,X
				lsr_llx(xb);
				break;
			case 0x2A:
				// ROL
				rol_(accb);
				break;
			case 0x2E:
				// ROL $hhll
				rol_hhll();
				break;
			case 0x3E:
				// ROL $hhll,X
				rol_hhllx(xb);
				break;
			case 0x26:
				// ROL $ll
				rol_ll();
				break;
			case 0x36:
				// ROL $ll,X
				rol_llx(xb);
				break;
			case 0x6A:
				// ROR
				ror_(accb);
				break;
			case 0x6E:
				// ROR $hhll
				ror_hhll();
				break;
			case 0x7E:
				// ROR $hhll,X
				ror_hhllx(xb);
				break;
			case 0x66:
				// ROR $ll
				ror_ll();
				break;
			case 0x76:
				// ROR $ll,X
				ror_llx(xb);
				break;
			case 0xC9:
				// CMP #$nn
				cmp_nn(accb);
				break;
			case 0xCD:
				// CMP $hhll
				cmp_hhl(accb);
				break;
			case 0xDD:
				// CMP $hhll,X
				cmp_hhllx(xb, accb);
				break;
			case 0xD9:
				cmp_hhllx(yb, accb);
				break;
			case 0xC5:
				// CMP $ll
				cmp_ll(accb);
				break;
			case 0xD5:
				// CMP $ll,X
				cmp_llx(xb, accb);
				break;
			case 0xC1:
				// CMP ($ll, X)
				cmp_llx(accb);
				break;
			case 0xD1:
				// CMP ($ll), Y
				cmp_lly(yb, accb);
				break;
			case 0xE0:
				// CPX #$nn
				cmp_nn(xb);
				break;
			case 0xEC:
				// CPX $hhll
				cmp_hhll(xb);
				break;
			case 0xE4:
				// CPX $ll
				cmp_ll(xb);
				break;
			case 0xC0:
				// CPY #$nn
				cmp_nn(yb);
				break;
			case 0xCC:
				// CPY $hhll
				cmp_hhll(yb);
				break;
			case 0xC4:
				// CPY $ll
				cmp_ll(yb);
				break;
			case 0x2C:
				// BIT $hhll
				bit_hhll(accb);
				break;
			case 0x24:
				// BIT $ll
				bit_ll(accb);
				break;
			case 0x4C:
				// JMP $hhll
				jmp_hhll();
				break;
			case 0x6C:
				// JMP ($hhll)
				jmp_hhll_();
				break;
			case 0x20:
				// JSR $hhll
				jsr_hhll();
				break;
			case 0x40:
				// RTI
				rti();
				break;
			case 0x90:
				// BCC $hhll
				bcc_hhll();
				break;
			case 0xB0:
				// BCS $hhll
				bcs_hhll();
				break;
			case 0xF0:
				// BEQ $hhll
				beq_hhll();
				break;
			case 0xD0:
				// BNE $hhll
				bne_hhll();
				break;
			case 0x10:
				// BPL $hhll
				bpl_hhll();
				break;
			case 0x30:
				// BMI $hhll
				bmi_hhll();
				break;
			case 0x50:
				// BVC $hhll
				bvc_hhll();
				break;
			case 0x70:
				// BVS $hhll
				bvs_hhll();
				break;
			case 0x38:
				// SEC
				sec();
				break;
			case 0x18:
				// CLC
				clc();
				break;
			case 0x78:
				// SEI
				sei();
				break;
			case 0x58:
				// CLI
				cli();
				break;
			case 0xB8:
				// CLV
				clv();
				break;
			case 0xF8:
				// SED
				sed();
				break;
			case 0xD8:
				// CLD
				cld();
				break;
			case 0x48:
				// PHA
				pha(accb);
				break;
			case 0x08:
				// PHP
				php();
				break;
			case 0x68:
				// PLA
				pla();
				break;
			case 0x28:
				// PLP
				plp();
				break;
			case 0xEA:
				// NOP
				ticks += 2;
				break;
			default:
				throw new RuntimeException("Illegal opcode: $" + Integer.toHexString(cmd));
			}

			if (cpuTracer != null) {
				cpuTracer.commandExecuted(this, cmd, lastPc, pc);
			}

		} while (!brk);
	}

	private void plp() {
		status = pop(ram);
		ticks += 3;
	}

	private void pla() {
		acc = pop(ram);
		setFlags(acc, true, true);
		ticks += 3;
	}

	private void php() {
		push(ram, status);
		ticks += 3;
	}

	private void pha(int accb) {
		push(ram, accb);
		ticks += 3;
	}

	private void cld() {
		status &= 0b11110111;
		ticks += 2;
	}

	private void sed() {
		status |= 0b00001000;
		ticks += 2;
	}

	private void clv() {
		status &= 0b10111111;
		ticks += 2;
	}

	private void cli() {
		status &= 0b11111011;
		ticks += 2;
	}

	private void sei() {
		status |= 0b00000100;
		ticks += 2;
	}

	private void clc() {
		status &= 0b11111110;
		ticks += 2;
	}

	private void sec() {
		status |= 0b00000001;
		ticks += 2;
	}

	private void bvs_hhll() {
		ticks += 2;
		if ((status & 0b01000000) != 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void bvc_hhll() {
		ticks += 2;
		if ((status & 0b01000000) == 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void bmi_hhll() {
		ticks += 2;
		if ((status & 0b10000000) != 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void bpl_hhll() {
		ticks += 2;
		if ((status & 0b10000000) == 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void bne_hhll() {
		ticks += 2;
		if ((status & 0b00000010) == 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void beq_hhll() {
		ticks += 2;
		if ((status & 0b00000010) != 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void bcs_hhll() {
		ticks += 2;
		if ((status & 0b00000001) != 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void bcc_hhll() {
		ticks += 2;
		if ((status & 0b00000001) == 0) {
			tmp = pc;
			pc += (byte) (ram[pc] & 0xff) + 1;
			ticks++;
			if (tmp >> 8 != pc >> 8) {
				ticks++;
			}
		} else {
			pc++;
		}
	}

	private void rti() {
		status = this.pop(ram);
		pc = getWord(pop(ram), pop(ram));
		ticks += 6;
	}

	private void jsr_hhll() {
		tmp = getWord(ram[pc], ram[++pc]);
		if (cpuCallListener == null || !cpuCallListener.jsr(this, tmp)) {
			push(ram, getHigh(pc));
			push(ram, getLow(pc));
			pc = tmp;
		} else {
			pc++;
		}
		ticks += 6;
	}

	private void jmp_hhll_() {
		lo = ram[pc++];
		hi = ram[pc];
		tmp = ram[getWord(lo, hi)];
		lo = (lo + 1) & 0xff;
		pc = getWord(tmp, ram[getWord(lo, hi)]);
		ticks += 5;
	}

	private void jmp_hhll() {
		pc = getWord(ram[pc++], ram[pc]);
		ticks += 3;
	}

	private void bit_ll(int accb) {
		tmp = ram[ram[pc++] & 0xff] & 0xFF;
		status = (status & 0b00111111) | (tmp & 0b11000000);
		tmp &= accb;
		setFlags(tmp, false, true);
		ticks += 3;
	}

	private void bit_hhll(int accb) {
		tmp = ram[getWord(ram[pc++], ram[pc++])] & 0xFF;
		status = (status & 0b00111111) | (tmp & 0b11000000);
		tmp &= accb;
		setFlags(tmp, false, true);
		ticks += 4;
	}

	private void cmp_hhll(int xb) {
		tmp = xb - ram[getWord(ram[pc++], ram[pc++])];
		setFlags(tmp, xb, true, true, false, true);
		ticks += 4;
	}

	private void cmp_lly(int yb, int accb) {
		index = getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]);
		tmp = accb - ram[index + yb];
		setFlags(tmp, accb, true, true, false, true);
		ticks += 5;
		if (index >> 8 != (index + yb) >> 8) {
			ticks++;
		}
	}

	private void cmp_llx(int accb) {
		tmp = accb - ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])];
		setFlags(tmp, accb, true, true, false, true);
		ticks += 6;
	}

	private void cmp_llx(int xb, int accb) {
		tmp = accb - ram[((ram[pc++] & 0xff) + xb) & 0xff];
		setFlags(tmp, accb, true, true, false, true);
		ticks += 4;
	}

	private void cmp_ll(int accb) {
		tmp = accb - ram[ram[pc++] & 0xff];
		setFlags(tmp, accb, true, true, false, true);
		ticks += 3;
	}

	private void cmp_hhllx(int xb, int accb) {
		index = getWord(ram[pc++], ram[pc++]);
		tmp = accb - ram[index + xb];
		setFlags(tmp, accb, true, true, false, true);
		ticks += 4;
		if (index >> 8 != (index + xb) >> 8) {
			ticks++;
		}
	}

	private void cmp_hhl(int accb) {
		tmp = accb - ram[getWord(ram[pc++], ram[pc++])];
		setFlags(tmp, accb, true, true, false, true);
		ticks += 2;
	}

	private void cmp_nn(int accb) {
		tmp = accb - ram[pc++];
		setFlags(tmp, accb, true, true, false, true);
		ticks += 2;
	}

	private void ror_llx(int xb) {
		index = ((ram[pc++] & 0xff) + xb) & 0xff;
		ram[index] = ror(ram[index]);
		ticks += 6;
	}

	private void ror_ll() {
		index = ram[pc++] & 0xff;
		ram[index] = ror(ram[index]);
		ticks += 5;
	}

	private void ror_hhllx(int xb) {
		index = getWord(ram[pc++], ram[pc++]) + xb;
		ram[index] = ror(ram[index]);
		ticks += 7;
	}

	private void ror_hhll() {
		index = getWord(ram[pc++], ram[pc++]);
		ram[index] = ror(ram[index]);
		ticks += 6;
	}

	private void ror_(int accb) {
		acc = ror(accb);
		ticks += 2;
	}

	private void rol_llx(int xb) {
		index = ((ram[pc++] & 0xff) + xb) & 0xff;
		ram[index] = rol(ram[index]);
		ticks += 6;
	}

	private void rol_ll() {
		index = ram[pc++] & 0xff;
		ram[index] = rol(ram[index]);
		ticks += 5;
	}

	private void rol_hhllx(int xb) {
		index = getWord(ram[pc++], ram[pc++]) + xb;
		ram[index] = rol(ram[index]);
		ticks += 7;
	}

	private void rol_hhll() {
		index = getWord(ram[pc++], ram[pc++]);
		ram[index] = rol(ram[index]);
		ticks += 6;
	}

	private void rol_(int accb) {
		acc = rol(accb);
		ticks += 2;
	}

	private void lsr_llx(int xb) {
		index = ((ram[pc++] & 0xff) + xb) & 0xff;
		ram[index] = lsr(ram[index]);
		ticks += 6;
	}

	private void lsr_ll() {
		index = ram[pc++] & 0xff;
		ram[index] = lsr(ram[index]);
		ticks += 5;
	}

	private void lsr_hhllx(int xb) {
		index = getWord(ram[pc++], ram[pc++]) + xb;
		ram[index] = lsr(ram[index]);
		ticks += 7;
	}

	private void lsr_hhll() {
		index = getWord(ram[pc++], ram[pc++]);
		ram[index] = lsr(ram[index]);
		ticks += 6;
	}

	private void lsr_(int accb) {
		acc = lsr(accb);
		ticks += 2;
	}

	private void asl_llx(int xb) {
		index = ((ram[pc++] & 0xff) + xb) & 0xff;
		ram[index] = asl(ram[index]);
		ticks += 6;
	}

	private void asl_ll() {
		index = ram[pc++] & 0xff;
		ram[index] = asl(ram[index]);
		ticks += 5;
	}

	private void asl_hhllx(int xb) {
		index = getWord(ram[pc++], ram[pc++]) + xb;
		ram[index] = asl(ram[index]);
		ticks += 7;
	}

	private void asl_hhll() {
		index = getWord(ram[pc++], ram[pc++]);
		ram[index] = asl(ram[index]);
		ticks += 6;
	}

	private void asl_(int accb) {
		acc = asl(accb);
		ticks += 2;
	}

	private void dey(int yb) {
		y = (yb - 1) & 0xff;
		setFlags(y, true, true);
		ticks += 2;
	}

	private void dex(int xb) {
		x = (xb - 1) & 0xff;
		setFlags(x, true, true);
		ticks += 2;
	}

	private void iny(int yb) {
		y = (yb + 1) & 0xff;
		setFlags(y, true, true);
		ticks += 2;
	}

	private void inx(int xb) {
		x = (xb + 1) & 0xff;
		setFlags(x, true, true);
		ticks += 2;
	}

	private void dec_llx(int xb) {
		index = ((ram[pc++] & 0xff) + xb) & 0xff;
		ram[index] = (ram[index] - 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 6;
	}

	private void dec_ll() {
		index = ram[pc++] & 0xff;
		ram[index] = (ram[index] - 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 5;
	}

	private void dec_hhllx(int xb) {
		index = getWord(ram[pc++], ram[pc++]) + xb;
		ram[index] = (ram[index] - 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 7;
	}

	private void dec_hhll() {
		index = getWord(ram[pc++], ram[pc++]);
		ram[index] = (ram[index] - 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 6;
	}

	private void inc_llx(int xb) {
		index = ((ram[pc++] & 0xff) + xb) & 0xff;
		ram[index] = (ram[index] + 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 6;
	}

	private void inc_ll() {
		index = ram[pc++] & 0xff;
		ram[index] = (ram[index] + 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 5;
	}

	private void inc_hhllx(int xb) {
		index = getWord(ram[pc++], ram[pc++]) + xb;
		ram[index] = (ram[index] + 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 7;
	}

	private void inc_hhll() {
		index = getWord(ram[pc++], ram[pc++]);
		ram[index] = (ram[index] + 1) & 0xff;
		setFlags(ram[index], true, true);
		ticks += 6;
	}

	private void sbc_lly(int yb, int accb, boolean decimal) {
		ac = (~(status & 1)) & 1;
		tmp = getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]);
		if (!decimal) {
			acc -= ram[tmp + yb] + ac;
		} else {
			acc = subBCD(subBCD(accb, ac), ram[tmp + yb]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 5;
		if (tmp >> 8 != (tmp + yb) >> 8) {
			ticks++;
		}
	}

	private void sbc_ll_x(int accb, boolean decimal) {
		ac = (~(status & 1)) & 1;
		if (!decimal) {
			acc -= ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])] + ac;
		} else {
			acc = subBCD(subBCD(accb, ac), ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 6;
	}

	private void sbc_llx(int xb, int accb, boolean decimal) {
		ac = (~(status & 1)) & 1;
		if (!decimal) {
			acc -= ram[((ram[pc++] & 0xff) + xb) & 0xff] + ac;
		} else {
			acc = subBCD(subBCD(accb, ac), ram[(ram[pc++] & 0xff) + xb]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 4;
	}

	private void sbc_ll(int accb, boolean decimal) {
		ac = (~(status & 1)) & 1;
		if (!decimal) {
			acc -= ram[ram[pc++] & 0xff] + ac;
		} else {
			acc = subBCD(subBCD(accb, ac), ram[ram[pc++] & 0xff]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 3;
	}

	private void sbc_hhllx(int xb, int accb, boolean decimal) {
		ac = (~(status & 1)) & 1;
		tmp = getWord(ram[pc++], ram[pc++]);
		if (!decimal) {
			acc -= ram[tmp + xb] + ac;
		} else {
			acc = subBCD(subBCD(accb, ac), ram[tmp + xb]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 4;
		if (tmp >> 8 != (tmp + xb) >> 8) {
			ticks++;
		}
	}

	private void sbc_hhll(int accb, boolean decimal) {
		ac = (~(status & 1)) & 1;
		if (!decimal) {
			acc -= ram[getWord(ram[pc++], ram[pc++])] + ac;
		} else {
			acc = subBCD(subBCD(accb, ac), ram[getWord(ram[pc++], ram[pc++])]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 4;
	}

	private void sbc_nn(int accb, boolean decimal) {
		ac = (~(status & 1)) & 1;
		if (!decimal) {
			acc -= ram[pc++] + ac;
		} else {
			acc = subBCD(subBCD(accb, ac), ram[pc++]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 2;
	}

	private void adc_lly(int yb, int accb, boolean decimal) {
		ac = status & 1;
		tmp = getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]);
		if (!decimal) {
			acc += ram[tmp + yb] + ac;
		} else {
			acc = addBCD(addBCD(accb, ac), ram[tmp + yb]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 5;
		if (tmp >> 8 != (tmp + yb) >> 8) {
			ticks++;
		}
	}

	private void adc_ll_x(int accb, boolean decimal) {
		ac = status & 1;
		if (!decimal) {
			acc += ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])] + ac;
		} else {
			acc = addBCD(addBCD(accb, ac), ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 6;
	}

	private void adc_llx(int xb, int accb, boolean decimal) {
		ac = status & 1;
		if (!decimal) {
			acc += ram[((ram[pc++] & 0xff) + xb) & 0xff] + ac;
		} else {
			acc = addBCD(addBCD(accb, ac), ram[(ram[pc++] & 0xff) + xb]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 4;
	}

	private void adc_ll(int accb, boolean decimal) {
		ac = status & 1;
		if (!decimal) {
			acc += ram[ram[pc++] & 0xff] + ac;
		} else {
			acc = addBCD(addBCD(accb, ac), ram[ram[pc++] & 0xff]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 3;
	}

	private void adc_hhllx(int xb, int accb, boolean decimal) {
		ac = status & 1;
		tmp = getWord(ram[pc++], ram[pc++]);
		if (!decimal) {
			acc += ram[tmp + xb] + ac;
		} else {
			acc = addBCD(addBCD(accb, ac), ram[tmp + xb]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 4;
		if (tmp >> 8 != (tmp + xb) >> 8) {
			ticks++;
		}
	}

	private void adc_hhll(int accb, boolean decimal) {
		ac = status & 1;
		if (!decimal) {
			acc += ram[getWord(ram[pc++], ram[pc++])] + ac;
		} else {
			acc = addBCD(addBCD(accb, ac), ram[getWord(ram[pc++], ram[pc++])]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 4;
	}

	private void adc_nn(int accb, boolean decimal) {
		ac = status & 1;
		if (!decimal) {
			acc += ram[pc++] + ac;
		} else {
			acc = addBCD(addBCD(accb, ac), ram[pc++]);
		}
		setFlags(acc, accb, true, true, true, true);
		acc &= 0xff;
		ticks += 2;
	}

	private void eor_lly(int yb) {
		tmp = getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]);
		acc ^= ram[tmp + yb];
		setFlags(acc, true, true);
		ticks += 5;
		if (tmp >> 8 != (tmp + yb) >> 8) {
			ticks++;
		}
	}

	private void eor_ll_x() {
		acc ^= ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])];
		setFlags(acc, true, true);
		ticks += 6;
	}

	private void eor_llx(int xb) {
		acc ^= ram[((ram[pc++] & 0xff) + xb) & 0xff];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void eor_ll() {
		acc ^= ram[ram[pc++] & 0xff];
		setFlags(acc, true, true);
		ticks += 3;
	}

	private void eor_hhllx(int xb) {
		tmp = getWord(ram[pc++], ram[pc++]);
		acc ^= ram[tmp + xb];
		setFlags(acc, true, true);
		ticks += 4;
		if (tmp >> 8 != (tmp + xb) >> 8) {
			ticks++;
		}
	}

	private void eor_hhll() {
		acc ^= ram[getWord(ram[pc++], ram[pc++])];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void eor_nn() {
		acc ^= ram[pc++];
		setFlags(acc, true, true);
		ticks += 2;
	}

	private void or_lly(int yb) {
		tmp = getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]);
		acc |= ram[tmp + yb];
		setFlags(acc, true, true);
		ticks += 5;
		if (tmp >> 8 != (tmp + yb) >> 8) {
			ticks++;
		}
	}

	private void or_ll_x() {
		acc |= ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])];
		setFlags(acc, true, true);
		ticks += 6;
	}

	private void or_llx(int xb) {
		acc |= ram[((ram[pc++] & 0xff) + xb) & 0xff];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void or_ll() {
		acc |= ram[ram[pc++] & 0xff];
		setFlags(acc, true, true);
		ticks += 3;
	}

	private void or_hhllx(int xb) {
		tmp = getWord(ram[pc++], ram[pc++]);
		acc |= ram[tmp + xb];
		setFlags(acc, true, true);
		ticks += 4;
		if (tmp >> 8 != (tmp + xb) >> 8) {
			ticks++;
		}
	}

	private void or_hhll() {
		acc |= ram[getWord(ram[pc++], ram[pc++])];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void or_nn() {
		acc |= ram[pc++];
		setFlags(acc, true, true);
		ticks += 2;
	}

	private void and_lly(int yb) {
		tmp = getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]);
		acc &= ram[tmp + yb];
		setFlags(acc, true, true);
		ticks += 5;
		if (tmp >> 8 != (tmp + yb) >> 8) {
			ticks++;
		}
	}

	private void and_ll_x() {
		acc &= ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])];
		setFlags(acc, true, true);
		ticks += 6;
	}

	private void and_llx(int xb) {
		acc &= ram[((ram[pc++] & 0xff) + xb) & 0xff];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void and_ll() {
		acc &= ram[ram[pc++] & 0xff];
		setFlags(acc, true, true);
		ticks += 3;
	}

	private void and_hhllx(int xb) {
		tmp = getWord(ram[pc++], ram[pc++]);
		acc &= ram[tmp + xb];
		setFlags(acc, true, true);
		ticks += 4;
		if (tmp >> 8 != (tmp + xb) >> 8) {
			ticks++;
		}
	}

	private void and_hhll() {
		acc &= ram[getWord(ram[pc++], ram[pc++])];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void and_nn() {
		acc &= ram[pc++];
		setFlags(acc, true, true);
		ticks += 2;
	}

	private void txs(int xb) {
		stackPointer = xb;
		ticks += 2;
	}

	private void tsx() {
		x = stackPointer & 0xff;
		setFlags(x, true, true);
		ticks += 2;
	}

	private void txa(int xb) {
		acc = xb;
		setFlags(acc, true, true);
		ticks += 2;
	}

	private void tay(int accb) {
		y = accb;
		setFlags(y, true, true);
		ticks += 2;
	}

	private void tax(int accb) {
		x = accb;
		setFlags(x, true, true);
		ticks += 2;
	}

	private void sta_lly(int accb) {
		ram[getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]) + y] = accb;
		ticks += 6;
	}

	private void sta_ll_x(int accb) {
		ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])] = accb;
		ticks += 6;
	}

	private void sta_llx(int xb, int accb) {
		ram[((ram[pc++] & 0xff) + xb) & 0xff] = accb;
		ticks += 4;
	}

	private void sta_ll(int accb) {
		ram[ram[pc++] & 0xff] = accb;
		ticks += 3;
	}

	private void sta_hhllx(int xb, int accb) {
		ram[getWord(ram[pc++], ram[pc++]) + xb] = accb;
		ticks += 5;
	}

	private void sta_hhll(int accb) {
		ram[getWord(ram[pc++], ram[pc++])] = accb;
		ticks += 4;
	}

	private void ldy_llx(int xb) {
		y = ram[((ram[pc++] & 0xff) + xb) & 0xff];
		setFlags(y, true, true);
		ticks += 4;
	}

	private void ldy_ll() {
		y = ram[ram[pc++] & 0xff];
		setFlags(y, true, true);
		ticks += 3;
	}

	private void ldy_hhllx(int xb) {
		tmp = getWord(ram[pc++], ram[pc++]);
		y = ram[tmp + xb];
		setFlags(y, true, true);
		ticks += 4;
		if (tmp >> 8 != (tmp + xb) >> 8) {
			ticks++;
		}
	}

	private void ldy_hhll() {
		y = ram[getWord(ram[pc++], ram[pc++])];
		setFlags(y, true, true);
		ticks += 4;
	}

	private void ldy_nn() {
		y = ram[pc++];
		setFlags(y, true, true);
		ticks += 2;
	}

	private void ldx_lly(int yb) {
		x = ram[((ram[pc++] & 0xff) + yb) & 0xff];
		setFlags(x, true, true);
		ticks += 4;
	}

	private void ldx_ll() {
		x = ram[ram[pc++] & 0xff];
		setFlags(x, true, true);
		ticks += 3;
	}

	private void ldx_hhllx(int yb) {
		tmp = getWord(ram[pc++], ram[pc++]);
		x = ram[tmp + yb];
		setFlags(x, true, true);
		ticks += 4;
		if (tmp >> 8 != (tmp + yb) >> 8) {
			ticks++;
		}
	}

	private void ldx_hhll() {
		x = ram[getWord(ram[pc++], ram[pc++])];
		setFlags(x, true, true);
		ticks += 4;
	}

	private void ldx_nn() {
		x = ram[pc++];
		setFlags(x, true, true);
		ticks += 2;
	}

	private void lda_lly(int yb) {
		tmp = getWord(ram[ram[pc]], ram[(ram[pc++] + 1) & 0xFF]);
		acc = ram[tmp + yb];
		setFlags(acc, true, true);
		ticks += 5;
		if (tmp >> 8 != (tmp + yb) >> 8) {
			ticks++;
		}
	}

	private void lda_ll_x() {
		acc = ram[getWord(ram[(ram[pc] + x) & 0xFF], ram[(ram[pc++] + x + 1) & 0xFF])];
		setFlags(acc, true, true);
		ticks += 6;
	}

	private void lda_llx(int xb) {
		acc = ram[((ram[pc++] & 0xff) + xb) & 0xff];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void lda_ll() {
		acc = ram[ram[pc++] & 0xff];
		setFlags(acc, true, true);
		ticks += 3;
	}

	private void lda_hhll(int xb) {
		tmp = getWord(ram[pc++], ram[pc++]);
		acc = ram[tmp + xb];
		setFlags(acc, true, true);
		ticks += 4;
		if (tmp >> 8 != (tmp + xb) >> 8) {
			ticks++;
		}
	}

	private void lda_hhll() {
		acc = ram[getWord(ram[pc++], ram[pc++])];
		setFlags(acc, true, true);
		ticks += 4;
	}

	private void lda_nn() {
		acc = ram[pc++];
		setFlags(acc, true, true);
		ticks += 2;
	}

	private void brk() {
		pc++;
		push(ram, getHigh(pc));
		push(ram, getLow(pc));
		push(ram, status | 0b00010000);
		pc = getWord(ram[0xFFFE], ram[0xFFFF]);
		brk = exitOnBreak;
		ticks += 7;
	}

	/**
	 * Returns the currently set CpuCallListener.
	 * 
	 * @return the listener or null, if none has been set
	 */
	public CpuCallListener getCpuCallListener() {
		return cpuCallListener;
	}

	/**
	 * Set a new CpuCallListener.
	 * 
	 * @param cpuCallListener
	 *            the new listener
	 */
	public void setCpuCallListener(CpuCallListener cpuCallListener) {
		this.cpuCallListener = cpuCallListener;
	}

	private int asl(int a) {
		a &= 0xFF;
		a = a << 1;
		int cf = (a & 0b0000000100000000) >> 8;
		a &= 0xFF;
		status = (status & 0b11111110) | cf;
		setFlags(a, true, true);
		return a;
	}

	private int rol(int a) {
		a &= 0xFF;
		int cf = (a & 0b0000000010000000) >> 7;
		a = (a << 1) | (status & 1);
		a &= 0xFF;
		status = (status & 0b11111110) | cf;
		setFlags(a, true, true);
		return a;
	}

	private int lsr(int a) {
		a &= 0xFF;
		int cf = a & 1;
		a = a >> 1;
		status = (status & 0b11111110) | cf;
		setFlags(a, true, true);
		return a;
	}

	private int ror(int a) {
		a &= 0xFF;
		int cf = a & 1;
		a = (a >> 1) | ((status & 1) << 7);
		status = (status & 0b11111110) | cf;
		setFlags(a, true, true);
		return a;
	}

	private int addBCD(int a, int b) {
		int o1 = convertFromBCD(a);
		int o2 = convertFromBCD(b);
		int r = o1 + o2;
		return convertToBCD(r);
	}

	private int subBCD(int a, int b) {
		int o1 = convertFromBCD(a);
		int o2 = convertFromBCD(b);
		int r = o1 - o2;
		return convertToBCD(r);
	}

	private int convertToBCD(int r) {
		return (r % 10) + ((r / 10) << 4);
	}

	private int convertFromBCD(int a) {
		return (a & 0b00001111) + 10 * ((a & 0b11110000) >> 4);
	}

	private void setFlags(int a, boolean negative, boolean zero) {
		setFlags(a, a, negative, zero, false, false);
	}

	private void setFlags(int a, int oldA, boolean negative, boolean zero, boolean overflow, boolean carry) {
		if (negative) {
			status = (status & 0b01111111) | (a & 0b10000000);
		}
		if (zero) {
			int zeroFlag = (a & 0xff) == 0 ? 0b10 : 0;
			status = (status & 0b11111101) | zeroFlag;
		}
		if (overflow) {
			int ov = (oldA >= -128 && a < 127) || (oldA <= 127 && a > 127) ? 0b01000000 : 0;
			status = (status & 0b10111111) | ov;
		}
		if (carry) {
			if (a > oldA) {
				boolean decimal = (status & 0b00001000) > 0;
				int cf = decimal ? (a > 0b10011001 ? 1 : 0) : (a > 255 ? 1 : 0);
				status = (status & 0b11111110) | cf;
			} else if (a < oldA) {
				int cf = (a < 0 ? 0 : 1);
				status = (status & 0b11111110) | cf;
			}
		}
	}

	private int getLow(int val) {
		return val & 255;
	}

	private int getHigh(int val) {
		return val >> 8;
	}

	private int getWord(int lo, int hi) {
		return (hi & 0xff) << 8 | (lo & 0xff);
	}

	private int pop(int[] ram) {
		stackPointer++;
		int val = ram[STACK + stackPointer];
		return val;
	}

	private void push(int[] ram, int value) {
		ram[0x100 + stackPointer] = value & 0xff;
		stackPointer--;
		if (stackPointer < 0) {
			stackPointer = 0xFF;
		}
	}
}
