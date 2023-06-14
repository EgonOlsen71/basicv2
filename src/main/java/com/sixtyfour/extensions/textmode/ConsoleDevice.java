package com.sixtyfour.extensions.textmode;

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
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.Set;
import java.util.WeakHashMap;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;

import com.sixtyfour.plugins.InputProvider;
import com.sixtyfour.plugins.MemoryListener;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.PrintConsumer;
import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.Colors;

/**
 * The console device provides a PETSCII console with 40*25 characters.
 * 
 * @author EgonOlsen
 * 
 */
public class ConsoleDevice implements OutputChannel, SystemCallListener, MemoryListener, InputProvider {

	private static final int COLOR_RAM = 55296;
	private static final int TEXT_RAM = 1024;
	private static Map<Machine, ConsoleDevice> machine2window = new WeakHashMap<Machine, ConsoleDevice>();
	private String charset;

	private JFrame frame = null;
	private BufferedImage screen = null;
	private Graphics2D gscreen = null;
	private int width = 0;
	private int height = 0;
	private int color = 14;
	private int bgColor = 6;
	private int baseLine = 0;
	private int cursorX = 0;
	private int cursorY = 0;
	private boolean reverseMode = false;
	private boolean graphicsFontUsed = true;
	private RenderingHints noAa = new RenderingHints(RenderingHints.KEY_ANTIALIASING,
			RenderingHints.VALUE_ANTIALIAS_OFF);
	private Queue<Character> keysPressed = new LinkedList<Character>();
	private SystemCallListener oldSystemCallListener = null;
	private MemoryListener oldMemoryListener = null;
	private OutputChannel oldOutputChannel = null;
	private InputProvider oldInputProvider = null;
	private int[] ram;
	private Color[] colors = new Color[Colors.COLORS.length];
	private StringBuilder inputString = new StringBuilder();
	private boolean inputMode = false;
	private boolean cursorMode = false;
	private boolean cursorOn = false;
	private int insertPos = -1;
	private Thread cursorThread = null;
	private boolean shiftDown = false;

