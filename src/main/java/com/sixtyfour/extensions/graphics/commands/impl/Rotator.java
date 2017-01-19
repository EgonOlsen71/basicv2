package com.sixtyfour.extensions.graphics.commands.impl;

import java.awt.*;
import java.awt.image.*;

/**
 * @author EgonOlsen
 */
public class Rotator {

   private final static int ACCURACY=8192;
   private final static int ACC_SHIFT=13;

   private BufferedImage target=null;
   private BufferedImage oTarget=null;
   private int[] texels=null;
   private int[] pixels=null;
   private int[] oPixels=null;
   private int width=0;
   private int height=0;
   private int tWidth=0;
   private int tHeight=0;

   private int pivotX=0;
   private int pivotY=0;
   private int centerX=0;
   private int centerY=0;

   private float zoom=1;
   private float orgZoom=1;

   private boolean overSample=false;
   private int targetSize=0;

  public Rotator(BufferedImage source, int targetSize, boolean overSample) {
      this.overSample=overSample;
      init(source, targetSize);
   }

   /**
    * Sets the zoom. Below 1 zooms out, larger than 1 zooms in
    * @param zoom float the zoom
    */
   public void setZoom(float zoom) {
       orgZoom=zoom;
      this.zoom=1f/zoom;
   }

   /**
   * @return
   */
  public float getZoom() {
     return orgZoom;
   }
   
  /**
   * @return
   */
  public int getTargetSize()
  {
    return targetSize;
  }

  
   /**
    * Sets the rotation pivot in the target picture's coordinate system.
    * @param xp int x-position of the pivot
    * @param yp int y-position of the pivot
    */
   public void setRotationPivot(int xp, int yp) {
      int shft=0;
      if (overSample) {
         shft=1;
      }
      if (xp>=0 && xp<tWidth>>shft && yp>=0 && yp<tHeight>>shft) {
         pivotX=xp<<shft;
         pivotY=yp<<shft;
      } else {
         throw new RuntimeException("Rotation pivot out of bounds!");
      }
   }

   /**
    * Creates a rotated and zoomed picture
    * @param xPos float the x-position of the rotation pivot relative to the source bitmap
    * @param yPos float the y-position of the rotation pivot relative to the source bitmap
    * @param angle float the turning angle
    * @return Image the picture
    */
   public BufferedImage createView(float xPos, float yPos, float angle) {
      float[] p0=new float[2];
      float[] p1=new float[2];
      float[] p3=new float[2];

      int dx=centerX-pivotX;
      int dy=centerY-pivotY;

      p0[0]=-centerX+dx;
      p0[1]=-centerY+dy;
      p1[0]=centerX+dx;
      p1[1]=-centerY+dy;
      p3[0]=-centerX+dx;
      p3[1]=centerY+dy;

      float zoom=this.zoom;
      if (overSample) {
         zoom/=2;
      }

      for (int i=0; i<2; i++) {
         p0[i]*=zoom;
         p1[i]*=zoom;
         p3[i]*=zoom;
      }

      rotate(p0, angle);
      rotate(p1, angle);
      rotate(p3, angle);

      float deltaXU=p1[0]-p0[0];
      float deltaXV=p1[1]-p0[1];
      float deltaYU=p3[0]-p0[0];
      float deltaYV=p3[1]-p0[1];

      deltaXU/=(float)tWidth;
      deltaXV/=(float)tWidth;
      deltaYU/=(float)tHeight;
      deltaYV/=(float)tHeight;

      float px=p0[0]+xPos;
      float py=p0[1]+yPos;

      int end=texels.length;

      // Converting to Fixedpoint...
      int idXU=(int) (deltaXU*(float)ACCURACY);
      int idXV=(int) (deltaXV*(float)ACCURACY);
      int idYU=(int) (deltaYU*(float)ACCURACY);
      int idYV=(int) (deltaYV*(float)ACCURACY);
      int ipx=(int) (px*(float)ACCURACY);
      int ipy=(int) (py*(float)ACCURACY);

      int pos=0;

      for (int y=0; y<tHeight; y++) {
         int ppx=ipx;
         int ppy=ipy;
         int endPos=pos+tWidth;
         for (int x=pos; x<endPos; x++) {
            int oppx=ppx>>ACC_SHIFT;
            int texelPos=(ppy>>ACC_SHIFT)*width+oppx;
            if (texelPos<end&&texelPos>=0&&oppx>=0&&oppx<width) {
               pixels[x]=texels[texelPos];
            } else {
               pixels[x]=0;
            }
            ppx+=idXU;
            ppy+=idXV;
         }
         pos+=tWidth;
         ipy+=idYV;
         ipx+=idYU;
      }
      if (overSample) {
         downSample();
         return oTarget;
      } else {
         return target;
      }
   }

   public Image getTargetImage() {
     if (overSample) {
       downSample();
       return oTarget;
    } else {
       return target;
    }
   }
   
   private void downSample() {
      int pr;
      int pg;
      int pb;

      int p1, p2, p3, p4;
      int bpos=0;
      int length=pixels.length-tWidth-1;
      int opos=0;
      int i=0;

      while (bpos<length) {
         p1=pixels[bpos];
         p2=pixels[bpos+1];
         p3=pixels[bpos+tWidth];
         p4=pixels[bpos+tWidth+1];

         pr=((p1>>16)&255)+((p2>>16)&255)+((p3>>16)&255)+((p4>>16)&255)>>2<<16;
         pg=((p1>>8)&255)+((p2>>8)&255)+((p3>>8)&255)+((p4>>8)&255)>>2<<8;
         pb=((p1)&255)+((p2)&255)+((p3)&255)+((p4)&255)>>2;
         oPixels[opos]=pr|pg|pb;

         opos++;
         bpos+=2;
         i+=2;
         if (i>=tWidth) {
            i=0;
            bpos+=tWidth;
         }
      }
   }

   private void init(BufferedImage img, int targetSize) {
      height=img.getHeight();
      width=img.getWidth();

      texels=new int[width*height];

      PixelGrabber pg=new PixelGrabber(img, 0, 0, width, height, texels, 0, width);
      try
      {
        pg.grabPixels();
      }
      catch (InterruptedException e)
      {
        throw new RuntimeException(e);
      }

      int shft=0;
      if (overSample) {
         shft=1;
      }

      tWidth=targetSize<<shft;
      tHeight=targetSize<<shft;

      target=new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_INT_ARGB);
      pixels=((DataBufferInt) ((BufferedImage) target).getRaster().getDataBuffer()).getData();

      if (overSample) {
         oTarget=new BufferedImage(targetSize, targetSize, BufferedImage.TYPE_INT_ARGB);
         oPixels=((DataBufferInt) ((BufferedImage) oTarget).getRaster().getDataBuffer()).getData();
      }

      pivotX=tWidth>>1;
      pivotY=tHeight>>1;

      centerX=pivotX;
      centerY=pivotY;
   }

   private void rotate(float[] point, float angle) {
      if (point.length!=2) {
         throw new RuntimeException("Array size has to be 2 but is: "+point.length);
      }
      float oldX=point[0];
      float oldY=point[1];

      float sinZ=(float) Math.sin(angle);
      float cosZ=(float) Math.cos(angle);

      point[0]=oldX*cosZ-oldY*sinZ;
      point[1]=oldX*sinZ+oldY*cosZ;
   }
}
