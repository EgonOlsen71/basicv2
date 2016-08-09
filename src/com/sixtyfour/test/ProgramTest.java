package com.sixtyfour.test;

import com.sixtyfour.Interpreter;
import com.sixtyfour.Loader;

/**
 * The Class ProgramTest.
 */
@SuppressWarnings("unused")
public class ProgramTest {

	/**
	 * The main method.
	 * 
	 * @param args
	 *            the arguments
	 */
	public static void main(String[] args) {
		testPrime();
		testJavaPrime();
		testPrime();
		for (int i = 0; i < 10; i++) {
			testPrime2();
		}
		 testConditions();
		// testVarious();
		// testGosubReturn();
		 //testGosub();
		// testMenu();
		 testBeer();
		// testRun();
		// testInput();
		 testData();
		// testAdventure();
		 //testCalc();
		 testStuff();
	}

	/**
	 * Test stuff.
	 */
	private static void testStuff() {
		String[] vary = Loader.loadProgram("files.bas");
		Interpreter inty = new Interpreter(vary);
		// inty.setPrintLineNumbers(true);
		inty.run();
	}

	/**
	 * Test calc.
	 */
	private static void testCalc() {
		String[] vary = Loader.loadProgram("calctest.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test adventure.
	 */
	private static void testAdventure() {
		String[] vary = Loader.loadProgram("OHARES3.BAS");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test data.
	 */
	private static void testData() {
		String[] vary = Loader.loadProgram("data.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test input.
	 */
	private static void testInput() {
		String[] vary = Loader.loadProgram("input.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test run.
	 */
	private static void testRun() {
		String[] vary = Loader.loadProgram("run.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test beer.
	 */
	private static void testBeer() {
		String[] vary = Loader.loadProgram("beer.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test menu.
	 */
	private static void testMenu() {
		String[] vary = Loader.loadProgram("menu.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test gosub.
	 */
	private static void testGosub() {
		String[] vary = Loader.loadProgram("fac.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test gosub return.
	 */
	private static void testGosubReturn() {
		String[] vary = Loader.loadProgram("subroutines.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test various.
	 */
	private static void testVarious() {
		String[] vary = Loader.loadProgram("various.bas");
		Interpreter inty = new Interpreter(vary);
		inty.run();
	}

	/**
	 * Test conditions.
	 */
	private static void testConditions() {
		String[] condy = Loader.loadProgram("conditions.bas");
		Interpreter inty = new Interpreter(condy);
		inty.run();
	}

	/**
	 * Test prime.
	 */
	private static void testPrime() {
		String[] prime = Loader.loadProgram("prime.bas");
		Interpreter inty = new Interpreter(prime);
		inty.run();
	}

	/**
	 * Test prime 2.
	 */
	private static void testPrime2() {
		String[] prime = Loader.loadProgram("prime2.bas");
		Interpreter inty = new Interpreter(prime);
		inty.run();
	}

	/**
	 * Test java prime.
	 */
	private static void testJavaPrime() {
		long start = System.nanoTime();
		int w = 501;
		float[] f = new float[w];
		int p = 1;
		int a = 3;
		do {
			System.out.println(a);
			f[p] = a;
			p++;
			float s = 0;
			int x = 0;

			if (p <= w) {
				a += 2;
				x = 1;
				do {
					s = a / f[x];
					if (s == (int) s) {
						a += 2;
						x = 1;
						continue;
					}
					x++;
				} while (x < p && f[x] * f[x] <= a);
			}
		} while (p < w);
		System.out.println(((System.nanoTime() - start) / 1000000) + "ms");
	}
}
