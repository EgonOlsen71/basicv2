package com.sixtyfour.cbmnative.crossoptimizer.common;

import com.sixtyfour.Basic;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.config.CompilerConfig;
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
            line.setLine(line.getLine().toUpperCase());
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

    public OrderedPCode cloneInstance() {
        Basic basic = new Basic(getCode());
        basic.compile(new CompilerConfig());
        return new OrderedPCode(basic.getPCode());
    }

    public OrderedPCode cloneInstanceWithLineReplaced(int line, String lineText) {
        StringBuilder sb = new StringBuilder();
        for (Line l : allLines) {
            sb.append(l.getNumber()).append(" ");
            if (line != l.getNumber()) {
                sb.append(l.getLine());
            } else {
                sb.append(lineText);
            }
            sb.append('\n');
        }
        Basic basic = new Basic(sb.toString());
        basic.compile(new CompilerConfig());
        return new OrderedPCode(basic.getPCode());
    }

    public void reset(OrderedPCode other) {
        this.allLines.clear();
        allLines.addAll(other.allLines);
        this.rowMapping.clear();
        ;
        this.rowMapping.putAll(other.rowMapping);
    }

    public String getCode() {
        final String result = getLines().stream()
                .map(line -> line.getNumber() + " " + line.getLine())
                .collect(Collectors.joining("\n"));
        return result;
    }
}
