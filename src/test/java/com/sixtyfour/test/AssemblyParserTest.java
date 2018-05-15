package com.sixtyfour.test;

import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantInt;
import com.sixtyfour.parser.assembly.ConstantValue;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.system.CompilerConfig;

public class AssemblyParserTest {
    private static CompilerConfig config=new CompilerConfig();
    
    public static void main(String[] args) {
		testConstants();
		testComplexConstants();
		testComplexConstants2();
		testBytes();
		testLabel();
	}

	private static void testComplexConstants() {
		ConstantsContainer ccon = new ConstantsContainer();
		ConstantValue cv = new ConstantInt("HONK", 10);
		ccon.put(cv);
		cv = new ConstantInt("HONKI2", 100);
		ccon.put(cv);

		ConstantValue vally = AssemblyParser.getConstantParsed(config,"KLONK", "HONK+35*HONKI2", ccon, true);
		System.out.println(vally.getName() + " = " + vally.getValue());
	}

	private static void testComplexConstants2() {
		ConstantsContainer ccon = new ConstantsContainer();

		ConstantValue vally = AssemblyParser.getConstantParsed(config,"KLONK", "1234*3+11", ccon, true);
		System.out.println(vally.getName() + " = " + vally.getValue());
	}

	private static void testLabel() {
		String line = "start        lda #147  ";
		System.out.println(AssemblyParser.getLabel(line));
	}

	private static void testBytes() {
		int c = 49157;
		System.out.println(AssemblyParser.getLowByte(c));
		System.out.println(AssemblyParser.getHighByte(c));
	}

	private static void testConstants() {
		System.out.println(AssemblyParser.getConstant(config,"*=$c000", null));
		System.out.println(AssemblyParser.getConstant(config,"BSOUTy = 63424", null));
		System.out.println(AssemblyParser.getConstant(config,AssemblyParser.truncateComments("*=$c001 ;This is a comment!;;;"), null));
	}
}
