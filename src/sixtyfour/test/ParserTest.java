package sixtyfour.test;

import sixtyfour.elements.Variable;
import sixtyfour.elements.commands.Command;
import sixtyfour.parser.Line;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;

public class ParserTest {

	public static void main(String[] args) {
		testLineNumber();
		testCommands();
		testTermCompletion();
		testTermCreation();
		testComplexFunctions();
		testLogic();
	}

	private static void testLogic() {
		System.out.println("testLogic");
		Machine memory = new Machine();
		memory.add(new Variable("A%", 5));
		memory.add(new Variable("B%", 32));
		String term = "NOT 1 OR NOT (110+10)";
		String wbres = Parser.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, memory);
		System.out.println(res);
		System.out.println("Value: " + res.eval(memory));
	}

	private static void testComplexFunctions() {
		System.out.println("testComplexFunctions");
		Machine memory = new Machine();
		memory.add(new Variable("A$", "abcdefghijklmnopqrstuvwxyz"));
		memory.add(new Variable("B$", "test"));
		memory.add(new Variable("A", 1));
		String term = "\"hallo\"+\" \"+mid$(A$+a$,1*5+3*5,13)+\" \"+mid$(\"1234567\", 3)+\" \"+mid$(B$+\"hallo\", 1+1+(1*1), 5)+\" \"+mid$(B$+\"hallo\", 1+2+(1*1)-a)";

		String wbres = Parser.addBrackets(term);
		System.out.println(wbres);

		Term res = Parser.getTerm(term, memory);
		System.out.println(res);
		System.out.println("Value: " + res.eval(memory));
	}

	private static void testTermCreation() {
		System.out.println("testTermCreation");
		Machine memory = new Machine();
		memory.add(new Variable("A", 5));
		memory.add(new Variable("B", 5.6f));
		memory.add(new Variable("C", 14));
		memory.add(new Variable("Z", 12));
		memory.add(new Variable("U", 1.4));
		memory.add(new Variable("K", -2));
		memory.add(new Variable("D", 3));
		memory.add(new Variable("I", 4.1234));
		String term = "(a^z * (b + c / (z+-sin(u+z*k))) * d)/cos(i) + cos(-88)";
		// String term="sin(-1)";
		Term res = Parser.getTerm(term, memory);
		System.out.println(res);
		System.out.println("Value: " + res.eval(memory));
		System.out.println(((5f * ((5.6f + (14f / (12f + (-1f * Math.sin((1.4f + (12f * -2f))))))) * 3f)) / (Math.cos((4.1234f)) + Math.cos(88f))));

		// term =
		// "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + -(d*u)*(p+(o*i*z))*z+u";
		// res = Lexer.getTerm(term, memory);
		// System.out.println(res);
	}

	private static void testTermCompletion() {
		System.out.println("testTermCompletion");
		String term = "a + b * c + d";
		String res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b + c * d * -2";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * c + d";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * c * d";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * -c + -d";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a + b - c + d^e*r";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + -(d*u)*(p+(o*i*z))*z+u";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a + (b + c / (z+u))";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * (b + c / (z+-u))";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * (b + c / (z+-sin(u+z*k))) * d/cos(i) + cos(88)";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "\"ha a*b*c+d llo \"+\"welt!\"";
		res = Parser.addBrackets(term);
		System.out.println(term + " is actually " + res);
	}

	private static void testCommands() {
		System.out.println("testCommands");
		String test = getSimpleLine();
		Command com = Parser.getCommand(Parser.getLine(test).getLine());
		System.out.println("Command is: " + com);

	}

	private static void testLineNumber() {
		System.out.println("testLineNumber");
		String test = getSimpleLine();
		Line line = Parser.getLine(test);
		System.out.println("Line number is: " + line.getNumber());

		test = test.replace(" ", "").replace("10", "65500");
		line = Parser.getLine(test);
		System.out.println("Line number is: " + line.getNumber());
	}

	private static String getSimpleLine() {
		return "10 PRINT\"Hello World\"";
	}

}
