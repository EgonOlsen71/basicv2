package sixtyfour.test;

import sixtyfour.Interpreter;
import sixtyfour.Memory;

public class InterpreterTest {

	public static void main(String[] args) {
		testLet();
	}

	private static void testLet() {
		String code = "10 a=45:b=7\n" + "20 c=67.2:z=a:h$=\"test\"\n"+"45 a=(23.22+12.2+b)/c:h$=h$+\"wurst\":popo$=h$+h$";

		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.execute();
		
		Memory mem=inter.getMemory();
		
		System.out.println(mem.getVariable("a"));
		System.out.println(mem.getVariable("z"));
		System.out.println(mem.getVariable("b"));
		System.out.println(mem.getVariable("c"));
		System.out.println(mem.getVariable("h$"));
		System.out.println(mem.getVariable("po$"));
	}

}