	private Set<Integer> toIgnore = new HashSet<Integer>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(KeyEvent.VK_SHIFT);
			this.add(KeyEvent.VK_CONTROL);
			this.add(KeyEvent.VK_CAPS_LOCK);
			this.add(KeyEvent.VK_ALT);
			this.add(KeyEvent.VK_ALT_GRAPH);
		}
	};

	/**
	 * Returns an existing device for machine. If there is none, null will be
	 * returned.
	 * 
	 * @param machine the machine
	 * @return the device or null
	 */
	public static ConsoleDevice getDevice(Machine machine) {
		return machine2window.get(machine);
	}

	/**
	 * Opens a new device for a machine. If there is one already, that will be
	 * returned regardless of its size.
	 * 
	 * @param machine     the machine
	 * @param consoleType the type of the console, >0 for a visible console, else
	 *                    hidden
	 * @param clear
	 * @param x           the width
	 * @param y           the height
	 * @return a GraphicsDevice instance for the machine
	 */
	public static ConsoleDevice openDevice(Machine machine, int consoleType, boolean clear, int x, int y) {
		if (x <= 0) {
			x = 320;
		}
		if (y <= 0) {
			y = 200;
		}
		ConsoleDevice window = machine2window.get(machine);
		if (window == null) {
			window = new ConsoleDevice(machine, consoleType, clear, x, y);
			machine2window.put(machine, window);
		} else {
			window.updateScreen();
		}
		return window;
	}

	private ConsoleDevice(Machine machine, int consoleType, boolean clear, int x, int y) {
		System.setProperty("sun.java2d.d3d", "false");
		width = x;
		height = y;

		charset = createCharsetMapping();

		oldSystemCallListener = machine.getSystemCallListener();
		oldMemoryListener = machine.getMemoryListener();
		oldOutputChannel = machine.getOutputChannel();
		oldInputProvider = machine.getInputProvider();

		ram = machine.getRam();

		for (int i = 0; i < Colors.COLORS.length; i++) {
			colors[i] = new Color(Colors.COLORS[i]);
		}

		machine.setSystemCallListener(this);
		machine.setMemoryListener(this);
		machine.setOutputChannel(this);
		machine.setInputProvider(this);

		frame = new JFrame("Console " + x + "*" + y);
		frame.setLayout(new BorderLayout());
		frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		frame.addKeyListener(new FontToggler());
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
				if (inputMode) {
					char c = e.getKeyChar();
					if (Character.isDigit(c) || Character.isAlphabetic(c) || Character.isWhitespace(c)
							|| "#-.,:;'+*/\"!§$%&/()][}{ß?´`".indexOf(c) != -1) {
						if (Character.isWhitespace(c)) {
							c = ' ';
						}
						if (insertPos == -1) {
							inputString.append(c);
						} else {
							inputString.setCharAt(insertPos, c);
							insertPos++;
							if (insertPos >= inputString.length()) {
								insertPos = -1;
							}
						}
						print(0, Character.toString(c));
					}
				}
			}

			@Override
			public void keyPressed(KeyEvent e) {
				synchronized (keysPressed) {
					char kc = e.getKeyChar();
					if (e.getKeyCode() == KeyEvent.VK_ENTER) {
						kc = (char) 13;
					}
					if (!keysPressed.contains(kc)) {
						if (!toIgnore.contains(e.getKeyCode())) {
							keysPressed.add(kc);
						}
					}
					ram[198] = keysPressed.size();
					if (inputMode) {
						switch (e.getKeyCode()) {
						case KeyEvent.VK_SHIFT:
							shiftDown = true;
							break;
						case KeyEvent.VK_ENTER:
							inputMode = false;
							cursorThread.interrupt();
							break;
						case KeyEvent.VK_BACK_SPACE:
							if (!shiftDown) {
								if (inputString.length() > 0) {
									if (insertPos == -1) {
										inputString.setLength(Math.max(0, inputString.length() - 1));
										pokeValue(getTextRamPos(), 32, TEXT_RAM);
										setCursor(cursorX - 1, cursorY);
										pokeValue(getTextRamPos(), 32, TEXT_RAM);
									} else {
										insertPos--;
										if (insertPos < 0) {
											insertPos = 0;
										} else {
											inputString.deleteCharAt(insertPos);
											setCursor(cursorX - 1, cursorY);
											shiftLeft();
											updateScreen();
										}
									}
								}
							} else {
								if (inputString.length() > 0) {
									if (insertPos != -1) {
										if (shiftRight()) {
											inputString.insert(insertPos, ' ');
										}
										updateScreen();
									}
								}
							}
							cursorThread.interrupt();
							break;
						case KeyEvent.VK_LEFT:
							if (insertPos == -1) {
								insertPos = inputString.length() - 1;
								setCursor(cursorX - 1, cursorY);
							} else {
								insertPos--;
								if (insertPos < 0) {
									insertPos = 0;
								} else {
									setCursor(cursorX - 1, cursorY);
								}
							}
							cursorThread.interrupt();
							break;
						case KeyEvent.VK_RIGHT:
							if (insertPos == -1) {
								inputString.append(' ');
								print(0, Character.toString(' '));
							} else {
								insertPos++;
								if (insertPos >= inputString.length()) {
									insertPos = -1;
								}
								setCursor(cursorX + 1, cursorY);
							}
							cursorThread.interrupt();
							break;
						default:
							break;
						}

					}
				}
			}

			@Override
			public void keyReleased(KeyEvent e) {
				synchronized (keysPressed) {
					char kc = e.getKeyChar();
					if (e.getKeyCode() == KeyEvent.VK_ENTER) {
						kc = (char) 13;
					}
					while (keysPressed.remove(kc)) {
						//
					}
					if (e.getKeyCode() == KeyEvent.VK_SHIFT) {
						shiftDown = false;
					}
				}
			}
		});

		screen = new BufferedImage(x, y, BufferedImage.TYPE_INT_ARGB);
		gscreen = screen.createGraphics();
		gscreen.setColor(new Color(color));
		gscreen.setRenderingHints(noAa);

		JLabel label = new JLabel();
		label.setIcon(new ImageIcon(screen));
		label.setPreferredSize(new Dimension(x, y));
		frame.add(label, BorderLayout.CENTER);
		frame.pack();

		if (clear) {
			clearScreen();
		}
		Font ft = loadFont("CommodoreServer.ttf", width);
		gscreen.setFont(ft);
		graphicsFontUsed = true;
		baseLine = width / 40;

		if (!clear) {
			updateScreen();
		}

		frame.setVisible(consoleType > 0);
	}

	private String createCharsetMapping() {
		StringBuilder sb = new StringBuilder();
		// Upper case mappings
		sb.append("@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_ !\"#$%&'()*+,-./0123456789:;<=>?`abcdefghijklmnopqrstuvwxyz{|}~");
		sb.append(" ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿");
		sb.append("ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ");
		for (int i = 0; i < 32; i++) {
			sb.append(Character.toString((char) (i + 128)));
		}
		sb.append(Character.toString((char) (224)));
		for (int i = 0; i < 31; i++) {
			sb.append(Character.toString((char) (i + 256)));
		}

		// Lower case mappings
		sb.append("@");
		for (int i = 0; i < 26; i++) {
			sb.append(Character.toString((char) (i + 287)));
		}
		sb.append("[\\]^_ !\"#$%&'()*+,-./0123456789:;<=>?`");
		sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		sb.append("{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿À");
		for (int i = 0; i < 26; i++) {
			sb.append(Character.toString((char) (i + 313)));
		}
		sb.append("ÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ");
		sb.append(Character.toString((char) (128)));
		sb.append("ÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚ");

		for (int i = 27; i < 32; i++) {
			sb.append(Character.toString((char) (i + 128)));
		}
		sb.append(Character.toString((char) (224)));
		for (int i = 0; i < 31; i++) {
			sb.append(Character.toString((char) (i + 256)));
		}

		sb.setCharAt(94 + 256, 'ą');
		sb.setCharAt(95 + 256, 'œ');
		sb.setCharAt(105 + 256, 'ŕ');
		sb.setCharAt(122 + 256, '');

		sb.setCharAt(94 + 128 + 256, '¦');
		sb.setCharAt(95 + 128 + 256, '');
		sb.setCharAt(105 + 128 + 256, 'ŕ');
		sb.setCharAt(122 + 128 + 256, '');
		
		return sb.toString();
	}

	/**
	 * Disposes this GraphicsDevice. It can't be accessed afterwards.
	 */
	public void dispose() {
		removeFromMap();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#print(int, java.lang.String)
	 */
	@Override
	public void print(int id, String txt) {
		print(txt, false);
		oldOutputChannel.print(id, txt);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#println(int, java.lang.String)
	 */
	@Override
	public void println(int id, String txt) {
		print(txt, true);
		oldOutputChannel.println(id, txt);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrint(int, java.lang.String)
	 */
	@Override
	public void systemPrint(int id, String txt) {
		oldOutputChannel.systemPrint(id, txt);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrintln(int, java.lang.String)
	 */
	@Override
	public void systemPrintln(int id, String txt) {
		oldOutputChannel.systemPrintln(id, txt);
	}

	@Override
	public int getCursor() {
		return cursorX;
	}

	@Override
	public void setCursor(int cursor) {
		cursorX = cursor;
	}

	@Override
	public void setPrintConsumer(PrintConsumer otherConsumer, int channel) {
		oldOutputChannel.setPrintConsumer(otherConsumer, channel);
	}

	@Override
	public PrintConsumer getPrintConsumer() {
		return oldOutputChannel.getPrintConsumer();
	}

	@Override
	public int getChannel() {
		return oldOutputChannel.getChannel();
	}

	@Override
	public void sys(int addr, Object... params) {
		oldSystemCallListener.sys(addr, params);
	}

	@Override
	public float usr(Object params) {
		return oldSystemCallListener.usr(params);
	}

	@Override
	public void poke(int addr, int value) {
		if (addr >= TEXT_RAM && addr <= TEXT_RAM + 999) {
			pokeChar(addr, value);
		} else if (addr >= COLOR_RAM && addr <= COLOR_RAM + 999) {
			pokeColor(addr, value);
		} else if (addr == 646) {
			color = value;
		} else if (addr == 199) {
			reverseMode = value != 0;
		} else if (addr == 53281) {
			bgColor = value;
			updateScreen();
		} else if (addr == 53272) {
			if (value == 23) {
				setCharset(false);
			} else if (value == 21) {
				setCharset(true);
			}
		} else if (addr == 198 && value == 0) {
			synchronized (keysPressed) {
				keysPressed.clear();
			}
		}

		oldMemoryListener.poke(addr, value);
	}

	@Override
	public Integer peek(int addr) {
		if (addr == 198) {
			return ram[addr];
		}
		return oldMemoryListener.peek(addr);
	}

	@Override
	public boolean wait(int addr, int value, int inverse) {
		if (addr == 198) {
			return ram[addr] != value;
		}
		return oldMemoryListener.wait(addr, value, inverse);
	}

	public BufferedImage getScreen() {
		return screen;
	}

	@Override
	public Character readKey() {
		synchronized (keysPressed) {
			Character chr = keysPressed.poll();
			return chr;
		}
	}

	@Override
	public String readString() {
		inputString.setLength(0);
		if (!frame.isVisible()) {
			return null;
		}

		insertPos = -1;
		inputMode = true;
		startCursor();

		while (inputMode) {
			try {
				Thread.sleep(5);
			} catch (Exception e) {
				//
			}
		}
		stopCursor();

		System.out.println("[" + inputString + "]");

		return inputString.toString();
	}

	/**
	 * Sets the used charset to either lower or not lower (i.e. upper) case.
	 * 
	 * @param isLower is it lower case?
	 */
	public void setFontMode(boolean isLower) {
		setCharset(!isLower);
		update();
	}

	/**
	 * Toggles the current charset between lower case and upper/grapchis characters
	 * mode.
	 */
	public void toggleFontMode() {
		setCharset(!this.graphicsFontUsed);
		update();
	}

	private void stopCursor() {
		cursorMode = false;
		while (cursorOn) {
			try {
				Thread.sleep(1);
			} catch (Exception e) {
				//
			}
		}
	}

	private void startCursor() {
		cursorOn = true;
		cursorMode = true;
		cursorThread = new Thread() {

			@Override
			public void run() {
				int lastVal = 0;

				while (cursorMode) {
					int addr = getTextRamPos();
					int val = ram[addr];
					lastVal = val;
					if (val < 128) {
						val += 128;
					} else {
						val -= 128;
					}
					renderValue(addr, val, TEXT_RAM);
					delay();
					if (val > 128) {
						val -= 128;
					} else {
						val += 128;
					}
					if (ram[addr] == lastVal) {
						renderValue(addr, val, TEXT_RAM);
					}
					delay();
				}
				cursorOn = false;
			}

			private void delay() {
				try {
					Thread.sleep(333);
				} catch (Exception e) {
					//
				}
			}
		};
		cursorThread.start();
	}

	private void setCharset(boolean graphics) {
		this.graphicsFontUsed = graphics;
		updateScreen();
	}

	private void updateScreen() {
		clearRect(0, 0, width, height, bgColor);
		synchronized (this) {
			for (int y = 0; y < 25; y++) {
				for (int x = 0; x < 40; x++) {
					updateChar(x, y, false);
				}
			}
		}
		update();

	}

	private void pokeChar(int addr, int value) {
		pokeValue(addr, value, TEXT_RAM);
	}

	private void pokeColor(int addr, int value) {
		pokeValue(addr, value, COLOR_RAM);
	}

	private void pokeValue(int addr, int value, int baseAddr) {
		int y = (int) (addr - baseAddr) / 40;
		int x = (addr - baseAddr) - y * 40;
		if (y < 25 && x < 40) {
			ram[addr] = value;
			updateChar(x, y, true);
			update();
		}
	}

	private void renderValue(int addr, int value, int baseAddr) {
		int y = (int) (addr - baseAddr) / 40;
		int x = (addr - baseAddr) - y * 40;
		if (y < 25 && x < 40) {
			int cw = width / 40;
			int xc = x * cw;
			int yc = y * cw;
			int offset = x + y * 40;
			clearRect(xc, yc, xc + cw, yc + cw, bgColor);
			getContext().setColor(colors[ram[COLOR_RAM + offset] & 15]);
			String ch = null;
			if (graphicsFontUsed) {
				ch = Character.toString(charset.charAt(value & 0xff));
			} else {
				ch = Character.toString(charset.charAt((value & 0xff) + 256));
			}
			getContext().drawString(ch, xc, yc + baseLine);
			update(xc - cw, yc - cw, cw * 3, cw * 3 + baseLine);
		}
	}

	private void updateChar(int x, int y, boolean clear) {
		int cw = width / 40;
		int xc = x * cw;
		int yc = y * cw;
		int offset = x + y * 40;
		if (clear) {
			clearRect(xc, yc, xc + cw, yc + cw, bgColor);
		}
		reallyPrintChar(offset, yc, xc);
	}

	private void printChar(char c) {
		int offset = cursorX + cursorY * 40;
		int cw = width / 40;
		int yc = cursorY * cw;
		int xc = cursorX * cw;
		int ci = getValueToPoke(c);
		ci += reverseMode ? 128 : 0;
		ram[TEXT_RAM + offset] = (int) (ci & 0xff);
		ram[COLOR_RAM + offset] = ram[646] & 15;
		clearRect(xc, yc, xc + cw, yc + cw, bgColor);
		reallyPrintChar(offset, yc, xc);
		setCursor(cursorX + 1, cursorY);
	}

	private void reallyPrintChar(int offset, int yc, int xc) {
		getContext().setColor(colors[ram[COLOR_RAM + offset] & 15]);
		String ch = null;
		if (graphicsFontUsed) {
			ch = Character.toString((charset.charAt(((ram[TEXT_RAM + offset])) & 0xff)));
		} else {
			ch = Character.toString((charset.charAt((((ram[TEXT_RAM + offset])) & 0xff) + 256)));
		}
		getContext().drawString(ch, xc, yc + baseLine);
	}

	private char getConvertedChar(char c) {
		System.out.println((int)c+"/"+reverseMode);
		if (c >= 'a' && c <= 'z') {
			c = (char) ((int) c - 32);
		} else if (c >= 'A' && c <= 'Z') {
			c = (char) ((int) c + 32);
		}
		// Issue #48
		if (c>=192 && c<=223) {
			c=(char)((int) c-96);
		}
		return c;
	}

	private int getValueToPoke(char c) {
		c = getConvertedChar(c);

		for (int i = 0; i < 512; i++) {
			char ct = charset.charAt(i);
			if (ct == c) {
				return i > 255 ? i - 256 : i;
			}
		}
		return 32;
	}

	private Font loadFont(String name, int width) {
		try {
			Font ft = Font.createFont(Font.TRUETYPE_FONT, this.getClass().getResourceAsStream("/" + name));
			return ft.deriveFont(width / 40f);
		} catch (Exception e) {
			throw new RuntimeException("Failed to load font: " + name, e);
		}
	}

	private void update() {
		frame.repaint();
	}

	private void update(int x, int y, int w, int h) {
		frame.repaint(x, y, w, h);
	}

	private Graphics2D getContext() {
		return gscreen;
	}

	private void clearRect(int x1, int y1, int x2, int y2, int color) {
		getContext().setColor(colors[color & 15]);
		getContext().fillRect(x1, y1, x2 - x1, y2 - y1);
	}

	private void setCursor(int x, int y) {
		synchronized (this) {
			cursorX = x;
			cursorY = y;

			if (cursorX > 39) {
				cursorX = 0;
				cursorY++;
			}

			if (cursorX < 0) {
				if (cursorY == 0) {
					cursorY = 0;
					cursorX = 0;
				} else {
					cursorX = 40 + cursorX;
					cursorY--;
				}
			}

			if (cursorY < 0) {
				cursorY = 0;
			}

			while (cursorY > 24) {
				cursorY--;
				scrollUp();
			}
			ram[211] = cursorX;
			ram[214] = cursorY;
		}

	}

	private void scrollUp() {
		for (int i = 40; i < 1000; i++) {
			ram[TEXT_RAM - 40 + i] = ram[TEXT_RAM + i];
			ram[COLOR_RAM - 40 + i] = ram[COLOR_RAM + i];
		}
		for (int i = 1000 - 40; i < 1000; i++) {
			ram[TEXT_RAM + i] = 32;
			ram[COLOR_RAM + i] = bgColor;
		}
		updateScreen();
	}

	private void clearScreen() {
		for (int i = 0; i < 1000; i++) {
			ram[TEXT_RAM + i] = 32;
			ram[COLOR_RAM + i] = color;
		}
		ram[53281] = bgColor;
		ram[646] = color;

		clearRect(0, 0, width, height, bgColor);
		setCursor(0, 0);
		update();
	}

	private int getTextRamPos() {
		return TEXT_RAM + cursorX + 40 * cursorY;
	}

	private void removeFromMap() {
		List<Machine> keys = new ArrayList<Machine>();
		for (Entry<Machine, ConsoleDevice> entry : machine2window.entrySet()) {
			if (entry.getValue() == this) {
				keys.add(entry.getKey());
				this.close();
			}
		}
		for (Machine machine : keys) {
			machine2window.remove(machine);
			machine.setMemoryListener(oldMemoryListener);
			machine.setSystemCallListener(oldSystemCallListener);
			machine.setOutputChannel(oldOutputChannel);
			machine.setInputProvider(oldInputProvider);
		}
	}

	private void close() {
		gscreen.dispose();
		frame.setVisible(false);
		frame.dispose();
	}

	private void print(String txt, boolean newLine) {
		int col = ram[646] % 0xff;
		for (int i = 0; i < txt.length(); i++) {
			char c = txt.charAt(i);
			switch ((int) c) {
			case 147:
				clearScreen();
				setCursor(0, 0);
				break;
			case 19:
				// clearScreen();
				setCursor(0, 0);
				break;
			case 29:
				setCursor(cursorX + 1, cursorY);
				break;
			case 157:
				setCursor(cursorX - 1, cursorY);
				break;
			case 17:
				setCursor(cursorX, cursorY + 1);
				break;
			case 145:
				setCursor(cursorX, cursorY - 1);
				break;
			case 144:
				col = 0;
				break;
			case 5:
				col = 1;
				break;
			case 28:
				col = 2;
				break;
			case 159:
				col = 3;
				break;
			case 156:
				col = 4;
				break;
			case 30:
				col = 5;
				break;
			case 31:
				col = 6;
				break;
			case 158:
				col = 7;
				break;
			case 129:
				col = 8;
				break;
			case 149:
				col = 9;
				break;
			case 150:
				col = 10;
				break;
			case 151:
				col = 11;
				break;
			case 152:
				col = 12;
				break;
			case 153:
				col = 13;
				break;
			case 154:
				col = 14;
				break;
			case 155:
				col = 15;
				break;
			case 18:
				reverseMode = true;
				break;
			case 146:
				reverseMode = false;
				break;
			case 20:
				setCursor(cursorX - 1, cursorY);
				clearAtCursor();
				break;
			case 148:
				shiftRight();
				clearAtCursor();
				updateScreen();
				break;
			case 13:
				reverseMode = false;
				setCursor(0, cursorY + 1);
				break;
			case 32:
				if (reverseMode) {
					setAtCursor();
				} else {
					clearAtCursor();
				}
				setCursor(cursorX + 1, cursorY);
				break;
			case 14:
				setCharset(false);
				break;
			case 142:
				setCharset(true);
				break;
			default:
				printChar(c);
				break;
			}
			ram[646] = col;
		}
		if (newLine) {
			reverseMode = false;
			setCursor(0, cursorY + 1);
		}
		update();
	}

	private boolean shiftRight() {
		synchronized (this) {
			int offset = cursorY * 40 + cursorX;
			int end = cursorY * 40 + (((cursorY & 1) == 1) ? 39 : 79);
			if (ram[TEXT_RAM + end] != 32) {
				return false;
			}
			for (int i = end; i > offset; i--) {
				ram[TEXT_RAM + i] = ram[TEXT_RAM + i - 1];
				ram[COLOR_RAM + i] = ram[COLOR_RAM + i - 1];
			}
			pokeValue(TEXT_RAM + offset, 32, TEXT_RAM);
			pokeValue(COLOR_RAM + offset, color, COLOR_RAM);
		}

		return true;
	}

	private void shiftLeft() {
		int i;
		synchronized (this) {
			int offset = cursorY * 40;
			for (i = cursorX + offset; i < (((cursorY & 1) == 1) ? 39 : 79) + offset; i++) {
				ram[TEXT_RAM + i] = ram[TEXT_RAM + i + 1];
				ram[COLOR_RAM + i] = ram[COLOR_RAM + i + 1];
			}
			pokeValue(TEXT_RAM + i, 32, TEXT_RAM);
			pokeValue(COLOR_RAM + i, color, COLOR_RAM);
		}
	}

	private void clearAtCursor() {
		int cw = width / 40;
		int y = cursorY * 40 * cw;
		int x = cursorX * cw;
		int pos = this.getTextRamPos() - TEXT_RAM;
		clearRect(x, y, x + cw, y + cw, bgColor);
		pokeValue(TEXT_RAM + pos, 32, TEXT_RAM);
		pokeValue(COLOR_RAM + pos, color, COLOR_RAM);
	}

	private void setAtCursor() {
		int cw = width / 40;
		int y = cursorY * 40 * cw;
		int x = cursorX * cw;
		int pos = this.getTextRamPos() - TEXT_RAM;
		clearRect(x, y, x + cw, y + cw, color);
		pokeValue(TEXT_RAM + pos, 160, TEXT_RAM);
		pokeValue(COLOR_RAM + pos, color, COLOR_RAM);
	}

	private class FontToggler implements KeyListener {

		private boolean pressed = false;

		@Override
		public void keyTyped(KeyEvent e) {
			//
		}

		@Override
		public void keyPressed(KeyEvent e) {
			if (e.isControlDown() && e.isShiftDown()) {
				if (!pressed) {
					toggleFontMode();
					pressed = true;
				}
			}
		}

		@Override
		public void keyReleased(KeyEvent e) {
			pressed = false;
		}
	}
}
