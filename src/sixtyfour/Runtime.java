package sixtyfour;

public class Runtime
{
  public static void main(String[] args)
  {
    if (args.length == 0)
    {
      throw new RuntimeException("No file name specified!");
    }
    String file = args[0];
    String[] code = Loader.loadProgram(file);
    Interpreter parser = new Interpreter(code);
    parser.parse();
  }

}
