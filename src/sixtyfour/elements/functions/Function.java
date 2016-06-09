package sixtyfour.elements.functions;

import sixtyfour.Memory;
import sixtyfour.elements.Atom;
import sixtyfour.elements.Term;


public interface Function
  extends Atom
{
  String getName();


  boolean isFunction(String function);


  Function clone();


  Term getTerm();


  void setTerm(Term term);


  void parse(String linePart, Memory memory);

}
