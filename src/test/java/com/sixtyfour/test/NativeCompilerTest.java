package com.sixtyfour.test;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.List;

import com.sixtyfour.Basic;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.cbmnative.TermHelper;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.functions.Spc;
import com.sixtyfour.elements.functions.Tab;
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
		testStringExpression3();
		testStringExpression4();
		testStringExpression5();
		testStringExpression6();

		testArrayAccess0();
		testArrayAccess1();

		testStringExpression7();
		testStringExpression8();
		testExpression7();
		testStringExpression9();

		testStringArrayAccess0();
		testStringArrayAccess1();
		testArrayAccessTotal();

		testLoginExpression0();

		testSimpleProgram0();
		testSimpleProgram1();
		testSimpleProgram2();
		testSimpleProgram3();
		testSimpleProgram4();
		testSimpleProgram5();
		testSimpleProgram6();
		
		testProgram0();
	}

	private static void testProgram0()
  {
	  System.out.println("\n\ntestProgram0");
    String prg = "10 A=2\n";
    prg+="20 GOTO 40\n";
    prg+="30 A=10\n";
    prg+="40 B=A*A\n";
    prg+="50 GOSUB 100\n";
    prg+="60 END\n";
    prg+="100 A=B:B=1\n";
    prg+="110 RETURN\n";
    PseudoCpu pc = compileAndRun(prg);
    System.out.println("Var: " + pc.getVariableValue("A"));
    System.out.println("Var: " + pc.getVariableValue("B"));
  }

  private static void testSimpleProgram0() {
		System.out.println("\n\ntestSimpleProgram0");
		String prg = "10 A=56+(77-1)";
		PseudoCpu pc = compileAndRun(prg);
		System.out.println("Var: " + pc.getVariableValue("A"));
	}

	private static void testSimpleProgram1() {
		System.out.println("\n\ntestSimpleProgram1");
		String prg = "10 A$=\"hello\"+\" \"+\"world\"";
		PseudoCpu pc = compileAndRun(prg);
		System.out.println("Var: " + pc.getVariableValue("A$"));
	}

	private static void testSimpleProgram2() {
		System.out.println("\n\ntestSimpleProgram2");
		String prg = "10 A$=\"hello\"+\" \"+\"world\":B$=\"yeah...\"+A$:A$=B$:B$=\"???\"";
		PseudoCpu pc = compileAndRun(prg);
		System.out.println("Var: A$:" + pc.getVariableValue("A$") + " - B$:" + pc.getVariableValue("B$"));
	}

	private static void testSimpleProgram3() {
		System.out.println("\n\ntestSimpleProgram3");
		String prg = "10 F=3:B=34:C=B+2:A(1)=C+B:A(F)=A(1)+2:K(1,2)=A(F)*C+A(1)";
		PseudoCpu pc = compileAndRun(prg);
		System.out.println("Var: A(1)=" + pc.getVariableValue("A[]", 1));
		System.out.println("Var: A(3)=" + pc.getVariableValue("A[]", 3));
		System.out.println("Var: K(1,2)=" + pc.getVariableValue("K[]", 1, 2));
	}

	private static void testSimpleProgram4() {
		System.out.println("\n\ntestSimpleProgram4");
		String prg = "10 A$(2)=\"hello\":A$(3)=\"world\":B$(1,2)=A$(2)+\" \"+A$(3)+\"!\"";
		PseudoCpu pc = compileAndRun(prg);
		System.out.println("Var: A$(2)=" + pc.getVariableValue("A$[]", 2));
		System.out.println("Var: A$(3)=" + pc.getVariableValue("A$[]", 3));
		System.out.println("Var: B$(1,2)=" + pc.getVariableValue("B$[]", 1, 2));
	}
	
	private static void testSimpleProgram5() {
		System.out.println("\n\ntestSimpleProgram5");
		String prg = "10 A=56+(77-1.45)\n20 B=A-12\n30 DIM J%(20,20)\n40 J%(10,11)=A";
		PseudoCpu pc = compileAndRun(prg);
		System.out.println("Var: A=" + pc.getVariableValue("A"));
		System.out.println("Var: J%(10,11)=" + pc.getVariableValue("J%", 10,11));
	}

	private static void testSimpleProgram6() {
		System.out.println("\n\ntestSimpleProgram6");
		String prg = "10 A=56+(77-1.45)\n20 B=A-12\n30 DIM J%(20,20)\n40 END:J%(10,11)=A";
		PseudoCpu pc = compileAndRun(prg);
		System.out.println("Var: A=" + pc.getVariableValue("A"));
		System.out.println("Var: J%(10,11)=" + pc.getVariableValue("J%", 10,11));
	}
	
	private static PseudoCpu compileAndRun(String prg) {
		Basic basic = new Basic(prg);
		basic.compile();
		List<String> mCode = testMachineCode(basic);
		PseudoCpu pc = new PseudoCpu();
		pc.execute(basic.getMachine(), mCode);
		return pc;
	}

	private static List<String> testMachineCode(Basic basic) {
		List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(basic.getMachine(), basic.getPCode());
		System.out.println("------------------------------");
		for (String line : mCode) {
			System.out.println(line);
		}
		System.out.println("------------------------------");
		return mCode;
	}

	private static void testLoginExpression0() {
		System.out.println("\n\ntestLoginExpression0");
		Machine machine = new Machine();
		machine.add(new Variable("A", 1));
		machine.add(new Variable("B", 0));
		machine.add(new Variable("C", 1));
		String term = "(A OR B) AND (C AND NOT(B))";
		testExpr(machine, term);
	}

	private static void testArrayAccessTotal() {
		System.out.println("\n\ntestArrayAccess1");
		Machine machine = new Machine();
		List<Object> objs = new ArrayList<Object>(Arrays.asList(new Float[] { 93f, 2.3f, 4.5f, 4.1f, 1.1f, .21f, 1.1f, 2.3f, 4.5f, 6.6f, 2.2f, 1.3f, 4.5f, 4.5f, 1f, 2.2f, 3.1f,
				2.3f, 5.5f, 6.6f }));
		machine.add(new Variable("A[]", objs, 1, 9));
		machine.add(new Variable("B[]", objs, 19));
		machine.add(new Variable("C", 0));
		machine.add(new Variable("D%", 2));
		List<Object> objs2 = new ArrayList<Object>(Arrays.asList(new String[] { "AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG", "HHH", "JJJ", "KKK", "LLL", "MMM", "NNN", "OOO" }));
		machine.add(new Variable("AA$[]", objs2, 1, 7));
		machine.add(new Variable("B$[]", objs2, 13));
		String term = "B(4)+6+B(1)+ASC(B$(ASC(\"A\")-A(0,C))+\" \")";
		// String term="B(4 AND 4)+6+B(1)+ASC(\"A\")";
		testExpr(machine, term, false);
	}

	private static void testArrayAccess1() {
		System.out.println("\n\ntestArrayAccess1");
		Machine machine = new Machine();
		List<Object> objs = new ArrayList<Object>(Arrays.asList(new Float[] { 1.2f, 2.3f, 4.5f, 4.1f, 1.1f, .21f, 1.1f, 2.3f, 4.5f, 6.6f, 2.2f, 1.3f, 4.5f, 4.5f, 1f, 2.2f, 3.1f,
				2.3f, 5.5f, 6.6f }));
		machine.add(new Variable("A[]", objs, 1, 9));
		machine.add(new Variable("B[]", objs, 19));
		machine.add(new Variable("C", 4.2f));
		machine.add(new Variable("D%", 2));
		String term = "B(5)+6+B(1)";
		testExpr(machine, term, false);
	}

	private static void testStringArrayAccess0() {
		System.out.println("\n\ntestStringArrayAccess0");
		Machine machine = new Machine();
		List<Object> objs = new ArrayList<Object>(Arrays.asList(new String[] { "AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG", "HHH", "JJJ", "KKK", "LLL", "MMM", "NNN", "OOO" }));
		machine.add(new Variable("AA$[]", objs, 1, 7));
		machine.add(new Variable("B$[]", objs, 13));
		machine.add(new Variable("A$", "Hello"));
		String term = "B$(1)+\"K\"+B$(4)";
		testExpr(machine, term, true);
	}

	private static void testStringArrayAccess1() {
		System.out.println("\n\ntestStringArrayAccess1");
		Machine machine = new Machine();
		List<Object> objs = new ArrayList<Object>(Arrays.asList(new String[] { "AAA", "BBB", "CCC", "DDD", "EEE", "FFF", "GGG", "HHH", "JJJ", "KKK", "LLL", "MMM", "NNN", "OOO" }));
		machine.add(new Variable("AA$[]", objs, 1, 7));
		machine.add(new Variable("B$[]", objs, 13));
		machine.add(new Variable("A$", "Hello"));
		String term = "AA$(0,1)+\" \"+A$+B$(4)+B$(5)+\"hello\"+AA$(1,3)";
		testExpr(machine, term, true);
	}

	private static void testStringExpression9() {
		System.out.println("\n\ntestStringExpression9");
		Tab.setLimitedToPrint(false);
		Spc.setLimitedToPrint(false);
		Machine machine = new Machine();
		machine.add(new Variable("A$", "I hate you!"));
		machine.add(new Variable("B$", "I love me!"));
		String term = "A$+TAB(20)+B$+SPC(10)+\"!!!\"";
		testExpr(machine, term, true);
		term = "POS(35)";
		testExpr(machine, term);
	}

	private static void testExpression7() {
		System.out.println("\n\ntestExpression7");
		Machine machine = new Machine();
		String term = "-2*PEEK(-2*256*-2)*-1";
		testExpr(machine, term);
	}

	private static void testStringExpression8() {
		System.out.println("\n\ntestStringExpression8");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "I hate you!"));
		machine.add(new Variable("B$", "I love me!"));
		machine.add(new Variable("A", 2));
		String term = "LEFT$(B$,A*3)+\" \"+RIGHT$(A$, A^A/COS(0))";
		testExpr(machine, term, true);
	}

	private static void testStringExpression7() {
		System.out.println("\n\ntestStringExpression7");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "Hello World"));
		machine.add(new Variable("BB$", "YEAH!!!"));
		String term = "LEFT$(A$,4)+\" \"+LEFT$(BB$, 5)";
		testExpr(machine, term, true);
	}

	private static void testArrayAccess0() {
		System.out.println("\n\ntestArrayAccess0");
		Machine machine = new Machine();
		List<Object> objs = new ArrayList<Object>(Arrays.asList(new Float[] { 1.2f, 2.3f, 4.5f, 4.1f, 1.1f, .21f, 1.1f, 2.3f, 4.5f, 6.6f, 2.2f, 1.3f, 4.5f, 4.5f, 1f, 2.2f, 3.1f,
				2.3f, 5.5f, 6.6f }));
		machine.add(new Variable("A[]", objs, 1, 9));
		machine.add(new Variable("B[]", objs, 19));
		machine.add(new Variable("C", 4.2f));
		machine.add(new Variable("D%", 2));
		String term = "A((1/183)*(B+ASC(A$+\"hello\")*2+-ASC((MID$(\"32222\",2)+A$)+A$)/2),D%)*A(0,D%+D%+COS(A(0,0)-1.2))+A(1,C*2)*B(B(ASC(\"A\")-96)*4)";
		// term="B(5)+B(1)";
		testExpr(machine, term, false);
	}

	private static void testStringExpression6() {
		System.out.println("\n\ntestStringExpression6");
		Machine machine = new Machine();
		machine.add(new Variable("P$", "hello world"));
		String term = "\"test: \"+MID$(P$,4,ASC(\"A\")-92)+MID$(\"YEAH!\",4+1)";
		// String term="MID$(\"hello\",1,2)";
		testExpr(machine, term, true);
		System.out.println("\n\n");
		term = "CHR$(123)";
		testExpr(machine, term, true);
	}

	private static void testStringExpression5() {
		System.out.println("\n\ntestStringExpression5");
		Machine machine = new Machine();
		machine.add(new Variable("P$", "1.2345"));
		machine.add(new Variable("H$", "67890"));
		String term = "10/VAL(P$+H$)*3+LEN(P$)";
		testExpr(machine, term);
	}

	private static void testStringExpression4() {
		System.out.println("\n\ntestStringExpression4");
		Machine machine = new Machine();
		machine.add(new Variable("P", 1.234567890f));
		machine.add(new Variable("B%", 65));
		machine.add(new Variable("A$", "65"));
		String term = "\"vars: \"+STR$(P)";
		testExpr(machine, term, true);
	}

	public static void testLinearize() {
		System.out.println("\n\ntestLinearize");
		String txt = "(A$+\" \")+ASC(I*144+SIN(PI+ASC(CHR$(ASC((A$+\"hello\")+B$)))))+(((\"world\"+\", \"+(((A$))))))+\" universe!\"";
		System.out.println(TermHelper.linearize(txt));
	}

	private static void testStringExpression2() {
		System.out.println("\n\ntestStringExpression2");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "h"));
		machine.add(new Variable("B", 65));
		// String term =
		// "B+ASC(A$+\"hello\")*2+-ASC((MID$(\"32222\",2)+A$)+A$)/2";
		String term = "MID$(\"32222\",2+1)+A$";
		testExpr(machine, term, true);
	}

	private static void testStringExpression3() {
		System.out.println("\n\ntestStringExpression3");
		Machine machine = new Machine();
		machine.add(new Variable("P", 3));
		machine.add(new Variable("I%", 65));
		String term = "INT(10000*SIN(ASC(CHR$(ASC(CHR$(I%)+\"U\")))))";
		testExpr(machine, term);
	}

	private static void testStringExpression1() {
		System.out.println("\n\ntestStringExpression1");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "hello"));
		machine.add(new Variable("B", 65));
		String term = "(A$+\" \")+(\"world\"+\", \"+A$)+\" (\"+CHR$(B+(66-B))+CHR$(B)+CHR$(124*SIN(B/2))+\"!\"+\") universe!\"+\" -- \"+A$";
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
		System.out.println("w/o brackets: " + term);
		System.out.println("With brackets: " + s);

		Term t = Parser.getTerm(term, machine, false, true);
		System.out.println("TERM: " + t);
		List<String> ret = TermHelper.linearize(machine, t).evalToCode(machine).get(0).getExpression();

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
		// pc.compactMemory();
	}

	private static void testExpr(Machine machine, String term) {
		testExpr(machine, term, false);
	}

}
