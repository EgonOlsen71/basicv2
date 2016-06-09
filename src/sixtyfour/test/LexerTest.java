package sixtyfour.test;

import sixtyfour.Lexer;
import sixtyfour.Memory;
import sixtyfour.elements.Line;
import sixtyfour.elements.Term;
import sixtyfour.elements.Variable;
import sixtyfour.elements.commands.Command;

public class LexerTest {

	public static void main(String[] args) {
		testLineNumber();
		testCommands();
		testTermCompletion();
		testTermCreation();
	}
	
	

	private static void testTermCreation()
  {
	  Memory memory=new Memory();
	  memory.add(new Variable("A", 5));
	  memory.add(new Variable("B", 5.6f));
	  memory.add(new Variable("C", 14));
    String term = "a * (b + c / (z+-u)) * d";
    Term res = Lexer.getTerm(term, memory);
    System.out.println(res);
    
    //term = "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + -(d*u)*(p+(o*i*z))*z+u";
    //res = Lexer.getTerm(term, memory);
    //System.out.println(res);
  }



  private static void testTermCompletion() {
		String term = "a + b * c + d";
		String res = Lexer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b + c * d * -2";
		res = Lexer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * c + d";
		res = Lexer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * c * d";
		res = Lexer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * -c + -d";
		res = Lexer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a + b - c + d^e*r";
		res = Lexer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a * b * (-c*f+(t*r+-f*(g-z)-f*g/z^4)) + -(d*u)*(p+(o*i*z))*z+u";
		res = Lexer.addBrackets(term);
		System.out.println(term + " is actually " + res);
		term = "a + (b + c / (z+u))";
    res = Lexer.addBrackets(term);
    System.out.println(term + " is actually " + res);
		term = "a * (b + c / (z+-u))";
    res = Lexer.addBrackets(term);
    System.out.println(term + " is actually " + res);

	}

	private static void testCommands() {
		String test = getSimpleLine();
		Command com = Lexer.getCommand(Lexer.getLine(test).getLine());
		System.out.println("Command is: " + com);

	}

	private static void testLineNumber() {
		String test = getSimpleLine();
		Line line = Lexer.getLine(test);
		System.out.println("Line number is: " + line.getNumber());

		test = test.replace(" ", "").replace("10", "65500");
		line = Lexer.getLine(test);
		System.out.println("Line number is: " + line.getNumber());
	}

	private static String getSimpleLine() {
		return "10 PRINT\"Hello World\"";
	}

}
