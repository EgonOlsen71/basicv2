package com.sixtyfour.test;

import java.util.Arrays;

import com.sixtyfour.Basic;
import com.sixtyfour.system.Conversions;

/**
 * Test for floating point conversions
 * 
 * @author EgonOlsen
 * 
 */
public class FloatTest {

	public static void main(String[] args) {
		testFloat();
		testConversions();
		testConversions2();
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
		basic.run();
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
