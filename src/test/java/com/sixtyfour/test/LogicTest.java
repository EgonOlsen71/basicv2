package com.sixtyfour.test;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.logic.LogicParser;
import com.sixtyfour.parser.logic.LogicTerm;
import com.sixtyfour.system.Machine;

/**
 * Basic tests for the logic parser.
 */
public class LogicTest {
	private static CompilerConfig config = new CompilerConfig();

	/**
	 * The main method.
	 * 
	 * @param args
	 *            the arguments
	 */
	public static void main(String[] args) {
		testLogicParser();
	}

	/**
	 * Test logic parser.
	 */
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

		LogicTerm res = LogicParser.getTerm(config, "A<B AND C+D <> (D+E)/A", machine);
		System.out.println("Result: " + res.evalToBoolean(machine));
		System.out.println("Parsed: " + res);

		res = LogicParser.getTerm(config, "(A<B) AND NOT C+D <> (D+E)/A", machine);
		System.out.println("Result: " + res.evalToBoolean(machine));
		System.out.println("Parsed: " + res);

		res = LogicParser.getTerm(config, "(A<B) AND ((NOT(((C+D <> (D+E)/A OR A>(E+D))))))", machine);
		System.out.println("Result: " + res.evalToBoolean(machine));
		System.out.println("Parsed: " + res);

		res = LogicParser.getTerm(config, "(A<B) AND (C+D > (D+E)/A OR A<(E+D))", machine);
		System.out.println("Result: " + res.evalToBoolean(machine));
		System.out.println("Parsed: " + res);

		res = LogicParser.getTerm(config, "NOTNOTNOT (A<B) AND (C+D > (D+E)/A OR A<(E+D))", machine);
		System.out.println("Result: " + res.evalToBoolean(machine));
		System.out.println("Parsed: " + res);
	}

}
