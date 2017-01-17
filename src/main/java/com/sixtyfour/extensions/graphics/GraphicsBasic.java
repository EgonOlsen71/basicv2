package com.sixtyfour.extensions.graphics;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.extensions.BasicExtension;
import com.sixtyfour.extensions.graphics.commands.Circle;
import com.sixtyfour.extensions.graphics.commands.Clear;
import com.sixtyfour.extensions.graphics.commands.Color;
import com.sixtyfour.extensions.graphics.commands.Fill;
import com.sixtyfour.extensions.graphics.commands.FillMode;
import com.sixtyfour.extensions.graphics.commands.Groff;
import com.sixtyfour.extensions.graphics.commands.Gron;
import com.sixtyfour.extensions.graphics.commands.Gsave;
import com.sixtyfour.extensions.graphics.commands.Line;
import com.sixtyfour.extensions.graphics.commands.Plot;
import com.sixtyfour.extensions.graphics.commands.Rect;

/**
 * A basic BASIC extension, that adds some simple graphics commands. Note that
 * these graphics are not C64 related, but make full use of the actual machine's
 * capabilities on which your program is running on.
 * 
 * @author EgonOlsen
 * 
 */
public class GraphicsBasic implements BasicExtension {

	private final static List<Command> COMMANDS = Collections.unmodifiableList(new ArrayList<Command>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new Gron());
			this.add(new Groff());
			this.add(new Line());
			this.add(new Color());
			this.add(new Plot());
			this.add(new Circle());
			this.add(new FillMode());
			this.add(new Rect());
			this.add(new Clear());
			this.add(new Fill());
			this.add(new Gsave());
		}
	});

	@Override
	public List<Command> getCommands() {
		return COMMANDS;
	}

	@Override
	public List<Function> getFunctions() {
		return null;
	}

}
