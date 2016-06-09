package sixtyfour;

public class Interpreter
{
  public static void main(String[] args)
  {
    if (args.length == 0)
    {
      throw new RuntimeException("No file name specified!");
    }
    String file = args[0];
    String[] code = Loader.loadProgram(file);
    Parser parser = new Parser(code);
    parser.parse();
  }

}
