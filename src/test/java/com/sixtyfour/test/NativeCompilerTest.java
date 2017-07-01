package com.sixtyfour.test;

import java.util.Deque;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

public class NativeCompilerTest {

	public static void main(String[] args) {
		testExpression1();
		testExpression2();
		testExpression3();
		testExpression4();
	}
	
	private static void testExpression4() {
		System.out.println("\n\ntestExpression4");
		Machine machine = new Machine();
		machine.add(new Variable("A", 35f));
		machine.add(new Variable("B", 1.2f));
		String term = "2.3/SIN(((A-X)^4+(B-Y)^3+(C-Z)^2)^SIN(1/2))";
		//String term="2.3/(A+B)";
		testExpr(machine, term);
	}

	private static void testExpression3() {
		System.out.println("\n\ntestExpression3");
		Machine machine = new Machine();
		machine.add(new Variable("A", 1));
		machine.add(new Variable("B", 0));
		String term = "1 OR (A AND B OR (B AND NOT(NOT(A))) OR 1)";
		//String term = "B AND NOT(A)";
		testExpr(machine, term);
	}
	
	private static void testExpression1() {
		System.out.println("\n\ntestExpression1");
		Machine machine = new Machine();
		machine.add(new Variable("A", 122));
		machine.add(new Variable("X", 100));
		machine.add(new Variable("Y", 113));
		machine.add(new Variable("Z", 11));
		machine.add(new Variable("B", 110));
		machine.add(new Variable("C", 210));
		String term = "((A-X)^4+(B-Y)^3+(C-Z)^2)^(1/2)";

		testExpr(machine, term);
	}

	private static void testExpression2() {
		System.out.println("\n\ntestExpression2");
		Machine machine = new Machine();
		machine.add(new Variable("A", 35f));
		machine.add(new Variable("B", 1.2f));
		String term = "2+-(32-A)^10-1+(2*A)/(8*B)";
		testExpr(machine, term);
	}

	private static void testExpr(Machine machine, String term) {
		String s = Parser.addBrackets(term);
		System.out.println(s);

		Term t = Parser.getTerm(term, machine, false, true);
		System.out.println(t);
		List<String> ret = t.evalToExpression(machine);

		System.out.println("Expression:");
		for (String line : ret) {
			System.out.println("--> " + line);
		}

		List<String> code = new NativeCompiler().compileToPseudoCode(machine, t);
		System.out.println("Pseudocode of " + term + " :");
		for (String line : code) {
			System.out.println("----> " + line);
		}

		PseudoCpu pc = new PseudoCpu();
		pc.execute(machine, code);
		Deque<Number> stack = pc.getStack();

		System.out.println("------------------------------");
		System.out.println(stack.pop());
		System.out.println(t.eval(machine));
	}

}
