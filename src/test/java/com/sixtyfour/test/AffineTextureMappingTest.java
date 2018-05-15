package com.sixtyfour.test;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;

import javax.swing.JFrame;
import javax.swing.JPanel;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.plugins.impl.RamSystemCallListener;
import com.sixtyfour.system.Graphics;

/**
 * @author EgonOlsen
 * 
 */
public class AffineTextureMappingTest {
	private static CompilerConfig config = new CompilerConfig();

	public static void main(String[] args) throws Exception {
		testBasicMapper();
	}

	private static void testBasicMapper() throws Exception {
		final BufferedImage bi = new BufferedImage(320, 200, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = bi.createGraphics();
		g.setColor(Color.RED);
		g.fillRect(0, 0, 320, 200);

		final JFrame o = new JFrame();
		JPanel panel = new JPanel() {
			private static final long serialVersionUID = 1L;

			@Override
			protected void paintComponent(java.awt.Graphics g) {
				super.paintComponent(g);
				g.drawImage(bi, 0, 0, null);
			}
		};
		o.setSize(new Dimension(320, 240));
		panel.setSize(new Dimension(320, 240));
		o.add(panel);
		o.setVisible(true);
		o.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		g.setColor(Color.BLACK);
		g.dispose();

		/*
		 * String[] code =
		 * Loader.loadProgram("src/test/resources/asm/innerloop.asm"); Assembler
		 * asm = new Assembler(code); asm.compile(); ProgramPart
		 * pp=asm.getProgram().getParts().get(0); int[] bytes=pp.getBytes(); int
		 * cnt=0; for (int i=0; i<bytes.length; i++) { if (cnt%10==0) {
		 * System.out.print("\ndata "); } System.out.print(((byte) (bytes[i])&
		 * 0xff)+","); cnt++; } System.out.println();
		 */

		// String[] vary =
		// Loader.loadProgram("src/test/resources/basic/affine_asm.bas");
		String[] vary = Loader.loadProgram("src/test/resources/basic/affine.bas");

		vary = Preprocessor.convertToLineNumbers(vary);
		for (String line : vary) {
			System.out.println(line);
		}
		final Basic inty = new Basic(vary);
		inty.compile(config);

		// inty.getMachine().putProgram(asm.getProgram());
		inty.enableJit(-1);

		inty.setSystemCallListener(new RamSystemCallListener(inty.getMachine()) {
			@Override
			public void sys(int addr, Object... params) {
				if (addr == 832) {
					Graphics.fillImage(inty.getMachine().getRam(), 16384, 24576, true, true, bi);
					o.repaint();
					Thread.yield();
				} else {
					super.sys(addr, params);
				}
			}

			@Override
			public float usr(Object params) {
				return super.usr(params);
			}
		});
		/*
		 * inty.getCpu().setCpuTracer(new CpuTracer() {
		 * 
		 * @Override public void commandExecuted(Cpu cpu, int opcode, int
		 * lastPc, int pc) { System.out.println("@ ." + Integer.toHexString(pc)
		 * + "\t" + Integer.toHexString(lastPc) + "\t" +
		 * cpu.getInstruction(opcode) + "/" +
		 * Integer.toBinaryString(cpu.getStatus()));
		 * 
		 * } });
		 */
		inty.start(config);
		BufferedImage bi2 = Graphics.createImage(inty.getMachine(), 16384, 24576, true, true);
		FileOutputStream fos = new FileOutputStream("affine.png");
		Graphics.savePng(bi2, fos);
		System.out.println(inty.getCpu().getClockTicks());
	}
}
