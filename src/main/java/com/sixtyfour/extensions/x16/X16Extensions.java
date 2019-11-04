package com.sixtyfour.extensions.x16;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.extensions.BasicExtension;
import com.sixtyfour.extensions.x16.commands.Char;
import com.sixtyfour.extensions.x16.commands.Dos;
import com.sixtyfour.extensions.x16.commands.Frame;
import com.sixtyfour.extensions.x16.commands.Geos;
import com.sixtyfour.extensions.x16.commands.Line;
import com.sixtyfour.extensions.x16.commands.Mon;
import com.sixtyfour.extensions.x16.commands.Mouse;
import com.sixtyfour.extensions.x16.commands.Old;
import com.sixtyfour.extensions.x16.commands.Pset;
import com.sixtyfour.extensions.x16.commands.Rect;
import com.sixtyfour.extensions.x16.commands.Screen;
import com.sixtyfour.extensions.x16.commands.Vload;
import com.sixtyfour.extensions.x16.commands.Vpoke;
import com.sixtyfour.extensions.x16.commands.Xload;
import com.sixtyfour.extensions.x16.functions.Vpeek;
import com.sixtyfour.extensions.x16.systemvars.Mb;
import com.sixtyfour.extensions.x16.systemvars.Mx;
import com.sixtyfour.extensions.x16.systemvars.My;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 *
 */
public class X16Extensions implements BasicExtension {

	private final static List<Command> COMMANDS = Collections.unmodifiableList(new ArrayList<Command>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new Vpoke());
			this.add(new Dos());
			this.add(new Mon());
			this.add(new Vload());
			this.add(new Xload());
			this.add(new Geos());
			this.add(new Old());
			this.add(new Screen());
			this.add(new Mouse());
			this.add(new Pset());
			this.add(new Line());
			this.add(new Frame());
			this.add(new Rect());
			this.add(new Char());
		}
	});

	private final static List<Function> FUNCTIONS = Collections.unmodifiableList(new ArrayList<Function>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new Vpeek());
		}
	});

	private final static List<Variable> VARS = Collections.unmodifiableList(new ArrayList<Variable>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new Mx());
			this.add(new My());
			this.add(new Mb());
		}
	});

	@Override
	public List<Command> getCommands() {
		return COMMANDS;
	}

	@Override
	public List<Function> getFunctions() {
		return FUNCTIONS;
	}

	@Override
	public void reset(Machine machine) {
		//
	}

	@Override
	public List<String> getAdditionalIncludes() {
		return new ArrayList<String>() {
			private static final long serialVersionUID = 1L;
			{
				this.add("x16");
			}
		};
	}

	@Override
	public Map<String, Integer> getLabel2Constant() {
		return new HashMap<String, Integer>() {
			private static final long serialVersionUID = 1L;
			{
				this.put("VERAREG", Integer.parseInt("9F20", 16));
				this.put("VERAHI", Integer.parseInt("9F22", 16));
				this.put("VERAMID", Integer.parseInt("9F21", 16));
				this.put("VERALO", Integer.parseInt("9F20", 16));
				this.put("VERADAT", Integer.parseInt("9F23", 16));
				this.put("VERABNK", Integer.parseInt("9F61", 16));
				this.put("ROMSELECT", Integer.parseInt("9F60", 16));
			}
		};
	}

	@Override
	public List<Variable> getSystemVariables() {
		return VARS;
	}

}
