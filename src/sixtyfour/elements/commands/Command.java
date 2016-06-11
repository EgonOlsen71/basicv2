package sixtyfour.elements.commands;

import sixtyfour.elements.Atom;
import sixtyfour.elements.ProgramCounter;
import sixtyfour.elements.Term;
import sixtyfour.system.Machine;


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
