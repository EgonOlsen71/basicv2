package com.sixtyfour.test;

import java.awt.image.BufferedImage;
import java.io.FileOutputStream;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.system.Graphics;

public class GraphicsTest {
	public static void main(String[] args) throws Exception {
		testFractal();
		testFractalMulticolor();
	}

	private static void testFractal() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/fractal.bas");
		Basic inty = new Basic(vary);
		inty.run();
		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, false);
		FileOutputStream fos = new FileOutputStream("fractal_hires.png");
		Graphics.savePng(bi, fos);
	}
	
	private static void testFractalMulticolor() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/fractal_mc.bas");
		Basic inty = new Basic(vary);
		inty.run();
		BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, true);
		FileOutputStream fos = new FileOutputStream("fractal_multicolor.png");
		Graphics.savePng(bi, fos);
	}
}
