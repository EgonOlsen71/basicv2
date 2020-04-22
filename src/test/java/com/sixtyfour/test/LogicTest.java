package com.sixtyfour.test;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
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
	 * @param args the arguments
	 */
	public static void main(String[] args) {
		testLogicParser();
		testLogicSimilarity();
	}

	public static void testLogicSimilarity() {
		System.out.println("testLogicSimilarity");
		Machine machine = new Machine();
		machine.add(new Variable("A", 1));
		machine.add(new Variable("B", 2));
		machine.add(new Variable("C", 3));
		machine.add(new Variable("D", 4));
		machine.add(new Variable("E", 5));

		Term res = Parser.getTerm(config, "A/B>=C*E+4 AND D=12", machine, false, true);
		Term res1 = Parser.getTerm(config, "A/B>=C*E+4 AND D=12", machine, false, true);
		Term res2 = Parser.getTerm(config, "A/B=C*E+4 AND D=12", machine, false, true);
		System.out.println("Parsed: " + res);
		System.out.println("Parsed1: " + res1);
		System.out.println("Parsed2: " + res2);
		System.out.println("res=res1: " + res.equals(res1));
		System.out.println("res=res2: " + res.equals(res2));
		System.out.println("res2=res2: " + res2.equals(res2));
	}

	/**
	 * Test logic parser.
	 */
	public static void testLogicParser() {
		System.out.println("testLogicParser");
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
