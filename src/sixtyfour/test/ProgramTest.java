package sixtyfour.test;

import sixtyfour.Interpreter;
import sixtyfour.Loader;

public class ProgramTest {
	public static void main(String[] args) {
		testPrime();
		testJavaPrime();
		testPrime();
		testPrime2();
		testConditions();
	}

	private static void testConditions() {
		String[] condy = Loader.loadProgram("conditions.bas");
		Interpreter inty = new Interpreter(condy);
		inty.run();
	}


	private static void testPrime() {
		String[] prime = Loader.loadProgram("prime.bas");
		Interpreter inty = new Interpreter(prime);
		inty.run();
	}
	
	private static void testPrime2() {
		String[] prime = Loader.loadProgram("prime2.bas");
		Interpreter inty = new Interpreter(prime);
		inty.run();
	}

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
	
	/**
	 * 10 let w=500:dim f(w):let p=1:let a=3 20 printa:let f(p)=a:let p=p+1:if
	 * p>w then stop 30 let a=a+2:let x=1 40 let s=a/f(x):if s=int(s) then 30 50
	 * let x=x+1:if x
	 * <p
	 * and f(x)*f(x)<=a then 40 60 goto 20
	 */

}
