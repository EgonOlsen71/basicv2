package sixtyfour.elements.commands;

import sixtyfour.elements.Assignment;
import sixtyfour.elements.Atom;

public interface Command extends Atom
{
  String getName();


  boolean isCommand(String command);


  Command clone(String linePart);


  String getTerm();


  void setTerm(String content);


  Assignment getAssignment();


  void setAssignment(Assignment assignment);

}
