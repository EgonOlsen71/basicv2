package com.sixtyfour.basicshell;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;

import javax.swing.JComponent;
import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultCaret;
import javax.swing.text.JTextComponent;


/**
 * Code based on Groovy text editor ... groovy-console/src/main/groovy/groovy/ui/text/TextEditor.java
 * 
 * @author nietoperz809
 */

public class BlockCaret
  extends DefaultCaret
{
  private static final long serialVersionUID = 1L;


  public BlockCaret()
  {
    setBlinkRate(500);
  }


  protected synchronized void damage(Rectangle r)
  {
    if (r != null)
    {
      JTextComponent component = getComponent();
      x = r.x;
      y = r.y;
      Font font = component.getFont();
      width = component.getFontMetrics(font).charWidth('w');
      height = r.height;
      repaint();
    }
  }


  public void mouseClicked(MouseEvent e)
  {
    JComponent c = (JComponent) e.getComponent();
    c.repaint();
  }


  public void paint(Graphics g)
  {
    if (isVisible())
    {
      try
      {
        JTextComponent component = getComponent();
        Rectangle r = component.getUI().modelToView(component, getDot());
        Color c = g.getColor();
        g.setColor(component.getBackground());
        g.setXORMode(component.getCaretColor());
        r.setBounds(r.x, r.y, g.getFontMetrics().charWidth('w'), g.getFontMetrics().getHeight());
        g.fillRect(r.x, r.y, r.width, r.height);
        g.setPaintMode();
        g.setColor(c);
      }
      catch (BadLocationException e)
      {
        e.printStackTrace();
      }
    }
  }
}
