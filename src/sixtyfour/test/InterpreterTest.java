package sixtyfour.test;

import sixtyfour.Interpreter;
import sixtyfour.Machine;

public class InterpreterTest {

	public static void main(String[] args) {
		testLet();
		testPrint();
		testFor();
		testDim();
		testArray();
		testFunctionsInFunctions();
		testComplexPrint();
		testTabbebPrint();
		testRem();
		testEnd();
		testPoke();
		testGoto();
		testSpeed();
		test();
	}

	private static void test() {
		String code = "0 dima(10,10):j=5:i=5:a(i,j)=10+5\n10 b=(a(i,j))*2+1:printa(i,j)*2+1;tab(10);b";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testGoto() {
		System.out.println("testGoto");
		String code = "10 a=5\n20printa\n30goto50\n40a=10:print\"Shouldn't see me...\"\n50printa+4";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();

	}

	private static void testPoke() {
		System.out.println("testPoke");
		String code = "10 poke1,3:print peek(1)";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testEnd() {
		System.out.println("testEnd");
		String code = "10 a=5:printa\n20end\n30printa+100";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();

	}

	private static void testSpeed() {
		System.out.println("testSpeed");
		String code = "10 fori=8192to16191:pokei,iand255::next";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testTabbebPrint() {
		System.out.println("testTabbebPrint");
		String code = "10 for i=0to10:forj=1to2:print tab(6);i;tab(20);j;tab(30);pos(0).:nextj,i";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();

	}

	private static void testFunctionsInFunctions() {
		System.out.println("testFunctionsInFunctions");
		String code = "10 dim a(10,10):a(5,5)=3:a$=\"123456\":print mid$(a$, a(5,2+3)+0)";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testRem() {
		System.out.println("testRem");
		String code = "10 rem Voll der Quatsch\n20 a=5:rem hallo:printa";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testLet() {
		System.out.println("testLet");
		String code = "10 a=45:b=7\n" + "20 c=67.2:z=a:h$=\"te r*t/u st\"\n" + "45 a=(23.22+12.2+b)/c:h$=h$+\"wu{t0}rst\":popo$=h$+h$\n100 i=88:u%=14+20:i=peek(u%)";

		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();

		Machine mem = inter.getMemory();

		System.out.println(mem.getVariable("a"));
		System.out.println(mem.getVariable("z"));
		System.out.println(mem.getVariable("b"));
		System.out.println(mem.getVariable("c"));
		System.out.println(mem.getVariable("h$"));
		System.out.println(mem.getVariable("po$"));
		System.out.println(mem.getVariable("u%"));
		System.out.println(mem.getVariable("i"));
	}

	private static void testPrint() {
		System.out.println("testPrint");
		String code = "10 a=45:a$=\"horse\"\n20 print\"hello world and \"+a$:print a;\"oo\"a$SPC(10)a$:print a+23*a+2\n";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testComplexPrint() {
		System.out.println("testComplexPrint");
		String code = "10 a=45:b$=\"hallo\"\n20printcos(a),sin(a+1)b$b$;\"du ,.-\",,,b$\n30print\"hallo\"+b$;SPC(0):print\"du!\"";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testFor() {
		System.out.println("testFor");
		String code = "10 for i=1 to 10:print i:next\n20 for j=4 to 8:print j+45+i:for u=0to3step2:printu+j:next u,j";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testDim() {
		System.out.println("testDim");
		String code = "10 a=5:print a:dim a(10, a+1), b$, c\n20a(1,1)=123:b$(6)=\"wurst\"\n30printa(1,1)+3:printb$(6)+\"hallo\"\n40printr$(7)";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

	private static void testArray() {
		System.out.println("testArray");
		String code = "5print\"---------------\"\n10 dim a(10, 5):fori=0to10:forj=0to5:a(i,j)=i+j:next:next\n20fori=0to10:forj=0to5:b=a(i,j)*2:printb:printa(i,j)*2+1:next:next";
		Interpreter inter = new Interpreter(code);
		inter.parse();
		inter.run();
	}

}
