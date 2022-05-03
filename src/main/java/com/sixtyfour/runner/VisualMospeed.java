package com.sixtyfour.runner;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.UIManager;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import javax.swing.text.PlainDocument;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.javascript.PlatformJs;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.cbmnative.mos6502.vic20.Platform20;
import com.sixtyfour.cbmnative.mos6502.x16.PlatformX16;
import com.sixtyfour.cbmnative.powerscript.PlatformPs;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.extensions.x16.X16Extensions;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.parser.cbmnative.UnTokenizer;
import com.sixtyfour.system.FileWriter;
import com.sixtyfour.system.ProgramPart;

/**
 * A simple UI that allows for compiling BASIC programs from the desktop.
 * 
 * @author EgonOlsen
 *
 */
public class VisualMospeed {

	private JFrame frame;
	private JPanel panel;
	private JButton load;
	private JButton compile;
	private int selectedTarget = 0;
	private JComboBox<String> target;
	private JPanel box;
	private JLabel targetLabel;
	private PlatformProvider platform = null;
	private String appendix = ".prg";
	private File file;

	private String[] code;
	private File lastDir;
	private long fileDate;

	/**
	 * The main method. Just run this without any parameters.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		new VisualMospeed();
	}

	/**
	 * Creates a new visual compiler.
	 */
	public VisualMospeed() {
		setup();
	}

	private void setup() {
		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) {
			//
		}

		frame = new JFrame("MOSpeed - Visual Compiler");
		frame.setLayout(new BorderLayout());
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		panel = new JPanel();
		panel.setLayout(new GridLayout(1, 2, 15, 15));

