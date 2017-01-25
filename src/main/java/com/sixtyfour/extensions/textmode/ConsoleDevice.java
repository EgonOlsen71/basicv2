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
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Queue;
import java.util.WeakHashMap;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;

import com.sixtyfour.plugins.MemoryListener;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.PrintConsumer;
import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.Colors;


/**
 * @author EgonOlsen
 *
 */
public class ConsoleDevice
  implements OutputChannel, SystemCallListener, MemoryListener
{

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
  private RenderingHints noAa = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_OFF);
  private Queue<Character> keysPressed = new LinkedList<Character>();
  private SystemCallListener oldSystemCallListener = null;
  private MemoryListener oldMemoryListener = null;
  private OutputChannel oldOutputChannel = null;
  private int[] ram;
  private Color[] colors = new Color[Colors.COLORS.length];


  /**
   * Returns an existing device for machine. If there is none, null will be returned.
   * 
   * @param machine
   *          the machine
   * @return the device or null
   */
  public static ConsoleDevice getDevice(Machine machine)
  {
    return machine2window.get(machine);
  }


  /**
   * Opens a new device for a machine. If there is one already, that will be returned regardless of its size.
   * 
   * @param machine
   *          the machine
   * @param x
   *          the width
   * @param y
   *          the height
   * @return a GraphicsDevice instance for the machine
   */
  public static ConsoleDevice openDevice(Machine machine, int x, int y)
  {
    if (x <= 0)
    {
      x = 320;
    }
    if (y <= 0)
    {
      y = 200;
    }
    ConsoleDevice window = machine2window.get(machine);
    if (window == null)
    {
      window = new ConsoleDevice(machine, x, y);
      machine2window.put(machine, window);
    }
    return window;
  }


  private ConsoleDevice(Machine machine, int x, int y)
  {
    System.setProperty("sun.java2d.d3d", "false");
    width = x;
    height = y;

    charset = createCharsetMapping();

    charset = charset
        + "                                                                                                                                                                                 ";

    oldSystemCallListener = machine.getSystemCallListener();
    oldMemoryListener = machine.getMemoryListener();
    oldOutputChannel = machine.getOutputChannel();

    ram = machine.getRam();

    for (int i = 0; i < Colors.COLORS.length; i++)
    {
      colors[i] = new Color(Colors.COLORS[i]);
    }

    machine.setSystemCallListener(this);
    machine.setMemoryListener(this);
    machine.setOutputChannel(this);

    frame = new JFrame("Console " + x + "*" + y);
    frame.setLayout(new BorderLayout());
    frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
    frame.addWindowStateListener(new WindowStateListener()
    {
      @Override
      public void windowStateChanged(WindowEvent e)
      {
        if (e.getNewState() == WindowEvent.WINDOW_CLOSING)
        {
          removeFromMap();
        }
      }
    });

    frame.addKeyListener(new KeyListener()
    {
      @Override
      public void keyTyped(KeyEvent e)
      {
        //
      }


      @Override
      public void keyPressed(KeyEvent e)
      {
        synchronized (keysPressed)
        {
          if (!keysPressed.contains(e.getKeyChar()))
          {
            keysPressed.add(e.getKeyChar());
          }
        }
      }


      @Override
      public void keyReleased(KeyEvent e)
      {
        synchronized (keysPressed)
        {
          while (keysPressed.remove(e.getKeyChar()))
          {
            //
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

    clearScreen();
    Font ft = loadFont("CommodoreServer.ttf", width);
    gscreen.setFont(ft);
    baseLine = width / 40;

    frame.setVisible(true);
  }


  private String createCharsetMapping()
  {
    StringBuilder sb = new StringBuilder();
    sb.append("@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_ !\"#$%&'()*+,-./0123456789:;<=>?`abcdefghijklmnopqrstuvwxyz{|}~");
    sb.append(" ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿");
    sb.append("ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ");
    for (int i = 0; i < 32; i++)
    {
      sb.append(Character.toString((char) (i + 128)));
    }
    sb.append(Character.toString((char) (224)));
    for (int i = 0; i < 31; i++)
    {
      sb.append(Character.toString((char) (i + 256)));
    }

    return sb.toString();
  }


  /**
   * Disposes this GraphicsDevice. It can't be accessed afterwards.
   */
  public void dispose()
  {
    removeFromMap();
  }


  /*
   * (non-Javadoc)
   * @see com.sixtyfour.plugins.PrintConsumer#print(int, java.lang.String)
   */
  @Override
  public void print(int id, String txt)
  {
    oldOutputChannel.print(id, txt);
  }


  /*
   * (non-Javadoc)
   * @see com.sixtyfour.plugins.PrintConsumer#println(int, java.lang.String)
   */
  @Override
  public void println(int id, String txt)
  {
    oldOutputChannel.println(id, txt);
    setCursor(0, cursorY+1);
  }


  /*
   * (non-Javadoc)
   * @see com.sixtyfour.plugins.PrintConsumer#systemPrint(int, java.lang.String)
   */
  @Override
  public void systemPrint(int id, String txt)
  {
    oldOutputChannel.systemPrint(id, txt);
  }


  /*
   * (non-Javadoc)
   * @see com.sixtyfour.plugins.PrintConsumer#systemPrintln(int, java.lang.String)
   */
  @Override
  public void systemPrintln(int id, String txt)
  {
    oldOutputChannel.systemPrintln(id, txt);
  }


  @Override
  public int getCursor()
  {
    return cursorX;
  }


  @Override
  public void setCursor(int cursor)
  {
    cursorX=cursor;
  }


  @Override
  public void setPrintConsumer(PrintConsumer otherConsumer, int channel)
  {
    oldOutputChannel.setPrintConsumer(otherConsumer, channel);
  }


  @Override
  public PrintConsumer getPrintConsumer()
  {
    return oldOutputChannel.getPrintConsumer();
  }


  @Override
  public int getChannel()
  {
    return oldOutputChannel.getChannel();
  }


  @Override
  public void sys(int addr, Object... params)
  {
    oldSystemCallListener.sys(addr, params);
  }


  @Override
  public float usr(Object params)
  {
    return oldSystemCallListener.usr(params);
  }


  @Override
  public void poke(int addr, int value)
  {
    if (addr >= TEXT_RAM && addr <= TEXT_RAM+999)
    {
      pokeChar(addr, value);
    }

    if (addr >= COLOR_RAM && addr <= COLOR_RAM+999)
    {
      pokeColor(addr, value);
    }

    if (addr == 646)
    {
      color = value;
    }
    if (addr == 53281)
    {
      bgColor = value;
      updateScreen();
    }

    oldMemoryListener.poke(addr, value);
  }


  @Override
  public Integer peek(int addr)
  {
    return oldMemoryListener.peek(addr);
  }


  @Override
  public boolean wait(int addr, int value, int inverse)
  {
    return oldMemoryListener.wait(addr, value, inverse);
  }


  private void updateScreen()
  {
    clearRect(0, 0, width, height, bgColor);
    for (int y = 0; y < 25; y++)
    {
      for (int x = 0; x < 40; x++)
      {
        updateChar(x, y, false);
      }
    }
    update();
  }


  private void pokeChar(int addr, int value)
  {
    pokeValue(addr, value, TEXT_RAM);
  }


  private void pokeColor(int addr, int value)
  {
    pokeValue(addr, value, COLOR_RAM);
  }


  private void pokeValue(int addr, int value, int baseAddr)
  {
    int y = (int) (addr - baseAddr) / 40;
    int x = (addr - baseAddr) - y * 40;
    if (y < 25 && x < 40)
    {
      ram[addr] = value;
      updateChar(x, y, true);
      update();
    }
  }


  private void updateChar(int x, int y, boolean clear)
  {
    int cw = width / 40;
    int xc = x * cw;
    int yc = y * cw;
    int offset = x + y * 40;
    if (clear)
    {
      clearRect(xc, yc, xc + cw, yc + cw, bgColor);
    }
    getContext().setColor(colors[ram[COLOR_RAM + offset] & 15]);
    String ch = Character.toString((charset.charAt((ram[TEXT_RAM + offset]) & 0xff)));
    getContext().drawString(ch, xc, yc + baseLine);
  }


  private Font loadFont(String name, int width)
  {
    try
    {
      Font ft = Font.createFont(Font.TRUETYPE_FONT, this.getClass().getResourceAsStream("/" + name));
      return ft.deriveFont(width / 40f);
    }
    catch (Exception e)
    {
      throw new RuntimeException("Failed to load font: " + name, e);
    }
  }


  private void update()
  {
    frame.repaint();
  }


  private Graphics2D getContext()
  {
    return gscreen;
  }


  private void clearRect(int x1, int y1, int x2, int y2, int color)
  {
    getContext().setColor(colors[color & 15]);
    getContext().fillRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1);
  }


  private void setCursor(int x, int y)
  {
    ram[211] = x;
    ram[214] = y;
    cursorX = x;
    cursorY = y;
    
    while (cursorY>24) {
      cursorY--;
      scrollUp();
    }
  }


  private void scrollUp()
  {
    for (int i=40; i<1000; i++) {
      ram[TEXT_RAM-40+i]=ram[TEXT_RAM+i];
      ram[COLOR_RAM-40+i]=ram[COLOR_RAM+i];
    }
    updateScreen();
  }


  private void clearScreen()
  {
    for (int i = 0; i < 1000; i++)
    {
      ram[TEXT_RAM + i] = 32;
      ram[COLOR_RAM + i] = color;
    }
    ram[53281] = bgColor;
    ram[646] = color;

    clearRect(0, 0, width, height, bgColor);
    setCursor(0, 0);
    update();
  }


  private void removeFromMap()
  {
    List<Machine> keys = new ArrayList<Machine>();
    for (Entry<Machine, ConsoleDevice> entry : machine2window.entrySet())
    {
      if (entry.getValue() == this)
      {
        keys.add(entry.getKey());
        this.close();
      }
    }
    for (Machine machine : keys)
    {
      machine2window.remove(machine);
      machine.setMemoryListener(oldMemoryListener);
      machine.setSystemCallListener(oldSystemCallListener);
      machine.setOutputChannel(oldOutputChannel);
    }
  }


  private void close()
  {
    gscreen.dispose();
    frame.setVisible(false);
    frame.dispose();
  }
}
