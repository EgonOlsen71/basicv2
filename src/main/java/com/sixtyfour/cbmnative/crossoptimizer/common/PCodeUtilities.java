package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.Basic;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.parser.Line;

import java.util.List;

public class PCodeUtilities {
	public static void removeLastLineCommand(Line line) {
		String str = line.getLine();
		int index = str.lastIndexOf(':');
		line.getCommands().remove(line.getCommands().size() - 1);
		if (index == -1) {
			line.setLine("");
			return;
		}
		line.setLine(str.substring(0, index - 1));
	}

	public static Command getLineLastCommand(Line line){
		List<Command> commands = line.getCommands();
		return commands.get(commands.size()-1);
	}

	public static Line cloneLine(OrderedPCode orderedPCode, int line) {
		Basic basic = new Basic(orderedPCode.getCode());
		basic.compile(new CompilerConfig());
		Line resultLine = basic.getPCode().getLines().get(line);
		return resultLine;
	}
}