		load = new JButton();
		load.setText("LOAD");
		load.setActionCommand("load");
		load.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if ("load".equals(e.getActionCommand())) {
					loadProgram();
				}
			}
		});

		compile = new JButton();
		compile.setText("COMPILE");
		compile.setEnabled(false);
		compile.setActionCommand("compile");
		compile.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if ("compile".equals(e.getActionCommand())) {
					compile();
				}
			}
		});

		target = new JComboBox<String>(new String[] { "C64", "VIC20", "X16", "Javascript", "Powershell" });
		target.setToolTipText("Select target platform!");
		target.addActionListener((e) -> {
			selectedTarget = target.getSelectedIndex();
		});

		targetLabel = new JLabel("Select target platform:");
		box = new JPanel();
		box.setLayout(new BoxLayout(box, BoxLayout.PAGE_AXIS));
		box.add(targetLabel);
		box.add(target);

		panel.add(box);
		panel.add(load);
		panel.add(compile);

		frame.add(panel);
		frame.pack();
		frame.setSize(640, 80);
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);

	}

	private void compile() {

		if (file != null && fileDate != 0) {
			if (file.lastModified() > fileDate) {
				Logger.log("File has changed, reloading...");
				load(file);
			}
		}

		compile.setEnabled(false);
		load.setEnabled(false);
		target.setEnabled(false);
		new Thread() {
			public void run() {
				compileInternal();
			}
		}.start();
	}

	private void compileInternal() {
		try {
			JFrame outFrame;

			outFrame = new JFrame("MOSpeed - console output");
			outFrame.setLayout(new BorderLayout());
			outFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

			Document doc = new PlainDocument();

			JTextArea textArea = new JTextArea(40, 80);
			JScrollPane scrollPane = new JScrollPane(textArea);
			outFrame.setPreferredSize(new Dimension(800, 600));
			outFrame.setSize(new Dimension(800, 600));
			outFrame.add(scrollPane, BorderLayout.CENTER);
			textArea.setDocument(doc);
			outFrame.setVisible(true);

			ByteArrayOutputStream logStream = new ByteArrayOutputStream();
			PrintStream consolePs = new PrintStream(logStream) {
				@Override
				public void println(String x) {
					try {
						doc.insertString(doc.getLength(), x + "\n", null);
						scrollDown(textArea);
					} catch (BadLocationException e) {
						//
					}
				}

				@Override
				public void print(String x) {
					try {
						doc.insertString(doc.getLength(), x, null);
						scrollDown(textArea);
					} catch (BadLocationException e) {
						//
					}
				}

				@Override
				public void println() {
					try {
						doc.insertString(doc.getLength(), "\n", null);
						scrollDown(textArea);
					} catch (BadLocationException e) {
						//
					}
				}

				private void scrollDown(JTextArea textArea) {
					try {
						textArea.setCaretPosition(textArea.getDocument().getLength());
					} catch (Exception e) {
						// Pffft...
					}
				}
			};

			DotPrintingProgressListener dpl = new DotPrintingProgressListener(consolePs);
			Logger.setPrintStream(consolePs);

			CompilerConfig conf = new CompilerConfig();
			MemoryConfig memConfig = new MemoryConfig();
			setPlatform(conf);

			Basic basic = new Basic(code);
			try {
				Logger.log("Checking source file...");
				basic.compile(conf);
			} catch (Exception e) {
				Logger.log("\n!!! Error compiling BASIC program: " + e.getMessage());
				return;
			}

			conf.setProgressListener(dpl);
			List<String> nCode = null;
			NativeCompiler nComp = NativeCompiler.getCompiler();
			try {
				nCode = nComp.compile(conf, basic, memConfig, platform);
			} catch (Exception e) {
				Logger.log("\n!!! Error compiling: " + e.getMessage());
				String ll=nComp.getLastProcessedLine();
				if (ll!=null) {
					Logger.log("Error at: " + ll);
				}
				return;
			}

			Assembler assy = null;
			if (is6502Platform(platform)) {
				assy = new Assembler(nCode);
				try {
					assy.compile(conf);
				} catch (Exception e) {
					Logger.log("\n!!! Error running assembler: " + e.getMessage());
					return;
				}
			}

			Logger.log("\nREADY!");

			String targetFile = "++"
					+ file.getName().replace(".BAS", "").replace(".bas", "").replace(".prg", "").replace(".PRG", "")
					+ appendix;
			File file = saveProgram(targetFile);
			if (file != null) {
				writeTargetFiles(memConfig, file, nCode, assy, platform);
			} else {
				Logger.log("No file selected, nothing saved!");
			}

		} catch (Exception e) {
			Logger.log(e);
		} finally {
			compile.setEnabled(true);
			load.setEnabled(true);
			target.setEnabled(true);
		}
	}

	private void writeTargetFiles(MemoryConfig memConfig, File targetFile, List<String> ncode, Assembler assy,
			PlatformProvider platform) {
		if (is6502Platform(platform)) {
			write6502(memConfig, targetFile, assy, platform);
			// Check out of memory on write time
			int se = memConfig.getStringEnd();
			if (se <= 0) {
				se = platform.getBasicMemoryEndAddress();
			}
			if (se >= 0) {
				ProgramPart part0 = assy.getProgram().getParts().get(0);
				if (part0.getAddress() <= se && part0.getEndAddress() > se) {
					Logger.log("\nWARNING: Compiled program's length exceeds memory limit: "
							+ (part0.getEndAddress() + ">" + se));
				}
			}
		} else if (platform instanceof PlatformJs) {
			writeJavascript(targetFile, ncode);
		} else if (platform instanceof PlatformPs) {
			writePowershell(targetFile, ncode);
		} else {
			Logger.log("\n!!! Unsupported platform: " + platform);
			return;
		}
	}

	private void writePowershell(File targetFile, List<String> ncode) {
		try (PrintWriter pw = new PrintWriter(targetFile)) {
			Logger.log("Writing target file: " + targetFile);
			for (String line : ncode) {
				pw.println(line);
			}
		} catch (Exception e) {
			Logger.log("Failed to write target file '" + targetFile + "': " + e.getMessage());
			return;
		}
	}

	private void writeJavascript(File targetFile, List<String> ncode) {
		Transformer trsn = new PlatformJs().getTransformer();
		try (PrintWriter pw = new PrintWriter(targetFile);
				PrintWriter cpw = new PrintWriter(targetFile.getPath().replace(".js", ".html"))) {
			Logger.log("Writing target files: " + targetFile);
			for (String line : ncode) {
				pw.println(line);
			}
			String[] parts = targetFile.getPath().replace("\\", "/").split("/");
			for (String line : trsn.createCaller(parts[parts.length - 1])) {
				cpw.println(line);
			}
		} catch (Exception e) {
			Logger.log("Failed to write target file '" + targetFile + "': " + e.getMessage());
			return;
		}
	}

	private void write6502(MemoryConfig memConfig, File targetFile, Assembler assy, PlatformProvider platform) {
		try {
			Logger.log("Writing target file: " + targetFile);
			FileWriter.writeAsPrg(assy.getProgram(), targetFile.getPath(),
					memConfig.getProgramStart() == -1 || (memConfig.getProgramStart() < platform.getMaxHeaderAddress()
							&& memConfig.getProgramStart() >= platform.getBaseAddress() + 23),
					platform.getBaseAddress(), true);
		} catch (Exception e) {
			Logger.log("Failed to write target file '" + targetFile + "': " + e.getMessage());
			return;
		}
	}

	private void setPlatform(CompilerConfig conf) {
		switch (selectedTarget) {
		case 0:
			platform = new Platform64();
			appendix = ".prg";
			break;
		case 1:
			platform = new Platform20();
			appendix = ".prg";
			break;
		case 2:
			platform = new PlatformX16();
			Basic.registerExtension(new X16Extensions());
			conf.setNonDecimalNumbersAware(true);
			conf.setConvertStringToLower(true);
			appendix = ".prg";
			break;
		case 3:
			platform = new PlatformJs();
			appendix = ".js";
			break;
		case 4:
			platform = new PlatformPs();
			appendix = ".ps1";
		}
	}

	private boolean is6502Platform(PlatformProvider platform) {
		return platform instanceof Platform64 || platform instanceof Platform20 || platform instanceof PlatformX16;
	}

	private void loadProgram() {
		JFileChooser fc = new JFileChooser();
		if (lastDir != null) {
			fc.setCurrentDirectory(lastDir);
		}
		int ret = fc.showOpenDialog(frame);
		if (ret == JFileChooser.CANCEL_OPTION || ret == JFileChooser.ERROR_OPTION) {
			compile.setEnabled(code != null && code.length > 0);
			return;
		}
		load(fc.getSelectedFile());
	}

	private void load(File file) {
		this.file = file;
		fileDate = file.lastModified();

		String srcFile = file.toString();
		code = null;

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
		}

		if (code == null) {
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
		compile.setEnabled(true);
		frame.setTitle(file.getName());
	}

	private File saveProgram(String targetFile) {
		Logger.log("Select file to save!");
		JFileChooser fc = new JFileChooser();
		if (lastDir != null) {
			fc.setCurrentDirectory(lastDir);
		}
		File f = new File(lastDir, targetFile);
		fc.setSelectedFile(f);
		int ret = fc.showSaveDialog(frame);
		if (ret == JFileChooser.CANCEL_OPTION || ret == JFileChooser.ERROR_OPTION) {
			compile.setEnabled(code != null && code.length > 0);
			return null;
		}
		File file = fc.getSelectedFile();
		if (file.isFile()) {
			boolean ok = file.delete();
			if (!ok) {
				Logger.log("Failed to delete file: " + file);
			}
		}
		return file;
	}

	private static class DotPrintingProgressListener implements ProgressListener {

		private PrintStream ps = null;
		private int cnt = 0;

		public DotPrintingProgressListener(PrintStream ps) {
			this.ps = ps;
		}

		@Override
		public void nextStep() {
			ps.print("*");
			cnt++;
			if (cnt >= 80) {
				cnt = 0;
				ps.println();
			}
		}

		@Override
		public void start() {
			//
		}

		@Override
		public void done() {
			ps.println();
		}

	}

}
