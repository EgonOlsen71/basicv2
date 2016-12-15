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
 * A simple helper class to save hires screens into png files
 * 
 * @author EgonOlsen
 * 
 */
public class Graphics {

	/**
	 * Converts the content of a hires screen from memory into a png. It doesn't
	 * take color ram into account yet.
	 * 
	 * @param machine
	 *            the machine
	 * @param startAddress
	 *            the startAddress of the graphics memory
	 * @param multiColor
	 *            is multicolor mode being used?
	 * @return the image (always 320*200)
	 */
	public static BufferedImage createImage(Machine machine, int startAddress, boolean multiColor) {
		BufferedImage bi = new BufferedImage(320, 200, BufferedImage.TYPE_INT_RGB);
		int[] ram = machine.getRam();
		int white = 255 * 256 * 256 + 255 * 256 + 255;
		int red = 255 * 256 * 256;
		int green = 255 * 256;
		int blue = 255;
		int[] mc = new int[] { 0, blue, green, red };

		if (!multiColor) {
			for (int x = 0; x < 320; x += 8) {
				for (int y = 0; y < 200; y++) {
					int p = (x + (y & 7) + (y >> 3) * 320) + startAddress;
					int col = ram[p] & 0xff;
					int s = 128;
					for (int b = 0; b < 8; b++) {
						int c = (col & s) == s ? white : 0;
						s >>= 1;
						bi.setRGB(x + b, y, c);
					}
				}
			}
		} else {
			for (int x = 0; x < 320; x += 8) {
				for (int y = 0; y < 200; y++) {
					int p = (x + (y & 7) + (y >> 3) * 320) + startAddress;
					int col = ram[p] & 0xff;
					int s = 128;
					for (int b = 0; b < 8; b += 2) {
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
		return bi;
	}

	/**
	 * Saves an image as PNG file.
	 * 
	 * @param bi
	 *            the image
	 * @param os
	 *            the output stream. It will be closed when this method
	 *            terminates.
	 */
	public static void savePng(BufferedImage bi, OutputStream os) {
		try (BufferedOutputStream bos = new BufferedOutputStream(os); ImageOutputStream ios = ImageIO.createImageOutputStream(bos)) {
			Iterator<ImageWriter> itty = ImageIO.getImageWritersBySuffix("png");
			if (itty.hasNext()) {
				ImageWriter iw = (ImageWriter) itty.next();
				ImageWriteParam iwp = iw.getDefaultWriteParam();
				iw.setOutput(ios);
				iw.write(null, new IIOImage((RenderedImage) bi, null, null), iwp);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}
