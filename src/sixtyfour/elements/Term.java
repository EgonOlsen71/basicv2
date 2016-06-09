package sixtyfour.elements;

public class Term
  implements Atom
{
  private Atom left;
  private Atom right;
  private Operator operator;
  private String expression;
  private String key;


  public Term(String expression)
  {
    this.setExpression(expression);
  }


  public boolean isComplete()
  {
    return left != null && right != null && operator != null;
  }


  public Atom getLeft()
  {
    return left;
  }


  public void setLeft(Atom left)
  {
    //System.out.println("Left: "+left);
    this.left = left;
  }


  public Atom getRight()
  {
    return right;
  }


  public void setRight(Atom right)
  {
    //System.out.println("Right: "+right);
    this.right = right;
  }


  public Operator getOperator()
  {
    return operator;
  }


  public void setOperator(Operator operator)
  {
    this.operator = operator;
  }


  public String getExpression()
  {
    return expression;
  }


  public void setExpression(String expression)
  {
    this.expression = expression;
  }


  public String getKey()
  {
    return key;
  }


  public void setKey(String key)
  {
    this.key = key;
  }


  @Override
  public String toString()
  {
    return "(" + left+ this.operator + right + ")";
  }

}
