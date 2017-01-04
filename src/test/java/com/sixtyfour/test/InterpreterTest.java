package com.sixtyfour.test;

import com.sixtyfour.Basic;
import com.sixtyfour.system.Machine;

/**
 * Basic interpreter tests.
 */
public class InterpreterTest {

	/**
	 * The main method.
	 * 
	 * @param args
	 *            the arguments
	 */
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
		testIf();
		testLogic();
		testSys();
		testRunStop();
	}

	private static void testRunStop() {
		System.out.println("testRunStop");
		String code = "10 goto 10";
		final Basic inter = new Basic(code);
		try {
			new Thread() {
				@Override
				public void run() {
					try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					System.out.println("RUN/STOP called!");
					inter.runStop();
				}
			}.start();
			inter.run();
			while (inter.isRunnning()) {
				Thread.sleep(10);
			}
			System.out.println("testRunStop terminated!");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

	/**
	 * Test sys.
	 */
	private static void testSys() {
		System.out.println("testSys");
		String code = "10 a=64738\n20 sys 64738:sysa:sysa,12,\"hallo\", 4.4, a";
		Basic inter = new Basic(code);
		inter.run();
	}

	/**
	 * Test logic.
	 */
	private static void testLogic() {
		System.out.println("testLogic");
		String code = "10 a=5\n20if notnota then print\"hello\"\n30printa=5\n40b=a=5\n50printb\n60if b then print\"hello again!\"";
		Basic inter = new Basic(code);
		inter.run();
	}

	/**
	 * Test if.
	 */
	private static void testIf() {
		System.out.println("testIf");
		String code = "10 a=5\n20ifa=5thenprint\"a is 5\"\n30ifa<>5thenprint\"a is not 5\"\n40if(a>2+1*1)goto100:print\"Should not be here!\"\n50print\"Should not print this\"\n100print\"We are here...\"\n110if((a<>10))then print\"1.print\":print\"2.print\":b=34+a:printb";
		Basic inter = new Basic(code);
		inter.run();
	}

	/**
	 * Test goto.
	 */
	private static void testGoto() {
		System.out.println("testGoto");
		String code = "10 a=5\n20printa\n30goto50\n40a=10:print\"Shouldn't see me...\"\n50printa+4";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();

	}

	/**
	 * Test poke.
	 */
	private static void testPoke() {
		System.out.println("testPoke");
		String code = "10 poke1,3:print peek(1)";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test end.
	 */
	private static void testEnd() {
		System.out.println("testEnd");
		String code = "10 a=5:printa\n20end\n30printa+100";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();

	}

	/**
	 * Test speed.
	 */
	private static void testSpeed() {
		System.out.println("testSpeed");
		String code = "10 fori=8192to49152:pokei,i+(3*4)and255:next";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test tabbeb print.
	 */
	private static void testTabbebPrint() {
		System.out.println("testTabbebPrint");
		String code = "10 for i=0to10:forj=1to2:print tab(6);i;tab(20);j;tab(30);pos(0).:nextj,i";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();

	}

	/**
	 * Test functions in functions.
	 */
	private static void testFunctionsInFunctions() {
		System.out.println("testFunctionsInFunctions");
		String code = "10 dim a(10,10):a(5,5)=3:a$=\"123456\":print mid$(a$, a(5,2+3)+0)";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test rem.
	 */
	private static void testRem() {
		System.out.println("testRem");
		String code = "10 rem Voll der Quatsch\n20 a=5:rem hallo:printa";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test let.
	 */
	private static void testLet() {
		System.out.println("testLet");

		String code = "10 let z=25:a=45:b=7\n" + "20 c=67.2:z=a:h$=\"te r*t/u st\"\n" + "45 a=(23.22+12.2+b)/c:h$=h$+\"wu{t0}rst\":popo$=h$+h$\n100 i=88:u%=14+20:i=peek(u%)";

		Basic inter = new Basic(code);
		inter.compile();
		inter.run();

		Machine mem = inter.getMachine();

		System.out.println(mem.getVariable("a"));
		System.out.println(mem.getVariable("z"));
		System.out.println(mem.getVariable("b"));
		System.out.println(mem.getVariable("c"));
		System.out.println(mem.getVariable("h$"));
		System.out.println(mem.getVariable("po$"));
		System.out.println(mem.getVariable("u%"));
		System.out.println(mem.getVariable("i"));
	}

	/**
	 * Test print.
	 */
	private static void testPrint() {
		System.out.println("testPrint");
		String code = "10 a=45:a$=\"horse\"\n20 print\"hello world and \"+a$:print a;\"oo\"a$SPC(10)a$:print a+23*a+2\n";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test complex print.
	 */
	private static void testComplexPrint() {
		System.out.println("testComplexPrint");
		String code = "10 a=45:b$=\"hallo\"\n20printcos(a),sin(a+1)b$b$;\"du ,.-\",,,b$\n30print\"hallo\"+b$;SPC(0):print\"du!\"";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test for.
	 */
	private static void testFor() {
		System.out.println("testFor");
		String code = "10 for i=1 to 10:print i:next\n20 for j=4 to 8:print j+45+i:for u=0to3step2:printu+j:next u,j";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test dim.
	 */
	private static void testDim() {
		System.out.println("testDim");
		String code = "10 a=5:print a:dim a(10, a+1), b$, c\n20a(1,1)=123:b$(6)=\"wurst\"\n30printa(1,1)+3:printb$(6)+\"hallo\"\n40printr$(7)";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

	/**
	 * Test array.
	 */
	private static void testArray() {
		System.out.println("testArray");
		String code = "5print\"---------------\"\n10 dim a(10, 5):fori=0to10:forj=0to5:a(i,j)=i+j:next:next\n20fori=0to10:forj=0to5:b=a(i,j)*2:printb:printa(i,j)*2+1:next:next";
		Basic inter = new Basic(code);
		inter.compile();
		inter.run();
	}

}
