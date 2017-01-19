package com.sixtyfour.extensions.graphics.commands.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

/**
 * A shape is something like a sprite, just more flexible...
 * 
 * @author Foerster-H
 * 
 */
public class Shape {
	private static int currentId = 0;
	private int id = currentId++;
	private BufferedImage shape;

	//
	private BufferedImage rotatedShape = null;
	private Rotator rotator = null;
	private int targetSize = -1;
	private float oldRotation = 0f;
	private float oldZoom = 0f;

	/**
	 * @param shape
	 */
	public Shape(BufferedImage shape) {
		this.shape = shape;
	}

	/**
	 * @return
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param context
	 * @param x
	 * @param y
	 * @param rot
	 */
	public void paint(Graphics2D context, int x, int y, int xd, int yd) {
		if (xd == -1) {
			context.drawImage(shape, x, y, null);
		} else {
			context.drawImage(shape, x, y, xd, yd, null);
		}
	}

	public void rotateAndPaint(Graphics2D context, int x, int y, float zoom, float rot) {
		int md = (int) ((Math.sqrt(shape.getWidth() * shape.getWidth() + shape.getHeight() * shape.getHeight()) + 0.5d) * Math.max(1, zoom));
		md = (md / 256) * 512;
		if (md < 256) {
			md = 256;
		}

		boolean created = false;
		if (rotator == null || targetSize < md) {
			// System.out.println("Created new Rotator: "+md+"/"+targetSize+"/"+(targetSize<md)+"/"+(rotator==null));
			rotator = new Rotator(shape, md, false);
			rotator.setRotationPivot(md / 2, md / 2);
			created = true;
			targetSize = md;
		}

		if (rotatedShape == null || rot != oldRotation || created || zoom != oldZoom) {
			rotator.setZoom(zoom);
			rotatedShape = rotator.createView(shape.getWidth() / 2, shape.getHeight() / 2, rot);
			oldRotation = rot;
			oldZoom = zoom;
		}

		float xf = x;
		float yf = y;

		xf -= (md / 2f - shape.getWidth() / 2f);
		yf -= (md / 2f - shape.getHeight() / 2f);

		context.drawImage(rotatedShape, (int) xf, (int) yf, null);
	}

}
