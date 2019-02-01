package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.parser.Line;

import java.util.List;

public class PCodeVisitor {
    private final OrderedPCode pCode;

    public interface IVisitor {
        void consume(Line line, Command command, int index);
    }

    public PCodeVisitor(OrderedPCode orderedPCode) {
        this.pCode = orderedPCode;
    }

    public void accept(String commandPrefix, IVisitor onHit) {
        String prefixSearch = commandPrefix.toLowerCase();

        accept((Line line, Command command, int index) -> {
            String commandName = command.getName().toLowerCase();
            if (commandName.equals(prefixSearch)) {
                onHit.consume(line, command, index);
            }
        });
    }

    public void accept(IVisitor onHit) {
        final List<Line> lines = pCode.getLines();
        for (Line line : lines) {
            int pos = 0;
            for (Command command : line.getCommands()) {
                onHit.consume(line, command, pos);
                pos++;
            }
        }
    }
}
