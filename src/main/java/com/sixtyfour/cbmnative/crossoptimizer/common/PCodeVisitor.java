package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.parser.Line;

public class PCodeVisitor {
    public interface IVisitor{
        void consume(Line line, Command command);
    }
    public void accept(OrderedPCode orderedPCode, String commandPrefix, IVisitor onHit) {
        String prefixSearch = commandPrefix.toLowerCase();
        for(Line line: orderedPCode.getLines())
        {
            for(Command command: line.getCommands())
            {
                String commandName =command.getName().toLowerCase();
                if(commandName.equals(prefixSearch)){
                    onHit.consume(line, command);
                }
            }
        }
    }
}
