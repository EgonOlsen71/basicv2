package com.sixtyfour.test;

import java.awt.image.BufferedImage;
import java.io.FileOutputStream;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.system.Graphics;


/**
 * @author EgonOlsen
 *
 */
public class AffineTextureMappingTest
{
  public static void main(String[] args)
    throws Exception
  {
    testBasicMapper();
  }


  private static void testBasicMapper()
    throws Exception
  {
    String[] vary = Loader.loadProgram("src/test/resources/basic/affine.bas");
    vary = Preprocessor.convertToLineNumbers(vary);
    for (String line : vary)
    {
      System.out.println(line);
    }
    Basic inty = new Basic(vary);
    inty.run();
    BufferedImage bi = Graphics.createImage(inty.getMachine(), 8192, 1024, false, true);
    FileOutputStream fos = new FileOutputStream("affine.png");
    Graphics.savePng(bi, fos);
  }
}
