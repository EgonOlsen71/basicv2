package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.parser.Line;

import java.util.*;
import java.util.stream.Collectors;

public class OrderedPCode {
    private final List<Line> allLines = new ArrayList<>();
    private final SortedMap<Integer, Integer> rowMapping = new TreeMap<>();

    public OrderedPCode(PCode pCode) {
        Collection<Line> lines = pCode.getLines().values();
        SortedMap<Integer, Line> orderedLines = new TreeMap<>();
        for (Line line : lines) {
            orderedLines.put(line.getNumber(), line);
        }
        int pos = 0;
        for (Line orderedLine : orderedLines.values()) {
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

    public void removeRow(int number) {
        int rowIndex = getLineIndex(number);
        allLines.remove(rowIndex);
        rebuildIndex();
    }

    private void rebuildIndex() {
        rowMapping.clear();
        int pos = 0;
        for (Line l : allLines) {
            rowMapping.put(l.getNumber(), pos);
            pos++;
        }
    }

    public String getCode() {
        final String result = getLines().stream()
                .map(line -> line.getNumber() + " " + line.getLine())
                .collect(Collectors.joining("\n"));
        return result;
    }
}
