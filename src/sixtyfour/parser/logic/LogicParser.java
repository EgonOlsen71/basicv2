/*
 * 
 */
package sixtyfour.parser.logic;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;


/**
 * The Class LogicParser.
 */
public class LogicParser
{

  /**
	 * Checks if is logic term.
	 * 
	 * @param term
	 *            the term
	 * @return true, if is logic term
	 */
  public static boolean isLogicTerm(String term)
  {
    term = Parser.replaceStrings(term, ' ');
    return term.contains("=") || term.contains(">") || term.contains("<");
  }


  /**
	 * Gets the term.
	 * 
	 * @param term
	 *            the term
	 * @param machine
	 *            the machine
	 * @return the term
	 */
  public static LogicTerm getTerm(String term, Machine machine)
  {
    return getTerm(term, machine, null);
  }


  /**
	 * Gets the term.
	 * 
	 * @param term
	 *            the term
	 * @param machine
	 *            the machine
	 * @param termMap
	 *            the term map
	 * @return the term
	 */
  public static LogicTerm getTerm(String term, Machine machine, Map<String, Term> termMap)
  {
    Map<String, LogicTerm> blocks = new HashMap<String, LogicTerm>();
    term = processLogicOperations(term);
    boolean inString = false;
    term = "(" + Parser.removeWhiteSpace(term) + ")";
    Parser.checkBrackets(term);
    String lastPart = term;
    int lastStart = 0;

    for (int i = 0; i < term.length(); i++)
    {
      char c = term.charAt(i);
      if (c == '"')
      {
        inString = !inString;
      }
      if (!inString)
      {
        if (c == '(')
        {
          int end = findEndBracket(term, i);
          if (end <= i + 1)
          {
            throw new RuntimeException("Syntax error: " + term);
          }
          String part = term.substring(i, end + 1);

          String partS = stripStrings(part);

          // System.out.println("Part: " + part + "/" + partS + "/" +
          // lastPart);

          boolean brackets = partS.contains("(");
          if ((partS.contains("OR") || partS.contains("AND")) && brackets)
          {
            lastPart = part;
            lastStart = i;
            continue;
          }

          if (!brackets && !(partS.contains("OR") || partS.contains("AND")))
          {
            continue;
          }
        }
        else if (i == term.length() - 1)
        {
          String toProcess = lastPart;
          int startPos = lastStart;
          String blockName = createLogicBlock(toProcess.substring(1, toProcess.length() - 1), blocks, machine, termMap);
          int endy = Math.min(startPos + toProcess.length(), term.length());
          term = term.substring(0, startPos) + blockName
              + (endy != term.length() ? term.substring(endy, term.length()) : "");
          i = -1;
          inString = false;
          lastPart = term;
          lastStart = 0;

          // System.out.println("TERM: " + term);

          String nbrack = term.replace("(", "").replace(")", "");
          if (blocks.containsKey(nbrack))
          {
            return blocks.get(nbrack);
          }
        }
      }
    }
    throw new RuntimeException("Syntax error: " + term);
  }


  /**
	 * Process logic operations.
	 * 
	 * @param term
	 *            the term
	 * @return the string
	 */
  private static String processLogicOperations(String term)
  {
    // Try to replace logic operations in brackets by placeholders to avoid
    // parser confusion...

    // TODO Replace by something more sophisticated...
    // To the left...
    String[] reps = { ")=", ")>", ")<" };
    for (String rep : reps)
    {
      int pos = 0;
      do
      {
        pos = term.indexOf(rep, pos);
        if (pos != -1)
        {
          boolean inString = false;
          int brackets = 0;
          for (int i = pos; i >= 0; i--)
          {
            char c = term.charAt(i);
            if (c == '"')
            {
              inString = !inString;
            }
            if (!inString)
            {
              if (c == ')')
              {
                brackets--;
              }
              else if (c == '(')
              {
                brackets++;
                if (brackets == 0)
                {
                  String part = term.substring(i, pos + 1);
                  String partn = Parser.replaceLogicOperators(part);
                  term = term.substring(0, i) + partn + term.substring(pos + 1);
                  pos = pos - (part.length() - partn.length());
                  break;
                }
              }
            }
          }
          pos += 2;
        }
      }
      while (pos != -1);
    }

    // And to the right...
    reps = new String[] { "=(", ">(", "<(" };
    for (String rep : reps)
    {
      int pos = 0;
      do
      {
        pos = term.indexOf(rep, pos);
        if (pos != -1)
        {
          boolean inString = false;
          int brackets = 0;
          for (int i = pos; i < term.length(); i++)
          {
            char c = term.charAt(i);
            if (c == '"')
            {
              inString = !inString;
            }
            if (!inString)
            {
              if (c == ')')
              {
                brackets--;
                if (brackets == 0)
                {
                  String part = term.substring(pos, i + 1);
                  String partn = Parser.replaceLogicOperators(part);
                  term = term.substring(0, pos) + partn + term.substring(i + 1);
                  pos = pos - (part.length() - partn.length());
                  break;
                }
              }
              else if (c == '(')
              {
                brackets++;
              }
            }
          }
          pos += 2;
        }
      }
      while (pos != -1);
    }

    return term;
  }


