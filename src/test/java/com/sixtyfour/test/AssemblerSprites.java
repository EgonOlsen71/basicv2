package com.sixtyfour.test;

import java.io.IOException;

import com.sixtyfour.Assembler;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.FileWriter;

/**
 * @author Foerster-H
 *
 */
public class AssemblerSprites {

    private static CompilerConfig config = new CompilerConfig();

    public static void main(String[] args) {
	testHidden();
    }

    private static void testHidden() {
	String[] code = Loader.loadProgram("src/test/resources/asm/hidden.asm");
	Assembler asm = new Assembler(code);
	asm.compile(config);

	try {
	    FileWriter.writeAsDatas(asm.getProgram(), "src/test/resources/asm/+hiddendatas.bas", 30000);
	} catch (IOException e1) {
	    e1.printStackTrace();
	}
    }

}
