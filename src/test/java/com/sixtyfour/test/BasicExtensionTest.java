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
		testFractal();
		testShapes();
		testDoubleBuffer();
		testGPrint();
		test3D();
		testRotatedShapes();

		// testGget();
		testCopy();
		testGetShape();
		
	}

	private static void testGetShape() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/getshape.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testCopy() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/copy.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	@SuppressWarnings("unused")
	private static void testGget() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/controls.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testRotatedShapes() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/rotatedshapes.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void test3D() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/graphics3d.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testGPrint() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/gprint.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testDoubleBuffer() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/doublebuffer.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
	}

	private static void testShapes() {
		String[] vary = Loader.loadProgram("src/test/resources/ext/shapes.bas");
		Basic.registerExtension(new GraphicsBasic());
		Basic inty = new Basic(vary);
		inty.run();
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
