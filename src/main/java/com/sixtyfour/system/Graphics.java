package com.sixtyfour.system;

import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;


/**
 * A simple helper class to save hires/multicolor bitmap screens into png files
 * 
 * @author EgonOlsen
 * 
 */
public class Graphics
{

  private final static int[] COLORS = new int[] { 0x000000, 0xFFFFFF, 0x68372B, 0x70A4B2, 0x6F3D86, 0x588D43, 0x352879,
      0xB8C76F, 0x6F4F25, 0x433900, 0x9A6759, 0x444444, 0x6C6C6C, 0x9AD284, 0x6C5EB5, 0x959595 };

  private final static int WHITE = 255 * 256 * 256 + 255 * 256 + 255;
  private final static int RED = 255 * 256 * 256;
  private final static int GREEN = 255 * 256;
  private final static int BLUE = 255;

  private final static int TEXT_MEMORY = 1024; // TODO: make this flexible
  private final static int COLOR_MEMORY = 55296;


  /**
   * Converts the content of a hires screen from memory into a png. It can take actual colors into account. Otherwise,
   * it will map the pixels to default colors.
   * 
   * @param machine
   *          the machine
   * @param startAddress
   *          the startAddress of the graphics memory
   * @param multiColor
   *          is multicolor mode being used?
   * @param withColors
   *          if true, colors from text/color ram will be taken into account. If false, default colors will be used.
   * @return the image (always 320*200)
   */
  public static BufferedImage createImage(Machine machine, int startAddress, boolean multiColor, boolean withColors)
  {
    BufferedImage bi = new BufferedImage(320, 200, BufferedImage.TYPE_INT_RGB);
    int[] ram = machine.getRam();
    int[] mc = new int[] { 0, BLUE, GREEN, RED };

    if (!withColors)
    {
      createWithDefaultColors(startAddress, multiColor, bi, ram, mc);
    }
    else
    {
      createWithRamColors(startAddress, multiColor, bi, ram);
    }
    return bi;
  }


  /**
   * Saves an image as PNG file.
   * 
   * @param bi
   *          the image
   * @param os
   *          the output stream. It will be closed when this method terminates.
   */
  public static void savePng(BufferedImage bi, OutputStream os)
  {
    try (BufferedOutputStream bos = new BufferedOutputStream(os);
        ImageOutputStream ios = ImageIO.createImageOutputStream(bos))
    {
      Iterator<ImageWriter> itty = ImageIO.getImageWritersBySuffix("png");
      if (itty.hasNext())
      {
        ImageWriter iw = (ImageWriter) itty.next();
        ImageWriteParam iwp = iw.getDefaultWriteParam();
        iw.setOutput(ios);
        iw.write(null, new IIOImage((RenderedImage) bi, null, null), iwp);
      }
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }


  private static void createWithRamColors(int startAddress, boolean multiColor, BufferedImage bi, int[] ram)
  {
    int bgColor = COLORS[ram[53281] & 0xFF];
    if (!multiColor)
    {
      for (int x = 0; x < 320; x += 8)
      {
        for (int y = 0; y < 200; y++)
        {
          int p = (x + (y & 7) + (y >> 3) * 320) + startAddress;
          int ramPos = (x / 8) + (y / 8) * 40;
          int col = ram[p] & 0xff;
          int s = 128;
          for (int b = 0; b < 8; b++)
          {
            int c = (col & s) == s ? (COLORS[ram[TEXT_MEMORY + ramPos] >> 4])
                : (COLORS[ram[TEXT_MEMORY + ramPos] & 0b00001111]);
            s >>= 1;
            bi.setRGB(x + b, y, c);
          }
        }
      }
    }
    else
    {
      for (int x = 0; x < 320; x += 8)
      {
        for (int y = 0; y < 200; y++)
        {
          int p = (x + (y & 7) + (y >> 3) * 320) + startAddress;
          int ramPos = (x / 8) + (y / 8) * 40;
          int col = ram[p] & 0xff;
          int s = 128;
          for (int b = 0; b < 8; b += 2)
          {
            int c1 = (col & s) == s ? 1 : 0;
            s >>= 1;
            c1 += (col & s) == s ? 2 : 0;
            s >>= 1;
            switch (c1)
            {
              case 0:
                c1 = bgColor;
                break;
              case 1:
                c1 = COLORS[ram[TEXT_MEMORY + ramPos] >> 4];
                break;
              case 2:
                c1 = COLORS[ram[TEXT_MEMORY + ramPos] & 0b00001111];
                break;
              case 3:
                c1 = COLORS[ram[COLOR_MEMORY + ramPos] & 0b00001111];
                break;
            }

            bi.setRGB(x + b, y, c1);
            bi.setRGB(x + b + 1, y, c1);
          }
        }
      }
    }
  }


  private static void createWithDefaultColors(int startAddress, boolean multiColor, BufferedImage bi, int[] ram,
      int[] mc)
  {
    if (!multiColor)
    {
      for (int x = 0; x < 320; x += 8)
      {
        for (int y = 0; y < 200; y++)
        {
          int p = (x + (y & 7) + (y >> 3) * 320) + startAddress;
          int col = ram[p] & 0xff;
          int s = 128;
          for (int b = 0; b < 8; b++)
          {
            int c = (col & s) == s ? WHITE : 0;
            s >>= 1;
            bi.setRGB(x + b, y, c);
          }
        }
      }
    }
    else
    {
      for (int x = 0; x < 320; x += 8)
      {
        for (int y = 0; y < 200; y++)
        {
          int p = (x + (y & 7) + (y >> 3) * 320) + startAddress;
          int col = ram[p] & 0xff;
          int s = 128;
          for (int b = 0; b < 8; b += 2)
          {
            int c1 = (col & s) == s ? 1 : 0;
            s >>= 1;
            int c2 = (col & s) == s ? 2 : 0;
            s >>= 1;
            bi.setRGB(x + b, y, mc[c1 + c2]);
            bi.setRGB(x + b + 1, y, mc[c1 + c2]);
          }
        }
      }
    }
  }

}
