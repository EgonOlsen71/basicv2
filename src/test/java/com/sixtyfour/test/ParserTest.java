package com.sixtyfour.test;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.parser.Line;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.system.Machine;

/**
 * Basic tests for the parser.
 */
public class ParserTest {

	/**
	 * The main method.
	 * 
	 * @param args
	 *            the arguments
	 */
	public static void main(String[] args) {
		testArrayAccess();
		testLineNumber();
		testCommands();
		testTermCompletion();
		testTermCreation();
		testComplexFunctions();
		testLogic();
		testPowerOf();
		testAbs();
		testStuff();
		testMinusPower();
		testConstants();
		testAnd();
	}

	private static void testConstants() {
		System.out.println("testConstants");
		Machine machine = new Machine();
		String term = "(int(int(4.4+5*2.2)+5.6)) and (8+4)";
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		Term t = Parser.getTerm(term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));
	}

	private static void testMinusPower() {
		System.out.println("testMinusPower");
		String term = "2+-(32-30)^10";
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		Machine machine = new Machine();
		Term t = Parser.getTerm(term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));

		term = "1*-3^2e1";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));
	}

	private static void testArrayAccess() {
		System.out.println("testArrayAccess");
		String term = "10*b(1,1)";
		Machine machine = new Machine();
		Term t = Parser.getTerm(term, machine, false, true);
		System.out.println(t);
		System.out.println(TermEnhancer.addBrackets(term));
		System.out.println();
		term = "10+b(1,1)";
		t = Parser.getTerm(term, machine, false, true);
		System.out.println(t);
		System.out.println(TermEnhancer.addBrackets(term));
		System.out.println();
		term = "a=a*2+4+b(1,1)";
		t = Parser.getTerm(term, machine, true, true);
		System.out.println(t);
		System.out.println(t.getOperator());
		System.out.println(t.eval(machine));
		System.out.println(TermEnhancer.addBrackets(term));
	}

	/**
	 * Test stuff.
	 */
	
	private static void testAnd() {
		System.out.println("testAnd");
		Machine machine = new Machine();
		machine.add(new Variable("A", 23));
		machine.add(new Variable("B", 41));
		String term = "(a>68andb)";
		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
	}
	
	private static void testStuff() {
		System.out.println("testStuff");
		Machine machine = new Machine();
		machine.add(new Variable("A", 23));
		machine.add(new Variable("B", 41));
		machine.add(new Variable("D", 123));
		machine.add(new Variable("F", 141));
		machine.add(new Variable("G", 3));
		machine.add(new Variable("Z", 1));
		machine.add(new Variable("T", 11));
		machine.add(new Variable("R", 21));
		machine.add(new Variable("P", 55));
		machine.add(new Variable("U", 22));
		machine.add(new Variable("O", 45));
		machine.add(new Variable("I", 67));
		String term = "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + abs(-(d*u))*(p+(o*i*z))*z+u";
		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
	}

	/**
	 * Test abs.
	 */
	private static void testAbs() {
		System.out.println("testAbs");
		Machine machine = new Machine();
		machine.add(new Variable("Z", 23));
		machine.add(new Variable("P", 41));
		String term = "(ABS(Z-P)-2)*(ABS(Z-P)-18)";

		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));

	}

	/**
	 * Test power of.
	 */
	private static void testPowerOf() {

		System.out.println("testPowerOf");
		Machine machine = new Machine();
		machine.add(new Variable("X1", 122));
		machine.add(new Variable("X", 100));
		machine.add(new Variable("Y", 113));
		machine.add(new Variable("X1", 110));
		machine.add(new Variable("Y", 214));
		machine.add(new Variable("Y1", 210));
		// String term="((x1-x)^2+(y1-y)^2+(z1-z)^2)";
		String term = "((x1-x)^2+(y1-y)^2+(z1-z)^2)^(1/2)";

		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
	}

	/**
	 * Test logic.
	 */
	private static void testLogic() {
		System.out.println("testLogic");
		Machine machine = new Machine();
		machine.add(new Variable("A%", 5));
		machine.add(new Variable("B%", 32));
		String term = "NOT 1 OR NOT (110+10)";
		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
	}

	/**
	 * Test complex functions.
	 */
	private static void testComplexFunctions() {
		System.out.println("testComplexFunctions");
		Machine machine = new Machine();
		machine.add(new Variable("A$", "abcdefghijklmnopqrstuvwxyz"));
		machine.add(new Variable("B$", "test"));
		machine.add(new Variable("A", 1));
		String term = "\"hallo\"+\" \"+mid$(A$+a$,1*5+3*5,13)+\" \"+mid$(\"1234567\", 3)+\" \"+mid$(B$+\"hallo\", 1+1+(1*1), 5)+\" \"+mid$(B$+\"hallo\", 1+2+(1*1)-a)";

		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
	}

	/**
	 * Test term creation.
	 */
	private static void testTermCreation() {
		System.out.println("testTermCreation");
		Machine machine = new Machine();
		machine.add(new Variable("A", 5));
		machine.add(new Variable("B", 5.6f));
		machine.add(new Variable("C", 14));
		machine.add(new Variable("Z", 12));
		machine.add(new Variable("U", 1.4));
		machine.add(new Variable("K", -2));
		machine.add(new Variable("D", 3));
		machine.add(new Variable("I", 4.1234));
		String term = "(a^z * (b + c / (z+-sin(u+z*k))) * d)/cos(i) + cos(-88)";
		// String term="sin(-1)";
		Term res = Parser.getTerm(term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
		System.out.println(((5f * ((5.6f + (14f / (12f + (-1f * Math.sin((1.4f + (12f * -2f))))))) * 3f)) / (Math.cos((4.1234f)) + Math.cos(88f))));

		// term =
		// "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + -(d*u)*(p+(o*i*z))*z+u";
		// res = Lexer.getTerm(term, memory);
		// System.out.println(res);
	}

	/**
	 * Test term completion.
	 */
	private static void testTermCompletion() {
		System.out.println("testTermCompletion");
		String term = "a ++++++ b + c *-- d";
		String res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b + c * d * -2";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "f-18*a * b * -c + d";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * c * d";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * -c + -d";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a + b - c + d^e*r";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + -(d*u)*(p+(o*i*z))*z+u";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a + (b + c / (z+u))";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * (b + c / (z+-u))";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * (b + c / (z+-sin(u+z*k))) * d/cos(i) + (cos(88)+(a*(-b)))";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "\"ha a*b*c+d llo \"+\"welt!\"";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "+++++++\"ha a*b*c+d llo \"+++++++\"welt!\"";
		res = TermEnhancer.addBrackets(term);
		System.out.println(term + " is actually " + res);
	}

	/**
	 * Test commands.
	 */
	private static void testCommands() {
		System.out.println("testCommands");
		String test = getSimpleLine();
		Command com = Parser.getCommand(Line.getLine(test).getLine());
		System.out.println("Command is: " + com);

	}

	/**
	 * Test line number.
	 */
	private static void testLineNumber() {
		System.out.println("testLineNumber");
		String test = getSimpleLine();
		Line line = Line.getLine(test);
		System.out.println("Line number is: " + line.getNumber());

		test = test.replace(" ", "").replace("10", "65500");
		line = Line.getLine(test);
		System.out.println("Line number is: " + line.getNumber());
	}

	/**
	 * Gets the simple line.
	 * 
	 * @return the simple line
	 */
	private static String getSimpleLine() {
		return "10 PRINT\"Hello World\"";
	}

}
