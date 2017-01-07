package com.sixtyfour.basicshell;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;

/**
 * Helper class to load resources
 * 
 * @author nietoperz809
 */
public class ResourceLoader
{
    private final static String ICON = "commodore.png";
    private final static String FONT = "C64_Pro_Mono-STYLE.ttf";

    private static InputStream resourceAsStream (String name)
    {
        ClassLoader loader = Thread.currentThread().getContextClassLoader();
        return loader.getResourceAsStream(name);
    }

    public static Font getFont()
    {
        Font nt = null;
        try
        {
            nt = Font.createFont(Font.TRUETYPE_FONT, resourceAsStream(FONT));
            return nt.deriveFont(16f);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return null;
        }
    }

    public static BufferedImage getIcon()
    {
        try
        {
            return ImageIO.read (resourceAsStream(ICON));
        }
        catch (IOException e)
        {
            e.printStackTrace();
            return null;
        }
    }
}
