package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.Basic;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.optimize.ConstantFolder;

/**
 * 
 * @author EgonOlsen
 */
public class OptimizerTest {

	public static void main(String[] args) {
		testFolding1();
		testFolding2();
	}

	private static void testFolding1() {
		String code = "10 j=pos(.)*41/40or1";
		CompilerConfig conf = new CompilerConfig();
		Basic bas = new Basic(code);
		bas.compile(conf);
		ConstantFolder.foldConstants(conf, bas.getMachine());
		List<Command> coms = bas.getMachine().getCommandList();
		System.out.println(coms.size());
		Term t = coms.get(0).getTerm();
		System.out.println(t);
		System.out.println(t.getInitial());
		System.out.println(TermEnhancer.addBrackets(t.getInitial()));
		printTerm(t);
	}
	
	private static void testFolding2() {
		String code = "10 j=41/40*pos(.)or1";
		CompilerConfig conf = new CompilerConfig();
		Basic bas = new Basic(code);
		bas.compile(conf);
		ConstantFolder.foldConstants(conf, bas.getMachine());
		List<Command> coms = bas.getMachine().getCommandList();
		System.out.println(coms.size());
		Term t = coms.get(0).getTerm();
		System.out.println(t);
		System.out.println(t.getInitial());
		System.out.println(TermEnhancer.addBrackets(t.getInitial()));
		printTerm(t);
	}

	private static void printTerm(Atom t) {
		if (t.isTerm()) {
			Atom left = ((Term) t).getLeft();
			Atom right = ((Term) t).getRight();
			printTerm(left);
			printTerm(right);
		}
		System.out.println(t+ " -> "+t.isConstant());
	}

}
