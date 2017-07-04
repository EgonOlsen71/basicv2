package com.sixtyfour.test;

import java.util.Deque;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.cbmnative.TermHelper;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

public class NativeCompilerTest {

	public static void main(String[] args) {
		testExpression0();
		testExpression1();
		testExpression2();
		testExpression3();
		testExpression4();
		testExpression5();
		testExpression6();
		testLinearize();
		testStringExpression0();
		testStringExpression1();
		testStringExpression2();
	}

	public static void testLinearize() {
		System.out.println("\n\ntestLinearize");
		String txt = "(A$+\" \")+ASC(I*144+SIN(PI+ASC(CHR$(ASC((A$+\"hello\")+B$))))+(((\"world\"+\", \"+(((A$))))))+\" universe!\"";
		System.out.println(TermHelper.linearize(txt));
	}

	private static void testStringExpression2() {
		System.out.println("\n\ntestStringExpression2");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "h"));
		machine.add(new Variable("B", 65));
		String term = "B+ASC(A$+\"hello\")*ASC(\"32222\"+A$)";
		testExpr(machine, term);
	}

	private static void testStringExpression1() {
		System.out.println("\n\ntestStringExpression1");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "hello"));
		machine.add(new Variable("B", 65));
		String term = "(A$+\" \")+(\"world\"+\", \"+A$)+\" (\"+CHR$(B+(66-B))+CHR$(B)+\"!\"+\") universe!\"+\" -- \"+A$";
		testExpr(machine, term, true);
	}

	private static void testStringExpression0() {
		System.out.println("\n\ntestStringExpression0");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "hello"));
		String term = "(A$+\" \")+(\"world\"+\", \"+A$)+\" universe!\"";
		testExpr(machine, term, true);

		term = "\"Hello World!\"";
		testExpr(machine, term, true);

		term = "A$+\" \"+\"world\"+\", \"+A$+\" universe!\"";
		testExpr(machine, term, true);
	}

	private static void testExpression6() {
		System.out.println("\n\ntestExpression6");
		Machine machine = new Machine();
		machine.add(new Variable("A", 3.5f));
		String term = "A*A*A";
		testExpr(machine, term);
	}

	private static void testExpression5() {
		System.out.println("\n\ntestExpression5.1");
		Machine machine = new Machine();
		String term = "INT(SIN(35)*100/7)";
		testExpr(machine, term);

		System.out.println("\n\ntestExpression5.2 - Random number");
		machine = new Machine();
		term = "INT(RND(35)*100)";
		testExpr(machine, term);
	}

	private static void testExpression0() {
		System.out.println("\n\ntestExpression0");
		Machine machine = new Machine();
		String term = "1.2345";
		testExpr(machine, term);
	}

	private static void testExpression4() {

		System.out.println("\n\ntestExpression4.1");
		Machine machine = new Machine();
		machine.add(new Variable("A", 35f));
		machine.add(new Variable("B", 1.2f));
		String term = "SIN(((A-X)^4+(B-Y)^3+(C-Z)^2)^SIN(1/2))^2";
		// String term="2.3/(A+B)";
		testExpr(machine, term);

		System.out.println("\n\ntestExpression4.2");
		machine = new Machine();
		machine.add(new Variable("A", 3.5f));
		machine.add(new Variable("B", 1.2f));
		machine.add(new Variable("X", 1));
		machine.add(new Variable("Y", 1.1));
		machine.add(new Variable("Z", 1.1));
		machine.add(new Variable("C", 2.1));
		term = "10/((-2/((2+-(32-A)^2-1+(2*A)/(8*B))/100000))^-(2*SIN(((A-X)^4+(B-Y)^3+(1+(A/4)+6*2/6-2^1+C-Z)^2)^SIN(1/2)/20)))*(12345+INT(32.67/COS(A*B)*111.2)/-ABS(A)*(1/LOG(2)*3))+SIN(34)*23/7+2/(COS(A)*132)";
		// String term="2.3/(A+B)";
		testExpr(machine, term);
	}

	private static void testExpression3() {
		System.out.println("\n\ntestExpression3");
		Machine machine = new Machine();
		machine.add(new Variable("A", 1));
		machine.add(new Variable("B", 0));
		String term = "1 OR (A AND B OR (B AND NOT(NOT(A))) OR 1)";
		// String term = "B AND NOT(A)";
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

	private static void testExpr(Machine machine, String term, boolean outString) {
		String s = Parser.addBrackets(term);
		System.out.println(s);

		Term t = Parser.getTerm(term, machine, false, true);
		System.out.println(t);
		List<String> ret = TermHelper.linearize(machine, t).evalToExpression(machine);

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
		System.out.println(outString ? pc.getStringFromStack() : stack.pop());
		System.out.println(t.eval(machine));
	}

	private static void testExpr(Machine machine, String term) {
		testExpr(machine, term, false);
	}

}
