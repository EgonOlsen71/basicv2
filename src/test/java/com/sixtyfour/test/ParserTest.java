package com.sixtyfour.test;

import com.sixtyfour.cbmnative.TermHelper;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.Line;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.system.Machine;

/**
 * Basic tests for the parser.
 */
public class ParserTest {
	private static CompilerConfig config = new CompilerConfig();

	/**
	 * The main method.
	 * 
	 * @param args the arguments
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
		testConstants();
		testAnd();
		testAnd2();
		testMinusPower();
		testSin();
		testNumberExt1();
		testBrackets();
		testLogicBrackets();
		testSimilarity();
		testNot();
		testMidStrAnd();
	}
	
	private static void testMidStrAnd() {
		System.out.println("testMidStrAnd");
		Machine machine = new Machine();
		String term = "str$(12 and a(3,34))=mid$(str$(c or 5 and 15),2)";
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		Term t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		
		machine = new Machine();
		term = "mid$(str$(c and 15),2)";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		
		machine = new Machine();
		term = "mid$(str$(c+4*5),2)";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		
		term = "a$=\"\" and peek(56320)=127>2";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		
		term = "a$(cand15, sin(cand15))=\"\" and peek(56320)=127";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		
		term = "str$(cand15)=\"\" and peek(56320)=127";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		
		term = "mid$(a$,c and 15, b(2,3) and 3)";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
	}

	private static void testNot() {
		System.out.println("testNot");
		Machine machine = new Machine();
		String term = "not(i>5 or i<12)";
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		Term t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);

	}
	
	private static void testSimilarity() {
		System.out.println("testSimilarity");
		Machine machine = new Machine();
		String term = "A/B";
		String wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);
		Term res = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res);

		System.out.println("lin: " + TermHelper.linearize(res.getInitial(), true));

		term = "INT(A/B)";
		wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);
		Term res1 = Parser.getTerm(config, term, machine, false, true);
		Term res2 = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res1);
		System.out.println(res2);
		System.out.println("lin1: " + TermHelper.linearize(res1.getInitial(), true));
		System.out.println("lin2: " + TermHelper.linearize(res2.getInitial(), true));

		System.out.println("res1==res1: " + res1.equals(res1));
		System.out.println("res1==res2: " + res1.equals(res2));
		System.out.println("res==res1: " + res.equals(res1));
		System.out.println("res2==res: " + res2.equals(res));

		term = "RND(0)";
		wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);
		res1 = Parser.getTerm(config, term, machine, false, true);
		res2 = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res1);
		System.out.println(res2);
		System.out.println("lin1: " + TermHelper.linearize(res1.getInitial(), true));
		System.out.println("lin2: " + TermHelper.linearize(res2.getInitial(), true));

		System.out.println("res1==res1: " + res1.equals(res1));
		System.out.println("res1==res2: " + res1.equals(res2));
		System.out.println("res==res1: " + res.equals(res1));
		System.out.println("res2==res: " + res2.equals(res));

		term = "INT(A/B+5+SIN(8))";
		wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);
		res1 = Parser.getTerm(config, term, machine, false, true);
		res2 = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res1);
		System.out.println(res2);
		System.out.println("lin1: " + TermHelper.linearize(res1.getInitial(), true));
		System.out.println("lin2: " + TermHelper.linearize(res2.getInitial(), true));

		System.out.println("res1==res1: " + res1.equals(res1));
		System.out.println("res1==res2: " + res1.equals(res2));
		System.out.println("res==res1: " + res.equals(res1));
		System.out.println("res2==res: " + res2.equals(res));

		term = "A/B+5+SIN(8)";
		wbres = TermEnhancer.addBrackets(term);
		System.out.println(wbres);
		res1 = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res2);
		res2 = ((Function) res2.getLeft()).getTerm();
		System.out.println(res1);
		System.out.println(res2);
		System.out.println("lin1: " + TermHelper.linearize(res1.getInitial(), true));
		System.out.println("lin2: " + TermHelper.linearize(res2.getInitial(), true));

		System.out.println("res1==res1: " + res1.equals(res1));
		System.out.println("res1==res2: " + res1.equals(res2));
		System.out.println("res==res1: " + res.equals(res1));
		System.out.println("res2==res: " + res2.equals(res));

	}

	private static void testLogicBrackets() {
		System.out.println("testLogicBrackets");
		String term = "u or 4 +56-23 or z=160 or l>1 and l<10 and z(2,3*4)=32";
		System.out.println("Before: " + term);
		String s = TermEnhancer.addBrackets(term);
		System.out.println("After:" + s);
	}

	private static void testBrackets() {
		System.out.println("testBrackets");
		String term = "646,(bg&15)*16+(fg&15)";
		System.out.println("Before: " + term);
		String s = TermEnhancer.addBrackets(term);
		System.out.println("After:" + s);
	}

	private static void testNumberExt1() {
		System.out.println("testNumberExt1");
		Machine machine = new Machine();
		String term = "$252525+%1010110";
		config.setNonDecimalNumbersAware(true);
		System.out.println("Before: " + term);
		term = TermEnhancer.handleNonDecimalNumbers(config, term);
		System.out.println("After: " + term);
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);

		Term t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));

	}

	private static void testSin() {
		System.out.println("testSin");
		Machine machine = new Machine();
		String term = "sin(23)--23";
		// String term = "sin(23) blah";
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		Term t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));

	}

	private static void testConstants() {
		System.out.println("testConstants");
		Machine machine = new Machine();
		String term = "(int(int(4.4+5*2.2)+5.6)) and (8+4)";
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		Term t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));
	}

	private static void testMinusPower() {
		System.out.println("testMinusPower");
		String term = "2+-(32-30)^10";
		String s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		Machine machine = new Machine();
		Term t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));

		term = "2*-3^2e1";
		// term="2*-3/3*+2^2";
		// term="(2*-(1*(2^2)))";
		s = TermEnhancer.addBrackets(term);
		System.out.println(s);
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		System.out.println(t.eval(machine));
	}

	private static void testArrayAccess() {
		System.out.println("testArrayAccess");
		String term = "10*b(1,1)";
		Machine machine = new Machine();
		Term t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		System.out.println(TermEnhancer.addBrackets(term));
		System.out.println();
		term = "10+b(1,1)";
		t = Parser.getTerm(config, term, machine, false, true);
		System.out.println(t);
		System.out.println(TermEnhancer.addBrackets(term));
		System.out.println();
		term = "a=a*2+4+b(1,1)";
		t = Parser.getTerm(config, term, machine, true, true);
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

		Term res = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
	}

	private static void testAnd2() {
		System.out.println("testAnd2");
		Machine machine = new Machine();
		machine.add(new Variable("A", 124));
		machine.add(new Variable("B", 3));
		String term = "(aand255-bor255+2*b)";
		String wbres = TermEnhancer.addBrackets(term);
		System.out.println("Added brackets: " + wbres);

		Term res = Parser.getTerm(config, term, machine, false, true);
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

		Term res = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));

		float a = 23;
		float b = 41;
		float c = 0;
		float d = 123;
		float f = 141;
		float g = 3;
		float z = 1;
		float t = 11;
		float r = 21;
		float p = 55;
		float u = 22;
		float o = 45;
		float i = 67;
		double rr = a * b * (-c * f + (t * r + -f * (g - z) - f * g / Math.pow(z, 4)))
				+ Math.abs(-(d * u)) * (p + (o * i * z)) * z + u;
		System.out.println("Real result: " + rr);

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

		Term res = Parser.getTerm(config, term, machine, false, true);
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

		Term res = Parser.getTerm(config, term, machine, false, true);
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

		Term res = Parser.getTerm(config, term, machine, false, true);
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

		Term res = Parser.getTerm(config, term, machine, false, true);
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
		Term res = Parser.getTerm(config, term, machine, false, true);
		System.out.println(res);
		System.out.println("Value: " + res.eval(machine));
		System.out.println(((5f * ((5.6f + (14f / (12f + (-1f * Math.sin((1.4f + (12f * -2f))))))) * 3f))
				/ (Math.cos((4.1234f)) + Math.cos(88f))));

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
