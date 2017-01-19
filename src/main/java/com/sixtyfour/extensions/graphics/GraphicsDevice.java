package com.sixtyfour.extensions.graphics;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.WindowEvent;
import java.awt.event.WindowStateListener;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferInt;
import java.awt.image.RenderedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.sixtyfour.extensions.graphics.commands.impl.FontProvider;
import com.sixtyfour.extensions.graphics.commands.impl.Shape;
import com.sixtyfour.plugins.PrintConsumer;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class GraphicsDevice implements PrintConsumer {

	private static Map<Machine, GraphicsDevice> machine2window = new WeakHashMap<Machine, GraphicsDevice>();
	private JFrame frame = null;
	private BufferedImage screen = null;
	private BufferedImage backBuffer = null;
	private Graphics2D gscreen = null;
	private Graphics2D gbackBuffer = null;
	private boolean filled = false;
	private int width = 0;
	private int height = 0;
	private int[] pixels = null;
	private Color color = Color.white;
	private long lastTime = 0;
	private long frameTime = 0;
	private long lastDif;
	private Map<Integer, Shape> shapes = new HashMap<Integer, Shape>();
	private int cursorX = 0;
	private int cursorY = 0;
	private RenderingHints noAa = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_OFF);
	private RenderingHints aa = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

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
		frame.setLayout(new BorderLayout());
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
		gscreen.setRenderingHints(noAa);

		JLabel label = new JLabel();
		label.setIcon(new ImageIcon(screen));
		label.setPreferredSize(new Dimension(x, y));
		frame.add(label, BorderLayout.CENTER);
		frame.pack();

		frame.setVisible(true);
	}

	public void dispose() {
		shapes.clear();
		removeFromMap();
	}

	public void setBufferMode(boolean doubleBuffer) {
		if (doubleBuffer) {
			if (backBuffer == null) {
				backBuffer = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
				gbackBuffer = backBuffer.createGraphics();
				gbackBuffer.setColor(Color.BLACK);
				gbackBuffer.fillRect(0, 0, width, height);
				gbackBuffer.setColor(color);
				pixels = null;
			}
		} else {
			if (backBuffer != null) {
				backBuffer = null;
				gbackBuffer.dispose();
				gbackBuffer = null;
				pixels = null;
			}
		}
	}

	public void addShape(Shape shape) {
		shapes.put(shape.getId(), shape);
	}

	public int addShape(String shapeName) {
		BufferedImage img = null;
		try {
			img = ImageIO.read(new File(shapeName));
		} catch (Exception e) {
			return -1;
		}

		Shape shape = new Shape(img);
		addShape(shape);
		return shape.getId();
	}

	public void color(int r, int g, int b, int a) {
		color = new Color(r & 0xff, g & 0xff, b & 0xff, a & 0xff);
		getContext().setColor(color);
		if (gbackBuffer != null) {
			gscreen.setColor(color);
		}
	}

	public void line(int xs, int ys, int xe, int ye) {
		getContext().drawLine(xs, ys, xe, ye);
		update();
	}

	public void plot(int x, int y) {
		if (x>=0 && x<width && y>=0 && y<height) {
			getScreen().setRGB(x, y, color.getRGB());
		}
		update();
	}

	public void circle(int x, int y, int xr, int yr) {
		if (filled) {
			getContext().fillOval(x - xr, y - yr, xr * 2, yr * 2);
		} else {
			getContext().drawOval(x - xr, y - yr, xr * 2, yr * 2);
		}
		update();
	}

	public void rect(int x1, int y1, int x2, int y2) {
		if (filled) {
			getContext().fillRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
		} else {
			getContext().drawRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
		}
		update();

	}

	public void setFillMode(boolean filled) {
		this.filled = filled;
	}

	public void clear() {
		getContext().fillRect(0, 0, width, height);
		update();
	}

	public void fill(int x, int y) {
		if (pixels == null) {
			DataBufferInt data = (DataBufferInt) getScreen().getRaster().getDataBuffer();
			pixels = data.getData();
		}
		new FloodFiller().fill(pixels, width, height, x, y, color);
		update();
	}

	public void save(Machine machine, String name) {
		try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(name)); ImageOutputStream ios = ImageIO.createImageOutputStream(bos)) {
			Iterator<ImageWriter> itty = ImageIO.getImageWritersBySuffix("png");
			if (itty.hasNext()) {
				ImageWriter iw = (ImageWriter) itty.next();
				ImageWriteParam iwp = iw.getDefaultWriteParam();
				iw.setOutput(ios);
				iw.write(null, new IIOImage((RenderedImage) getScreen(), null, null), iwp);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public void drawShape(int id, int x, int y, int xd, int yd) {
		Shape shape = shapes.get(id);
		if (shape == null) {
			throw new RuntimeException("Undefined shape " + id);
		}
		shape.paint(getContext(), x, y, xd, yd);
		update();
	}
	
	public void drawRotatedShape(int id, int x, int y, float zoom, float rot) {
    Shape shape = shapes.get(id);
    if (shape == null) {
      throw new RuntimeException("Undefined shape " + id);
    }
    shape.rotateAndPaint(getContext(), x, y, zoom, rot);
    update();
  }

	private void update() {
		if (backBuffer == null) {
			frame.repaint();
		}
	}

	public void flip() {
		if (backBuffer == null) {
			return;
		}
		gscreen.drawImage(backBuffer, 0, 0, null);
		frame.repaint();
	}

	public void limit(int fps) {
		if (fps <= 0) {
			return;
		}
		frameTime = 1000000000L / (long) fps;
		long now = System.nanoTime();
		long dif = now - lastTime;
		if (dif < 0) {
			// Fix overflow
			dif = lastDif;
		}
		lastDif = dif;
		if (dif < frameTime) {
			try {
				long waitTime = (frameTime - dif) / 1000000L;
				Thread.sleep(waitTime);
			} catch (Exception e) {
				//
			}
		}
		lastTime = System.nanoTime();
	}

	public void setCursor(int x, int y) {
		this.cursorX = x;
		this.cursorY = y;
	}

	public void setFont(String fontName, int style, int size) {
		Font font = FontProvider.getFont(fontName, style, size);
		getContext().setFont(font);
		if (gbackBuffer != null) {
			gscreen.setFont(font);
		}
	}

	@Override
	public void print(int id, String txt) {
		println(id, txt);
	}

	@Override
	public void println(int id, String txt) {
		Graphics2D context = getContext();
		context.drawString(txt, cursorX, cursorY);
		cursorX += context.getFontMetrics().getStringBounds(txt, getContext()).getWidth();
		update();
	}

	@Override
	public void systemPrint(int id, String txt) {
		System.err.print(id + "/" + txt);
	}

	@Override
	public void systemPrintln(int id, String txt) {
		System.err.println(id + "/" + txt);
	}

	public void setAAMode(boolean useAA) {
		if (useAA) {
			getContext().setRenderingHints(aa);
		} else {
			getContext().setRenderingHints(noAa);
		}
		if (gbackBuffer != null) {
			gscreen.setRenderingHints(getContext().getRenderingHints());
		}
	}

	private Graphics2D getContext() {
		if (gbackBuffer != null) {
			return gbackBuffer;
		}
		return gscreen;
	}

	private BufferedImage getScreen() {
		if (backBuffer != null) {
			return backBuffer;
		}
		return screen;
	}

	private void removeFromMap() {
		List<Machine> keys = new ArrayList<Machine>();
		for (Entry<Machine, GraphicsDevice> entry : machine2window.entrySet()) {
			if (entry.getValue() == this) {
				keys.add(entry.getKey());
				this.close();
			}
		}
		for (Machine machine : keys) {
			machine2window.remove(machine);
		}
	}

	private void close() {
		gscreen.dispose();
		if (gbackBuffer != null) {
			gbackBuffer.dispose();
		}
		frame.setVisible(false);
		frame.dispose();
	}
}
