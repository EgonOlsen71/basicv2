package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.parser.Line;

public class PCodeVisitor {
    public interface IVisitor {
        void consume(Line line, Command command, int index);
    }

    public void accept(OrderedPCode orderedPCode, String commandPrefix, IVisitor onHit) {
        String prefixSearch = commandPrefix.toLowerCase();

        accept(orderedPCode, (Line line, Command command, int index) -> {
            String commandName = command.getName().toLowerCase();
            if (commandName.equals(prefixSearch)) {
                onHit.consume(line, command, index);
            }
        });
    }

    public void accept(OrderedPCode orderedPCode, IVisitor onHit) {
        for (Line line : orderedPCode.getLines()) {
            int pos = 0;
            for (Command command : line.getCommands()) {
                onHit.consume(line, command, pos);
                pos++;
            }
        }
    }
}
