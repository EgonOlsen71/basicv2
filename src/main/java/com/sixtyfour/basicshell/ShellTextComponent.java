package com.sixtyfour.basicshell;

import static java.awt.Toolkit.getDefaultToolkit;
import static java.awt.datatransfer.DataFlavor.stringFlavor;

import java.awt.Color;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.dnd.DnDConstants;
import java.awt.dnd.DropTarget;
import java.awt.dnd.DropTargetAdapter;
import java.awt.dnd.DropTargetDropEvent;
import java.io.File;
import java.util.List;

import javax.swing.JTextArea;
import javax.swing.text.DefaultCaret;

import com.sixtyfour.util.Colors;

/**
 * @author nietoperz809
 */
class ShellTextComponent extends JTextArea {
	private static final long serialVersionUID = 1L;
	private final BasicShell parent;

	public ShellTextComponent(BasicShell sf) {
		parent = sf;
		setBackground(new Color(Colors.COLORS[6]));
		setDoubleBuffered(true);
		setForeground(new Color(Colors.COLORS[14]));
		setCaretColor(new Color(Colors.COLORS[14]));
		setToolTipText("<html>Type one of:<br>" + "- cls<br>- list<br>- run<br>- new<br>"
				+ "- save[file]<br>- load[file]<br>- compile[file]<br>- dir<br>"
				+ "or edit your BASIC code here</html>");
		BlockCaret mc = new BlockCaret();
		mc.setUpdatePolicy(DefaultCaret.ALWAYS_UPDATE);
		setCaret(mc);
		setFont(ResourceLoader.getFont());
		new DropTarget(this, new DropTargetAdapter() {
			@Override
			public void drop(DropTargetDropEvent event) {
				event.acceptDrop(DnDConstants.ACTION_COPY);
				Transferable transferable = event.getTransferable();
				DataFlavor[] flavors = transferable.getTransferDataFlavors();
				for (DataFlavor flavor : flavors) {
					try {
						if (flavor.isFlavorJavaFileListType()) {
							@SuppressWarnings("unchecked")
							List<File> files = (List<File>) transferable.getTransferData(flavor);
							File f = files.get(0);
							parent.getStore().load(f.getPath());
							parent.putStringUCase("Loaded: " + f.getName() + "\n" + ProgramStore.OK);
							return; // only one file
						}
					} catch (Exception e) {
						parent.putString(ProgramStore.ERROR);
					}
				}
			}
		});
	}

	@Override
	public void paste() {
		try {
			String[] lines = getClipBoardString().split("[\r\n]+");
			for (String s : lines) {
				parent.getStore().insert(s.trim());
			}
			parent.putStringUCase("" + lines.length + " lines pasted\n" + ProgramStore.OK);
		} catch (Exception e) {
			parent.putString(ProgramStore.ERROR);
			e.printStackTrace();
		}
	}

	private static String getClipBoardString() throws Exception {
		Clipboard clipboard = getDefaultToolkit().getSystemClipboard();
		Transferable clipData = clipboard.getContents(clipboard);
		if (clipData != null) {
			if (clipData.isDataFlavorSupported(stringFlavor)) {
				return (String) (clipData.getTransferData(stringFlavor));
			}
		}
		throw new Exception("no clpboard data");
	}
}
