package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.extensions.graphics.GraphicsBasic;

/**
 * @author EgonOlsen
 * 
 */
public class BasicExtensionTest {
	public static void main(String[] args) throws Exception {
		testGronGroff();
		testLines();
		testPlot();
		testCircles();
		testFilledCircles();
		testRects();
		testClears();
		testFloodFill();
		testFractal();
	}

	private static void testFractal() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/fractal.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testLines() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/lines.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testPlot() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/plot.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testCircles() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/circles.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testFilledCircles() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/filledcircles.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testRects() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/rects.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testClears() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/clears.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testFloodFill() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/floodfill.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testGronGroff() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/grongroff.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}
}
