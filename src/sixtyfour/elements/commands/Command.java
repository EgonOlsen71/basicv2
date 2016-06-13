package sixtyfour.elements.commands;

import sixtyfour.parser.Atom;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;


public interface Command
  extends Atom
{
  String getName();


  boolean isCommand(String command);


  Command clone(String linePart);


  Term getTerm();


  void setTerm(Term term);


  String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory);


  ProgramCounter execute(Machine memory);
}
