package com.sixtyfour.test;

import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.system.Machine;


public class JavaTest
{

  public static void main(String[] args)
  {
    GraphicsDevice gd = GraphicsDevice.openDevice(new Machine(), 800, 600);
    long s=System.currentTimeMillis();
    int[] r = new int[256];
    int[] g = new int[256];
    int[] b = new int[256];
    int ismnd = -1;
    int rp = 20, gp = 80, bp = 100;
    for (int i = 0; i < 256; i++)
    {
      r[i] = rp;
      g[i] = gp;
      b[i] = bp;
      rp += 7;
      gp += 9;
      bp += 5;

      if (rp > 255)
      {
        rp = 20;
      }
      if (gp > 255)
      {
        gp = 20;
      }
      if (bp > 255)
      {
        bp = 20;
      }
    }

    float xl = -1.2f, xu = -1.185f;
    float yl = -0.195f, yu = -0.185f;

    int reps = 255;
    int iters = 0;
    int width = 800, height = 600;

    float xinc = (xu - xl) / width;
    float yinc = (yu - yl) / height;

    for (int j = 0; j < height; j++)
    {
      for (int i = 0; i < width; i++)
      {
        ismnd = -1;
        float nreal = xl + (float) i * xinc;
        float nimg = yl + (float) j * yinc;
        float rz = 0f, iz = 0f;
        float r2z = 0f, i2z = 0f;

        for (int k = 0; k <= reps; k++)
        {
          r2z = rz * rz - iz * iz;
          i2z = 2.0f * rz * iz;
          rz = r2z + nreal;
          iz = i2z + nimg;
          iters = k;
          if ((rz * rz + iz * iz) > 4)
          {
            ismnd = 0;
            k = reps;
            break;
          }
        }

        if (ismnd != 0)
        {
          gd.color(0, 0, 0, 255);
        }
        else
        {
          gd.color(r[iters], g[iters], b[iters], 255);
        }
        gd.plot(i, j);
      }
    }
    System.out.println((System.currentTimeMillis()-s)+"ms");
  }
}
