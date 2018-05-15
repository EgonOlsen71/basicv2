package com.sixtyfour.test;

import java.awt.image.BufferedImage;
import java.io.FileOutputStream;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.plugins.impl.RamSystemCallListener;
import com.sixtyfour.system.Graphics;

public class GraphicsTest {
    private static CompilerConfig config=new CompilerConfig();
    public static void main(String[] args) throws Exception {
		testFractal();
		testFractalMulticolor();
		testFractalMulticolor2();
		testPlot();
		testEllipse();
	}

	private static void testEllipse() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/ellipse.bas");
		Basic inty = new Basic(vary);
		inty.run(config);
		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, 1024, false, true);
		FileOutputStream fos = new FileOutputStream("ellipse.png");
		Graphics.savePng(bi, fos);
	}

	private static void testFractal() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/fractal.bas");
		Basic inty = new Basic(vary);
		inty.run(config);
		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, 1024, false, false);
		FileOutputStream fos = new FileOutputStream("fractal_hires.png");
		Graphics.savePng(bi, fos);
	}

	private static void testFractalMulticolor() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/fractal_mc.bas");
		Basic inty = new Basic(vary);
		inty.run(config);
		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, 1024, true, false);
		FileOutputStream fos = new FileOutputStream("fractal_multicolor.png");
		Graphics.savePng(bi, fos);
	}

	private static void testFractalMulticolor2() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/fractal_mc2.bas");
		Basic inty = new Basic(vary);
		inty.setSystemCallListener(new RamSystemCallListener(inty.getMachine()));
		inty.run(config);
		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, 1024, true, true);
		FileOutputStream fos = new FileOutputStream("fractal_multicolor2.png");
		Graphics.savePng(bi, fos);
	}

	private static void testPlot() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/plot.bas");
		Basic inty = new Basic(vary);
		inty.setSystemCallListener(new RamSystemCallListener(inty.getMachine()));
		inty.run(config);
		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, 1024, false, true);
		FileOutputStream fos = new FileOutputStream("plotted.png");
		Graphics.savePng(bi, fos);
	}
}
