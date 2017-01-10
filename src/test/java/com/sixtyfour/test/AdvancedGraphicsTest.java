package com.sixtyfour.test;

import java.awt.image.BufferedImage;
import java.io.FileOutputStream;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.plugins.CpuCallListener;
import com.sixtyfour.plugins.impl.RamSystemCallListener;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.Graphics;

/**
 * An advanced graphics test/demo that uses an additional machine language
 * package (wrapped into BASIC's data commands) to draw some pseudo-3D graphics.
 * 
 * The ml package is called via SYS commands that include parameters. On a
 * normal C64, these are handled by calling ROM routines to read the parameters
 * from inside the machine language code. Because we have no ROM here, this
 * wouldn't work. What this test does instead, is to intercept the actual ROM
 * calls by implementing a CpuCallListener and provide the proper values to the
 * cpu by using some additional Java code.
 * 
 * Another interesting approach is how it handles the unwrapping of the machine
 * code, which is stored in a different BASIC program. For this, it loads and
 * executes this program as usual and then creates a new Basic instance but
 * recycles the Machine instance (whose ram now contains the unwrapped machine
 * code). It then compiles the actual BASIC program without resetting the
 * machine, so that the machine code is being kept.
 * 
 * @author EgonOlsen
 */
public class AdvancedGraphicsTest {

	public static void main(String[] args) throws Exception {
		test3d();
	}

	private static void test3d() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/graphicspackage.bas");
		final Basic inty = new Basic(vary);
		inty.run();
		final ParameterHolder holder = new ParameterHolder();

		vary = Loader.loadProgram("src/test/resources/basic/graphics3d.bas");
		final Basic inty2 = new Basic(vary, inty.getMachine());

		inty2.setSystemCallListener(new RamSystemCallListener(inty.getMachine()) {
			@Override
			public void sys(int addr, Object... params) {
				holder.set(params);
				super.sys(addr, params);
			}
		});
		inty2.getCpu().setCpuCallListener(new CpuCallListener() {

			@Override
			public boolean jsr(Cpu cpu, int addr) {
				if (addr >= 51200 && addr <= 52054) {
					return false;
				}
				if (addr == 0xb79e) {
					// get byte
					int val = holder.next().intValue() & 0xFF;
					cpu.setX(val);
					inty2.getRam()[0x61 + 4] = val;
					return true;
				}

				if (addr == 0xaefd) {
					// check comma
					return true;
				}

				if (addr == 0xb7f1) {
					// check comma and get byte
					int val = holder.next().intValue() & 0xFF;
					cpu.setX(val);
					inty2.getRam()[0x61 + 4] = val;
					return true;
				}

				if (addr == 0xb7eb) {
					// check comma and get byte
					int val1 = holder.next().intValue();
					int val2 = holder.next().intValue() & 0xFF;
					cpu.setX(val2);
					inty2.getRam()[0x14] = val1 % 256;
					inty2.getRam()[0x15] = val1 / 256;
					return true;
				}

				if (addr == 0xb248) {
					throw new RuntimeException("Illegal quantity error!");
				}

				return false;
			}

		});

		inty2.compile(false);
		inty2.run();

		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, 1024, false, true);
		FileOutputStream fos = new FileOutputStream("graphics3d.png");
		Graphics.savePng(bi, fos);
	}

	private final static class ParameterHolder {
		private Object[] parameters;
		private int pos = 0;

		public void set(Object[] parameters) {
			this.parameters = parameters;
			pos = 0;
		}

		public Number next() {
			return (Number) parameters[pos++];
		}
	}

}
