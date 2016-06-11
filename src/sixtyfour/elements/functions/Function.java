package sixtyfour.elements.functions;

import sixtyfour.elements.Atom;
import sixtyfour.elements.Term;
import sixtyfour.system.Machine;


public interface Function
  extends Atom
{
  String getName();


  boolean isFunction(String function);


  Function clone();


  Term getTerm();


  void setTerm(Term term);


  void parse(String linePart, Machine memory);

}
