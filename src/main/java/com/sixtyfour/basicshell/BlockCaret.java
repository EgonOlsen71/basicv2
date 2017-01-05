package com.sixtyfour.basicshell;

import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultCaret;
import javax.swing.text.JTextComponent;
import java.awt.*;

/**
 * @author nietoperz809
 *
 */
public class BlockCaret extends DefaultCaret
{
    private static final long serialVersionUID = 1L;

    @Override
    protected synchronized void damage (Rectangle r)
    {
        if (r == null)
        {
            return;
        }

        // give values to x,y,width,height (inherited from java.awt.Rectangle)
        x = r.x;
        y = r.y;
        height = r.height;
        // A value for width was probably set by paint(), which we leave alone.
        // But the first call to damage() precedes the first call to paint(), so
        // in this case we must be prepared to set a valid width, or else paint()
        // will receive a bogus clip area and caret will not get drawn properly.
        if (width <= 0)
        {
            width = getComponent().getWidth();
        }

        repaint(); // calls getComponent().repaint(x, y, width, height)
    }

    @Override
    public void paint (Graphics g)
    {
        JTextComponent comp = getComponent();
        if (comp == null)
        {
            return;
        }

        int dot = getDot();
        Rectangle r;
        try
        {
            r = comp.modelToView(dot);
            if (r == null)
            {
                return;
            }
        }
        catch (BadLocationException e)
        {
            return;
        }

        g.setColor(comp.getCaretColor());
        g.setXORMode(comp.getBackground()); // do this to draw in XOR mode

        int diam = r.height;
        if (isVisible())
        {
            g.fillRect(r.x, r.y, width, r.height); //, 12, 12);
        }
        width = diam / 2 + 2;
    }
}