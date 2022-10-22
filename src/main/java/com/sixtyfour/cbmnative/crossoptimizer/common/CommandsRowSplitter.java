package com.sixtyfour.cbmnative.crossoptimizer.common;

import java.util.ArrayList;
import java.util.List;

public class CommandsRowSplitter {
    public static List<String> splitCommandIntoComponents(String line) {
        List<String> result = new ArrayList<>();
        int start = 0;
        boolean isInQuotes = false;
        for (int i = 0; i < line.length(); ++i) {
            char ch = line.charAt(i);
            if (ch == '"') {
                isInQuotes = !isInQuotes;
            }
            if (isInQuotes) {
                continue;
            }
            if (ch == ':') {
                String commandText = line.substring(start, i);
                result.add(commandText);
                start = i + 1;
            }
        }
        String lastCommandText = line.substring(start);
        result.add(lastCommandText);
        return result;
    }
}
