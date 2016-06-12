package sixtyfour.test;

import sixtyfour.elements.Variable;
import sixtyfour.parser.logic.LogicParser;
import sixtyfour.parser.logic.LogicTerm;
import sixtyfour.system.Machine;

public class LogicTest {

	public static void main(String[] args) {
		testLogicParser();
	}

	public static void testLogicParser() {
		System.out.println("testTermCreation");
		Machine machine = new Machine();
		machine.add(new Variable("A", 1));
		machine.add(new Variable("B", 2));
		machine.add(new Variable("C", 3));
		machine.add(new Variable("D", 4));
		machine.add(new Variable("E", 5));
		// LogicTerm res = LogicParser.getTerm("A<B AND (NOT(C+D <> (D+E)/A))",
		// machine);

		LogicTerm res = LogicParser.getTerm("A<B AND NOT C+D <> (D+E)/A", machine);
		System.out.println("Result: " + res.eval(machine));
		System.out.println("Parsed: " + res);
		
		res = LogicParser.getTerm("(A<B) AND NOT C+D <> (D+E)/A", machine);
		System.out.println("Result: " + res.eval(machine));
		System.out.println("Parsed: " + res);
		
		res = LogicParser.getTerm("(A<B) AND ((NOT(((C+D <> (D+E)/A OR A>(E+D))))))", machine);
		System.out.println("Result: " + res.eval(machine));
		System.out.println("Parsed: " + res);
		
		res = LogicParser.getTerm("(A<B) AND (C+D > (D+E)/A OR A<(E+D))", machine);
		System.out.println("Result: " + res.eval(machine));
		System.out.println("Parsed: " + res);
		
		res = LogicParser.getTerm("NOTNOTNOT (A<B) AND (C+D > (D+E)/A OR A<(E+D))", machine);
		System.out.println("Result: " + res.eval(machine));
		System.out.println("Parsed: " + res);
	}

}