  /**
	 * Creates the logic block.
	 * 
	 * @param toProcess
	 *            the to process
	 * @param blocks
	 *            the blocks
	 * @param machine
	 *            the machine
	 * @param termMap
	 *            the term map
	 * @return the string
	 */
  private static String createLogicBlock(String toProcess, Map<String, LogicTerm> blocks, Machine machine,
      Map<String, Term> termMap)
  {

    // System.out.println("To process: " + toProcess);

    String[] delims = { "OR", "AND" };
    String utp = Parser.replaceStrings(toProcess, '.');
    int curPos = 0;
    String minOp = null;
    LogicTerm block = new LogicTerm("{l" + blocks.size() + "}");
    do
    {
      int minPos = 999999999;
      minOp = null;
      for (String delim : delims)
      {
        int pos = utp.indexOf(delim, curPos);
        if (pos != -1 && pos < minPos)
        {
          minPos = pos;
          minOp = delim;
        }
      }

      String part = toProcess.substring(curPos);
      LogicOp op = new LogicAnd();
      if (minOp != null)
      {
        if (minOp.equals("OR"))
        {
          op = new LogicOr();
        }
        part = toProcess.substring(curPos, minPos);
        curPos = minPos + minOp.length();
      }

      boolean inString = false;
      int closest = -1;
      for (int i = 0; i < part.length(); i++)
      {
        char c = part.charAt(i);
        if (c == '"')
        {
          inString = !inString;
        }
        if (!inString)
        {
          if (c == '<' || c == '>' || c == '=')
          {
            closest = i;
            break;
          }
        }
      }

      String left = null;
      String right = null;
      Comparator comp = null;
      boolean not = false;

      if (closest != -1)
      {
        left = part.substring(0, closest);
        right = part.substring(closest);
        comp = Comparator.getComparator(right);
        if (comp == null)
        {
          throw new RuntimeException("Syntax error: " + part);
        }
        right = right.substring(comp.getTermLength());

        boolean nt = false;
        do
        {
          nt = left.toUpperCase(Locale.ENGLISH).startsWith("NOT");
          if (nt)
          {
            left = left.substring(3);
            not = !not;
          }
        }
        while (nt);

      }
      else
      {
        if (part.contains("}"))
        {
          part = part.replace("(", "").replace(")", "");

          boolean nt = false;
          do
          {
            nt = part.toUpperCase(Locale.ENGLISH).startsWith("NOT");
            if (nt)
            {
              part = part.substring(3);
              not = !not;
            }
          }
          while (nt);
          if (!part.startsWith("{"))
          {
            throw new RuntimeException("Syntax error: " + part);
          }

          LogicTerm lt = blocks.get(part);
          if (not)
          {
            lt.not();
          }
          block.add(lt, op);
        }
        else
        {
          left = part;
          right = null;
          comp = Comparator.EQUAL;
        }
      }

      // System.out.println("Terms:" + left + " " + comp + " " + right +
      // "/" + not);

      if (left != null)
      {
        Comparison compy = new Comparison();
        compy.setComparator(comp);

        int bl = getBracketDelta(left);
        if (bl > 0)
        {
          // This will destroy the term if the brackets are not at the
          // beginning. But then again, the term is wrong that way
          // anyway...
          left = left.substring(bl);
        }
        compy.setLeft(Parser.getTerm(left, machine, false, true, termMap));
        if (right != null)
        {
          int br = getBracketDelta(right);
          if (br < 0)
          {
        	  right = right.substring(0, right.length() + br);
          }
          compy.setRight(Parser.getTerm(right, machine, false, true, termMap));
        }
        if (not)
        {
          compy.not();
        }

        block.add(compy, op);
      }

    }
    while (minOp != null);
    blocks.put(block.getName(), block);
    return block.getName();
  }


  /**
	 * Gets the bracket delta.
	 * 
	 * @param term
	 *            the term
	 * @return the bracket delta
	 */
  private static int getBracketDelta(String term)
  {
    int brackets = 0;
    boolean inString = false;
    for (int i = 0; i < term.length(); i++)
    {
      char c = term.charAt(i);
      if (c == '"')
      {
        inString = !inString;
      }
      if (!inString)
      {
        if (c == '(')
        {
          brackets++;
        }
        else if (c == ')')
        {
          brackets--;
        }
      }
    }
    return brackets;
  }


  /**
	 * Strip strings.
	 * 
	 * @param term
	 *            the term
	 * @return the string
	 */
  private static String stripStrings(String term)
  {
    StringBuilder sb = new StringBuilder();
    boolean inString = false;
    for (int i = 1; i < term.length() - 1; i++)
    {
      char c = term.charAt(i);
      if (c == '"')
      {
        inString = !inString;
        if (inString)
        {
          sb.append('"');
        }
      }
      if (!inString)
      {
        sb.append(c);
      }
    }
    return sb.toString().toUpperCase(Locale.ENGLISH);
  }


  /**
	 * Find end bracket.
	 * 
	 * @param term
	 *            the term
	 * @param pos
	 *            the pos
	 * @return the int
	 */
  private static int findEndBracket(String term, int pos)
  {
    int brackets = 0;
    boolean inString = false;
    for (int i = pos; i < term.length(); i++)
    {
      char c = term.charAt(i);
      if (c == '"')
      {
        inString = !inString;
      }
      if (!inString)
      {
        if (c == '(')
        {
          brackets++;
        }
        else if (c == ')')
        {
          brackets--;
          if (brackets == 0)
          {
            return i;
          }
        }
      }
    }
    if (brackets == 0)
    {
      return term.length();
    }
    throw new RuntimeException("Syntax error: " + term);

  }

}
