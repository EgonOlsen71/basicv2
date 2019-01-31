package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.Basic;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.Line;

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

    public static Line cloneLine(OrderedPCode orderedPCode, int line) {
        Basic basic = new Basic(orderedPCode.getCode());
        basic.compile(new CompilerConfig());
        Line resultLine = basic.getPCode().getLines().get(line);
        return resultLine;
    }
}
