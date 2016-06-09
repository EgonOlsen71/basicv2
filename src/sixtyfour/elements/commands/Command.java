package sixtyfour.elements.commands;

import sixtyfour.Memory;
import sixtyfour.elements.Atom;
import sixtyfour.elements.ProgramCounter;
import sixtyfour.elements.Term;


public interface Command
  extends Atom
{
  String getName();


  boolean isCommand(String command);


  Command clone(String linePart);


  Term getTerm();


  void setTerm(Term term);


  void parse(String linePart, int lineCnt, int lineNumber, int linePos, Memory memory);


  ProgramCounter execute(Memory memory);
}
