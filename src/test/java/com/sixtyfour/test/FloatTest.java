package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Cpu;

/**
 * Test for floating point conversions
 * 
 * @author Foerster-H
 * 
 */
public class FloatTest {

	public static void main(String[] args) {
		testFloat();
		testConversions();
	}

	public static void testFloat() {
		Basic basic = new Basic("10 poke97,152:poke98,53:poke99,68:poke100,122:poke101,0:poke102,0");
		basic.run();
		Cpu cpu = basic.getMachine().getCpu();
		System.out.println(cpu.convertFloat(97) + "/" + 11879546.0d);
	}
	
	public static void testConversions() {
    int[] num = Conversions.convertFloat(1234.5454433f);
    float res = Conversions.convertFloat(num[0], num[5], num[4], num[3], num[2], num[1]);
    System.out.println(res);
    System.out.println("-------------------------------------");
    num = Conversions.convertFloat(-237.998f);
    res = Conversions.convertFloat(num[0], num[5], num[4], num[3], num[2], num[1]);
    System.out.println(res);
    System.out.println("-------------------------------------");
    num = Conversions.extractFloat(Conversions.compactFloat(Conversions.convertFloat(-(float) Math.PI)));
    res = Conversions.convertFloat(num[0], num[5], num[4], num[3], num[2], num[1]);
    System.out.println(res);
	}

}
