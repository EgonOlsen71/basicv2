package com.sixtyfour.extensions.graphics;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.event.WindowEvent;
import java.awt.event.WindowStateListener;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferInt;
import java.awt.image.RenderedImage;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.WeakHashMap;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;

import com.sixtyfour.extensions.graphics.commands.impl.FloodFiller;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class GraphicsDevice {

	private static Map<Machine, GraphicsDevice> machine2window = new WeakHashMap<Machine, GraphicsDevice>();
	private JFrame frame = null;
	private BufferedImage screen = null;
	private Graphics2D gscreen = null;
	private boolean filled = false;
	private int width = 0;
	private int height = 0;
	private int[] pixels = null;
	private Color color = Color.white;

	public static GraphicsDevice getDevice(Machine machine) {
		return machine2window.get(machine);
	}

	public static GraphicsDevice openDevice(Machine machine, int x, int y) {
		if (x <= 0) {
			x = 320;
		}
		if (y <= 0) {
			y = 200;
		}
		GraphicsDevice window = machine2window.get(machine);
		if (window == null) {
			window = new GraphicsDevice(x, y);
			machine2window.put(machine, window);
		}
		return window;
	}

	public GraphicsDevice(int x, int y) {
		System.setProperty("sun.java2d.d3d", "false");
		width = x;
		height = y;
		frame = new JFrame("Graphics " + x + "*" + y);
		frame.setPreferredSize(new Dimension(x, y));
		frame.setSize(x, y);
		frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		frame.addWindowStateListener(new WindowStateListener() {
			@Override
			public void windowStateChanged(WindowEvent e) {
				if (e.getNewState() == WindowEvent.WINDOW_CLOSING) {
					removeFromMap();
				}
			}
		});

		screen = new BufferedImage(x, y, BufferedImage.TYPE_INT_ARGB);
		gscreen = screen.createGraphics();
		gscreen.setColor(Color.BLACK);
		gscreen.fillRect(0, 0, x, y);
		gscreen.setColor(color);

		JLabel label = new JLabel();
		label.setIcon(new ImageIcon(screen));
		frame.add(label);
		frame.pack();

		frame.setVisible(true);
	}

	public void dispose() {
		removeFromMap();
	}

	public void color(int r, int g, int b, int a) {
		color = new Color(r & 0xff, g & 0xff, b & 0xff, a & 0xff);
		gscreen.setColor(color);
	}

	public void line(int xs, int ys, int xe, int ye) {
		gscreen.drawLine(xs, ys, xe, ye);
		frame.repaint();
	}

	public void plot(int x, int y) {
		screen.setRGB(x, y, color.getRGB());
		frame.repaint();
	}

	public void circle(int x, int y, int xr, int yr) {
		if (filled) {
			gscreen.fillOval(x - xr, y - yr, xr * 2, yr * 2);
		} else {
			gscreen.drawOval(x - xr, y - yr, xr * 2, yr * 2);
		}
		frame.repaint();
	}

	public void rect(int x1, int y1, int x2, int y2) {
		if (filled) {
			gscreen.fillRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
		} else {
			gscreen.drawRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
		}
		frame.repaint();

	}

	public void setFillMode(boolean filled) {
		this.filled = filled;
	}

	public void clear() {
		gscreen.fillRect(0, 0, width, height);
		frame.repaint();
	}

	public void fill(int x, int y) {
		if (pixels == null) {
			DataBufferInt data = (DataBufferInt) (screen.getRaster().getDataBuffer());
			pixels = data.getData();
		}
		new FloodFiller().fill(pixels, width, height, x, y, color);
		frame.repaint();
	}

	public void save(Machine machine, String name) {
		try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(name)); ImageOutputStream ios = ImageIO.createImageOutputStream(bos)) {
			Iterator<ImageWriter> itty = ImageIO.getImageWritersBySuffix("png");
			if (itty.hasNext()) {
				ImageWriter iw = (ImageWriter) itty.next();
				ImageWriteParam iwp = iw.getDefaultWriteParam();
				iw.setOutput(ios);
				iw.write(null, new IIOImage((RenderedImage) screen, null, null), iwp);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

	private void removeFromMap() {
		List<Machine> keys = new ArrayList<Machine>();
		for (Entry<Machine, GraphicsDevice> entry : machine2window.entrySet()) {
			if (entry.getValue() == this) {
				keys.add(entry.getKey());
				entry.getValue().close();
			}
		}
		for (Machine machine : keys) {
			machine2window.remove(machine);
		}
	}

	private void close() {
		gscreen.dispose();
		frame.setVisible(false);
		frame.dispose();
	}
}
