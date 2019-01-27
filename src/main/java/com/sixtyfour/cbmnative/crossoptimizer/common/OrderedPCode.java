package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.parser.Line;

import java.util.*;

public class OrderedPCode {
    List<Line> allLines = new ArrayList<>();
    Map<Integer, Integer> rowMapping = new HashMap<>();
    public OrderedPCode(PCode pCode){
        Collection<Line> lines = pCode.getLines().values();
        SortedMap<Integer, Line> orderedLines = new TreeMap<>();
        for(Line line: lines){
            orderedLines.put(line.getNumber(), line);
        }
        int pos = 0;
        for(Line orderedLine: orderedLines.values()){
            allLines.add(orderedLine);
            rowMapping.put(orderedLine.getNumber(), pos);
            pos++;
        }


    }

    public List<Line> getLines() {
        return allLines;
    }

    public Line getLine(int lineNumber) {
        int targetLine = getLineIndex(lineNumber);
        return getLineDirect(targetLine);
    }

    public int getLineIndex(int lineNumber) {
        return rowMapping.get(lineNumber);
    }

    public Line getLineDirect(int targetLine) {
        return allLines.get(targetLine);
    }
}
