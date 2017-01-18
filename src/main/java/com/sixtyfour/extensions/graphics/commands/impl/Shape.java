package com.sixtyfour.extensions.graphics.commands.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;


/**
 * A shape is something like a sprite, just more flexible...
 * 
 * @author Foerster-H
 *
 */
public class Shape
{
  private static int currentId = 0;
  private int id = currentId++;
  private BufferedImage shape;


  /**
   * @param shape
   */
  public Shape(BufferedImage shape)
  {
    this.shape = shape;
  }


  /**
   * @return
   */
  public int getId()
  {
    return id;
  }


  /**
   * @param context
   * @param x
   * @param y
   */
  public void paint(Graphics2D context, int x, int y, int xd, int yd)
  {
    if (xd==-1) {
      context.drawImage(shape, x, y, null);
    } else {
      context.drawImage(shape, x, y, xd, yd, null);
    }
    
  }

}
