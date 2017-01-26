package com.sixtyfour.extensions.graphics;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
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
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
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
import com.sixtyfour.extensions.textmode.ConsoleDevice;
import com.sixtyfour.plugins.PrintConsumer;
import com.sixtyfour.system.Machine;

/**
 * The GraphicsDevice provides an output window for advanced graphics in 24bit
 * color with an 8 bit alpha channel.
 * 
 * @author EgonOlsen
 * 
 */
public class GraphicsDevice implements PrintConsumer {

	private static Map<Machine, GraphicsDevice> machine2window = new WeakHashMap<Machine, GraphicsDevice>();
	private JFrame frame = null;
	private BufferedImage screen = null;
	private BufferedImage backBuffer = null;
	private BufferedImage copyBuffer = null;
	private Graphics2D gscreen = null;
	private Graphics2D gbackBuffer = null;
	private Graphics2D gcopyBuffer = null;
	private boolean filled = false;
	private int width = 0;
	private int height = 0;
	private int[] pixels = null;
	private Color color = Color.white;
	private Map<Integer, Shape> shapes = new HashMap<Integer, Shape>();
	private int cursorX = 0;
	private int cursorY = 0;
	private RenderingHints noAa = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_OFF);
	private RenderingHints aa = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
	private Queue<Character> keysPressed = new LinkedList<Character>();

	/**
	 * Returns an existing device for machine. If there is none, null will be
	 * returned.
	 * 
	 * @param machine
	 *            the machine
	 * @return the device or null
	 */
	public static GraphicsDevice getDevice(Machine machine) {
		return machine2window.get(machine);
	}

	/**
	 * Opens a new device for a machine. If there is one already, that will be
	 * returned regardless of its size.
	 * 
	 * @param machine
	 *            the machine
	 * @param x
	 *            the width
	 * @param y
	 *            the height
	 * @return a GraphicsDevice instance for the machine
	 */
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
	
	private GraphicsDevice(int x, int y) {
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

		frame.addKeyListener(new KeyListener() {
			@Override
			public void keyTyped(KeyEvent e) {
				//
			}

			@Override
			public void keyPressed(KeyEvent e) {
				synchronized (keysPressed) {
					if (!keysPressed.contains(e.getKeyChar())) {
						keysPressed.add(e.getKeyChar());
					}
				}
			}

			@Override
			public void keyReleased(KeyEvent e) {
				synchronized (keysPressed) {
					while (keysPressed.remove(e.getKeyChar())) {
						//
					}
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

	/**
	 * Disposes this GraphicsDevice. It can't be accessed afterwards.
	 */
	public void dispose() {
		shapes.clear();
		removeFromMap();
	}

	/**
	 * Sets the buffer mode to single/double buffering.
	 * 
	 * @param doubleBuffer
	 *            true for double buffering, false for single (which is default)
	 */
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

	/**
	 * Adds a shape to this device.
	 * 
	 * @param shape
	 *            the shape
	 */
	public void addShape(Shape shape) {
		shapes.put(shape.getId(), shape);
	}

	/**
	 * Adds a shape loaded from the given filename to the device.
	 * 
	 * @param shapeName
	 *            the filename of the shape
	 * @return the id of the added shape
	 */
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

	/**
	 * Sets the current draw color.
	 * 
	 * @param r
	 *            red
	 * @param g
	 *            green
	 * @param b
	 *            blue
	 * @param a
	 *            alpha
	 */
	public void color(int r, int g, int b, int a) {
		color = new Color(r & 0xff, g & 0xff, b & 0xff, a & 0xff);
		getContext().setColor(color);
		if (gbackBuffer != null) {
			gscreen.setColor(color);
		}
	}

	/**
	 * Draws a line.
	 * 
	 * @param xs
	 *            x start
	 * @param ys
	 *            y start
	 * @param xe
	 *            x end
	 * @param ye
	 *            y end
	 */
	public void line(int xs, int ys, int xe, int ye) {
		getContext().drawLine(xs, ys, xe, ye);
		update();
	}

	/**
	 * Plots a point.
	 * 
	 * @param x
	 *            x coordinate
	 * @param y
	 *            y coordinate
	 */
	public void plot(int x, int y) {
		if (x >= 0 && x < width && y >= 0 && y < height) {
			getScreen().setRGB(x, y, color.getRGB());
		}
		update();
	}

	/**
	 * Draws a circle.
	 * 
	 * @param x
	 *            x coordinate of the midpoint
	 * @param y
	 *            y coordinate of the midpoint
	 * @param xr
	 *            the radius in x direction
	 * @param yr
	 *            the radius in y direction
	 */
	public void circle(int x, int y, int xr, int yr) {
		if (filled) {
			getContext().fillOval(x - xr, y - yr, xr * 2, yr * 2);
		} else {
			getContext().drawOval(x - xr, y - yr, xr * 2, yr * 2);
		}
		update();
	}

	/**
	 * Draws a rectangle.
	 * 
	 * @param x1
	 *            x of the upper left corner
	 * @param y1
	 *            y of the upper left corner
	 * @param x2
	 *            x of the lower right corner
	 * @param y2
	 *            y of the lower right corner
	 */
	public void rect(int x1, int y1, int x2, int y2) {
		if (filled) {
			getContext().fillRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
		} else {
			getContext().drawRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
		}
		update();

	}

	/**
	 * Sets the fill mode. If set to true, circles and rectangles will be
	 * filled. If false, their outlines will be drawn (which is default).
	 * 
	 * @param filled
	 *            fill them?
	 */
	public void setFillMode(boolean filled) {
		this.filled = filled;
	}

	/**
	 * Clears the screen.
	 */
	public void clear() {
		getContext().fillRect(0, 0, width, height);
		update();
	}

	/**
	 * Does a flood fill at position x,y.
	 * 
	 * @param x
	 *            the x position of the seed point
	 * @param y
	 *            the y position of the seed point
	 */
	public void fill(int x, int y) {
		if (pixels == null) {
			DataBufferInt data = (DataBufferInt) getScreen().getRaster().getDataBuffer();
			pixels = data.getData();
		}
		new FloodFiller().fill(pixels, width, height, x, y, color);
		update();
	}

	/**
	 * Saves the current image into a PNG file.
	 * 
	 * @param machine
	 *            the machine
	 * @param name
	 *            the name of the target file
	 */
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

	/**
	 * Draws a (scaled) shape.
	 * 
	 * @param id
	 *            the id of the shape
	 * @param x
	 *            x of the upper left corner
	 * @param y
	 *            y of the upper left corner
	 * @param xd
	 *            the width
	 * @param yd
	 *            the height
	 */
	public void drawShape(int id, int x, int y, int xd, int yd) {
		Shape shape = shapes.get(id);
		if (shape == null) {
			throw new RuntimeException("Undefined shape " + id);
		}
		shape.paint(getContext(), x, y, xd, yd);
		update();
	}

	/**
	 * Draws a rotated/scaled shape.
	 * 
	 * @param id
	 *            the id of the shape
	 * @param x
	 *            x of the upper left corner when not rotated or scaled
	 * @param y
	 *            y of the upper left corner when not rotated or scaled
	 * @param zoom
	 *            the zoom factor (uniform!)
	 * @param rot
	 *            the rotation angle in radians
	 */
	public void drawRotatedShape(int id, int x, int y, float zoom, float rot) {
		Shape shape = shapes.get(id);
		if (shape == null) {
			throw new RuntimeException("Undefined shape " + id);
		}
		shape.rotateAndPaint(getContext(), x, y, zoom, rot);
		update();
	}

	/**
	 * Flips the buffers, if double buffering is used. Does nothing otherwise.
	 */
	public void flip() {
		if (backBuffer == null) {
			return;
		}
		gscreen.drawImage(backBuffer, 0, 0, null);
		frame.repaint();
	}

	/**
	 * Sets the cursor to a position.
	 * 
	 * @param x
	 *            the x position
	 * @param y
	 *            the y position
	 */
	public void setCursor(int x, int y) {
		this.cursorX = x;
		this.cursorY = y;
	}

	/**
	 * Sets the current font.
	 * 
	 * @param fontName
	 *            the font's name
	 * @param style
	 *            the font's style (0=plain, 1=bold, 2=italic)
	 * @param size
	 *            the font's size
	 */
	public void setFont(String fontName, int style, int size) {
		Font font = FontProvider.getFont(fontName, style, size);
		getContext().setFont(font);
		if (gbackBuffer != null) {
			gscreen.setFont(font);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#print(int, java.lang.String)
	 */
	@Override
	public void print(int id, String txt) {
		println(id, txt);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#println(int, java.lang.String)
	 */
	@Override
	public void println(int id, String txt) {
		Graphics2D context = getContext();
		context.drawString(txt, cursorX, cursorY);
		cursorX += context.getFontMetrics().getStringBounds(txt, getContext()).getWidth();
		update();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrint(int,
	 * java.lang.String)
	 */
	@Override
	public void systemPrint(int id, String txt) {
		System.err.print(id + "/" + txt);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrintln(int,
	 * java.lang.String)
	 */
	@Override
	public void systemPrintln(int id, String txt) {
		System.err.println(id + "/" + txt);
	}

	/**
	 * Sets the anti.aliasing mode.
	 * 
	 * @param useAA
	 *            Should AA be used?
	 */
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

	/**
	 * Copies a region of the screen buffer into another one. xs,ys define the
	 * upper left and xe,ye the lower right corner of the region to copy. xt and
	 * yt define the upper left position of the target region.
	 * 
	 * @param xs
	 *            x of the upper left corner of the region to copy
	 * @param ys
	 *            y of the upper left corner of the region to copy
	 * @param xe
	 *            x of the lower right corner of the region to copy
	 * @param ye
	 *            y of the lower right corner of the region to copy
	 * @param xt
	 *            x of the upper left corner of the target region
	 * @param yt
	 *            y of the upper left corner of the target region
	 */
	public void copy(int xs, int ys, int xe, int ye, int xt, int yt) {
		int tmp = 0;
		if (xs > xe) {
			tmp = xe;
			xe = xs;
			xs = tmp;
		}
		if (ys > ye) {
			tmp = ye;
			ye = ys;
			ys = tmp;
		}
		internalCopy(xs, ys, xe, ye, xt, yt);
	}

	/**
	 * Copies a region of the screen buffer into a shape and returns the id.
	 * 
	 * @param xs
	 *            x of the upper left corner of the region to copy
	 * @param ys
	 *            y of the upper left corner of the region to copy
	 * @param xe
	 *            x of the lower right corner of the region to copy
	 * @param ye
	 *            y of the lower right corner of the region to copy
	 * @return the new shappe's id
	 */
	public int getShape(int xs, int ys, int xe, int ye) {
		BufferedImage shapeImage = new BufferedImage(xe - xs, ye - ys, BufferedImage.TYPE_INT_ARGB);
		Graphics2D sg = shapeImage.createGraphics();
		sg.drawImage(getScreen(), 0, 0, xe - xs, ye - ys, xs, ys, xe, ye, null);
		sg.dispose();
		Shape shape = new Shape(shapeImage);
		addShape(shape);
		return shape.getId();
	}
	
	/**
	 * Creates a new shape and links its image content to the one of an open PETSCII console. 
	 * If no console is open, an empty shape will be returned.
	 * @param machine the Machine
	 * 
	 * @param update 
	 *       if 0, updates to the console won't show up in the shape. If 1, they will.
	 * 
	 * @return the new shape's ID
	 */
	public int linkShape(Machine machine, int update)
  {
    ConsoleDevice console=ConsoleDevice.getDevice(machine);
    if (console==null) {
      return getShape(0,0,1,1);
    }
    if (update!=0) {
      Shape shape = new Shape(console.getScreen());
      addShape(shape);
      return shape.getId();
    } else {
      BufferedImage conImg=console.getScreen();
      BufferedImage shapeImage = new BufferedImage(conImg.getWidth(), conImg.getHeight(), BufferedImage.TYPE_INT_ARGB);
      Graphics2D sg = shapeImage.createGraphics();
      sg.drawImage(conImg, 0, 0, conImg.getWidth(), conImg.getHeight(), null);
      sg.dispose();
      Shape shape = new Shape(shapeImage);
      addShape(shape);
      return shape.getId();
    }
  }

	/**
	 * Reads a key from the keyboard when the graphics output window has focus.
	 * 
	 * @param allowedChars
	 *            a string that contains all the allowed chars. If empty or
	 *            null, there's no limitation.
	 * @return the key or null
	 */
	public Character gget(String allowedChars) {
		synchronized (keysPressed) {
			Character chr = keysPressed.poll();
			if (chr != null) {
				if (allowedChars != null && allowedChars.length() > 0) {
					while (chr != null && allowedChars.indexOf(chr) == -1) {
						chr = keysPressed.poll();
					}
				}
				if (chr != null) {
					keysPressed.add(chr);
				}
			}
			return chr;
		}
	}

	private void internalCopy(final int xs, final int ys, final int xe, final int ye, final int xt, final int yt) {
		if (copyBuffer == null) {
			copyBuffer = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
			gcopyBuffer = copyBuffer.createGraphics();
		}
		gcopyBuffer.drawImage(getScreen(), 0, 0, xe - xs, ye - ys, xs, ys, xe, ye, null);
		getContext().drawImage(copyBuffer, xt, yt, xt + xe - xs, yt + ye - ys, 0, 0, xe - xs, ye - ys, null);
		update();
	}

	private void update() {
		if (backBuffer == null) {
			frame.repaint();
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
		if (gcopyBuffer != null) {
			gcopyBuffer.dispose();
		}
		frame.setVisible(false);
		frame.dispose();
	}

  
}
