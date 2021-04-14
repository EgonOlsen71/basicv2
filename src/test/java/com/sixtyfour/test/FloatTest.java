package com.sixtyfour.test;

import java.util.Arrays;

import com.sixtyfour.Basic;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.Conversions;

/**
 * Test for floating point conversions
 * 
 * @author EgonOlsen
 * 
 */
public class FloatTest {
	private static CompilerConfig config = new CompilerConfig();

	public static void main(String[] args) {
		testFloat();
		testConversions();
		testConversions2();

		int[] num = Conversions.compactFloat(Conversions.convertDouble(8d));
		System.out.println("8: " + Arrays.toString(num));

		testExponentHack();
		testNumbers();
	}

	private static void testNumbers() {
		for (float i = -10; i < 20; i++) {
			int[] fl = Conversions.convertFloat(i);
			System.out.println(i + " : " + Arrays.toString(fl));
		}
	}

	private static void testExponentHack() {
		float t = -567.123123344f;
		int[] fl = Conversions.convertFloat(t);
		for (int i = 0; i < 100; i++) {
			System.out.println("Divided by " + (i) + "*2...");
			System.out.println("Exponent: " + fl[0]);
			System.out.println("Number: " + Conversions.convertFloat(fl[0], fl[5], fl[4], fl[3], fl[2], fl[1]));
			System.out.println("Actual value: " + t);
			t /= 2;
			System.out.println("--------------------------------");
			fl[0] = fl[0] - 1;
		}

	}

	private static void testConversions2() {
		int[] is = new int[] { 0x7e, 0x4f, 0xcc, 0xad, 0x00 };
		int[] should = new int[] { 0x7e, 0x4f, 0xcc, 0xac, 0xc3 };
		int[] num = Conversions.convertDouble(0.20292921d);
		int[] num2 = Conversions.compactFloat(num);
		System.out.println("IS: " + Arrays.toString(is));
		System.out.println("SH: " + Arrays.toString(should));
		System.out.println("CP: " + Arrays.toString(num2));
		System.out.println("FU: " + Arrays.toString(num));
		System.out.println(Conversions.convertDouble(num[0], num[5], num[4], num[3], num[2], num[1]));
		should = Conversions.extractFloat(should);
		System.out.println("S2: " + Arrays.toString(should));
		System.out.println(Conversions.convertDouble(should[0], should[5], should[4], should[3], should[2], should[1]));
	}

	public static void testFloat() {
		Basic basic = new Basic("10 poke97,152:poke98,53:poke99,68:poke100,122:poke101,0:poke102,0");
		basic.run(config);
		System.out.println(Conversions.convertFloat(basic.getMachine(), 97) + "/" + 11879546.0d);
	}

	public static void testConversions() {
		int[] num = Conversions.convertFloat(11234.5454433f);
		float res = Conversions.convertFloat(num[0], num[5], num[4], num[3], num[2], num[1]);
		System.out.println(res);
		System.out.println("-------------------------------------");
		num = Conversions.convertFloat(-2237.998f);
		res = Conversions.convertFloat(num[0], num[5], num[4], num[3], num[2], num[1]);
		System.out.println(res);
		System.out.println("-------------------------------------");
		num = Conversions.extractFloat(Conversions.compactFloat(Conversions.convertFloat(-(float) Math.PI)));
		res = Conversions.convertFloat(num[0], num[5], num[4], num[3], num[2], num[1]);
		System.out.println(res);
	}

}
