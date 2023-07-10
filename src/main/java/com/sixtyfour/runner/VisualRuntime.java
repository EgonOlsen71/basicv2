package com.sixtyfour.runner;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.Locale;

import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.UIManager;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.extensions.graphics.GraphicsBasic;
import com.sixtyfour.extensions.textmode.ConsoleSupport;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.parser.cbmnative.UnTokenizer;
import com.sixtyfour.plugins.CodeEnhancer;
import com.sixtyfour.plugins.impl.FileDeviceProvider;
import com.sixtyfour.plugins.impl.RamSystemCallListener;

/**
 * A simple UI class that allows for starting BASIC programs from the desktop.
 * It can load, run, stop and pause BASIC programs. It uses the CONSOLE
 * extension to automatically display a program's output in the console
 * emulation. It also registers the GRAPHICS extention and adds the C64 ROMS to
 * the internal machines memory.
 * 
 * @author EgonOlsen
 * 
 */
public class VisualRuntime {

	private JFrame frame;
	private JPanel panel;
	private JButton load;
	private JButton run;
	private JButton pause;
	private boolean diskUsage=false;

	private Basic basic;
	private String[] code;
	private File lastDir;
	private CompilerConfig config = new CompilerConfig();

	/**
	 * The main method. Just run this without any parameters.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		new VisualRuntime(args!=null && args.length>0 && args[0].equals("-disc"));
	}

	/**
	 * Creates a new visual runtime.
	 */
	public VisualRuntime(boolean useDiskEmulation) {
		setup();
		diskUsage = useDiskEmulation;
	}

	private void setup() {
		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) {
			//
		}

		frame = new JFrame("BASIC V2 - Visual Runtime");
		frame.setLayout(new BorderLayout());
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		panel = new JPanel();
		panel.setLayout(new GridLayout(1, 3, 15, 15));

		load = new JButton();
		load.setText("LOAD");
		load.setActionCommand("load");
		load.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if ("load".equals(e.getActionCommand())) {
					terminate();
					loadProgram();
				}
			}
		});

		run = new JButton();
		run.setText("RUN");
		run.setEnabled(false);
		run.setActionCommand("run");
		run.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if ("run".equals(e.getActionCommand())) {
					if (basic == null) {
						runProgram();
					} else {
						stopProgram();
					}
				}
			}
		});

		pause = new JButton();
		pause.setText("RESUME");
		pause.setEnabled(false);
		pause.setActionCommand("pause");
		pause.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if ("pause".equals(e.getActionCommand())) {
					if (basic != null) {
						basic.setPause(true);
						pause.setActionCommand("resume");
						pause.setText("RESUME");
					}
				}
				if ("resume".equals(e.getActionCommand())) {
					if (basic != null) {
						basic.setPause(false);
						pause.setActionCommand("pause");
						pause.setText("PAUSE");
					}
				}
			}
		});

		panel.add(load);
		panel.add(run);
		panel.add(pause);

		frame.add(panel);
		frame.pack();
		frame.setSize(480, 80);
		frame.setLocationRelativeTo(null);
		pause.setText("PAUSE");
		frame.setVisible(true);

		Basic.registerExtension(ConsoleSupport.class);
		Basic.registerExtension(GraphicsBasic.class);
	}

	public void stopProgram() {
		if (basic != null) {
			basic.runStop();
			basic = null;
		}
		run.setText("RUN");
		run.setEnabled(true);
		pause.setText("PAUSE");
		pause.setEnabled(false);
		pause.setActionCommand("pause");
	}

	public void runProgram() {
		run.setText("STOP");
		pause.setText("PAUSE");
		run.setEnabled(true);
		pause.setEnabled(true);
		pause.setActionCommand("pause");

		new Thread() {
			public void run() {
				basic = new Basic(code);
				basic.getMachine().addRoms();
				if (diskUsage) {
					basic.getMachine().setDeviceProvider(new FileDeviceProvider(basic.getMachine().getOutputChannel(), lastDir.getAbsolutePath()));
				}
				basic.setSystemCallListener(new RamSystemCallListener(basic.getMachine()));
				basic.setCodeEnhancer(new CodeEnhancer() {
					@Override
					public String getFirstCommand() {
						return "CONSOLE1";
					}

					@Override
					public String getLastCommand() {
						JOptionPane.showMessageDialog(frame, "Program terminated, click OK to close console output!");
						return "CONSOLE0";
					}
				});
				try {
					basic.run(config);
				} catch (Exception e) {
					e.printStackTrace();
					JOptionPane.showMessageDialog(frame, "ERROR: " + e.getMessage());
				} finally {
					stopProgram();
				}
			}
		}.start();
	}

	public void terminate() {
		if (basic != null) {
			basic.runStop();
			basic = null;
		}
		run.setEnabled(false);
		pause.setEnabled(false);
		run.setText("RUN");
		pause.setText("PAUSE");
		pause.setActionCommand("pause");
	}

	public void loadProgram() {
		run.setText("RUN");
		JFileChooser fc = new JFileChooser();
		if (lastDir != null) {
			fc.setCurrentDirectory(lastDir);
		}
		int ret = fc.showOpenDialog(frame);
		if (ret == JFileChooser.CANCEL_OPTION || ret == JFileChooser.ERROR_OPTION) {
			run.setEnabled(code != null && code.length > 0);
			return;
		}
		File file = fc.getSelectedFile();
		String srcFile = file.getAbsolutePath();
		
		if (srcFile.toLowerCase(Locale.ENGLISH).endsWith(".prg")) {
			try {
				Logger.log("Looks like a PRG file, trying to convert it...");
				byte[] data = Loader.loadBlob(srcFile);
				UnTokenizer unto = new UnTokenizer();
				code = unto.getText(data, true).toArray(new String[0]);
				Logger.log("PRG file converted into ASCII, proceeding!");
				srcFile = srcFile.replace(".prg", ".bas");
			} catch (Exception e) {
				Logger.log("Failed to convert PRG file: " + e.getMessage());
				Logger.log("Proceeding as if it was ASCII instead!");
			}
		} else {
			code = Loader.loadProgram(srcFile);
		}
		
		lastDir = file.getParentFile();
		for (String line : code) {
			line = line.trim();
			if (!line.isEmpty()) {
				if (!Character.isDigit(line.charAt(0))) {
					code = Preprocessor.convertToLineNumbers(code);
					JOptionPane.showMessageDialog(frame, "Program converted from labels to line numbers!");
				}
			}
			break;
		}
		code = Preprocessor.convertSpecialChars(code);
		run.setEnabled(true);
		frame.setTitle(file.getName());
	}
}
