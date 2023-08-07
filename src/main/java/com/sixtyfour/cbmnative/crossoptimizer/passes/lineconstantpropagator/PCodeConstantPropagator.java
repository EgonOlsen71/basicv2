package com.sixtyfour.cbmnative.crossoptimizer.passes.lineconstantpropagator;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.crossoptimizer.common.OrderedPCode;
import com.sixtyfour.cbmnative.crossoptimizer.common.PCodeUtilities;
import com.sixtyfour.cbmnative.crossoptimizer.passes.HighLevelOptimizer;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.*;
import com.sixtyfour.parser.Line;
import com.sixtyfour.parser.Term;

import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import static com.sixtyfour.cbmnative.crossoptimizer.common.CommandsRowSplitter.*;
import static com.sixtyfour.cbmnative.crossoptimizer.passes.lineconstantpropagator.ConstantEvaluator.simplifyTerm;

public class PCodeConstantPropagator implements HighLevelOptimizer {
    static Object getTermConstant(Term evalTerm, Map<String, Object> lineConstants) {
        Object constant = simplifyTerm(evalTerm, lineConstants);
        return constant;
    }

    @Override
    public boolean optimize(OrderedPCode orderedPCode) {
        for (Line line : orderedPCode.getLines()) {
            var lineOptimized = optimizeLine(orderedPCode, line);
            if (lineOptimized) {
                return true;
            }
        }
        return false;
    }

    private boolean optimizeLine(OrderedPCode orderedPCode, Line line) {
        SortedMap<String, Object> lineConstants = new TreeMap<>();
        List<Command> commands = line.getCommands();
        List<String> components = splitCommandIntoComponents(line.getLine());
        for (int i = 0; i < commands.size(); i++) {
            Command c = commands.get(i);
            String potentiallyFixableCommand = components.get(i);
            switch (c.getName()) {
                case "LET": {
                    String newLine = updateLetCommand((Let) c, lineConstants, line, i);
                    if (newLine == null) {
                        continue;
                    }
                    OrderedPCode newCode = PCodeUtilities.replaceLineInCode(orderedPCode, line.getNumber(), newLine);
                    orderedPCode.reset(newCode);
                    return true;
                }
                case "REM":
                    continue;
                case "GOTO":
                    continue;
                case "NEXT":
                    return false;
                case "FOR":
                    return false;
                case "IF": {
                    String newLine = updateIfCommand((If) c, lineConstants, line, i);
                    if (newLine == null) {
                        return false;
                    }
                    OrderedPCode newCode = PCodeUtilities.replaceLineInCode(orderedPCode, line.getNumber(), newLine);
                    orderedPCode.reset(newCode);
                    return true;
                }
                case "GOSUB":
                    return false;
                case "POKE": {
                    if (lineConstants.isEmpty()) {
                        continue;
                    }
                    String newLine = updatePokeCommand((Poke) c, lineConstants, line, i);
                    if (newLine == null) {
                        continue;
                    }
                    OrderedPCode newCode = PCodeUtilities.replaceLineInCode(orderedPCode, line.getNumber(), newLine);
                    orderedPCode.reset(newCode);
                    return true;
                }
                default:
                    if (lineConstants.isEmpty()) {
                        continue;
                    }

                    Logger.log("Unhandled command: " + potentiallyFixableCommand);
                    return false;
            }
        }

        return false;
    }

    private String updateIfCommand(If c, SortedMap<String, Object> lineConstants, Line line, int i) {
        if (lineConstants.isEmpty()) {
            return null;
        }
        var resultIfExpression = simplifyTerm(c.getLogicTerm(), lineConstants);
        if (resultIfExpression == null) {
            return null;
        }
        List<String> lineComponents = splitCommandIntoComponents(line.getLine());
        int boolResult = (Integer) resultIfExpression;
        Logger.log("Simplified line "+line.getLine());
        if (boolResult==0){
            while (lineComponents.size()>i){
                lineComponents.remove(i);
            }
            String newLineFalse = joinCommands(lineComponents);
            return newLineFalse;
        } else {
            //here IF is always true

            //then we check if next line is a GOTO
            Command nextCommand = line.getCommands().get(i + 1);
            boolean nextIsGoto = nextCommand.getName().equals("GOTO");
            if (nextIsGoto){
                Goto nextGoto = (Goto) nextCommand;
                lineComponents.set(i, "GOTO "+nextGoto.getTargetLineNumber());
            }
            String newLineTrue = joinCommands(lineComponents);
            return newLineTrue;
        }
    }

    private String updatePokeCommand(Poke poke, SortedMap<String, Object> lineConstants, Line line, int indexCommand) {
        var oldPoke = splitCommandIntoComponents(line.getLine()).get(indexCommand).trim();
        Term pokeTerm = poke.getTerm();
        if (!(pokeTerm.getLeft() instanceof Term)) {
            return null;
        }
        if (!(pokeTerm.getRight() instanceof Term)) {
            return null;
        }
        var addr = simplifyTerm((Term) pokeTerm.getLeft(), lineConstants);
        if (addr == null) {
            return null;
        }
        var value = simplifyTerm((Term) pokeTerm.getRight(), lineConstants);
        if (value == null) {
            return null;
        }
        int intAddr = (int) (float) (Float) addr;
        var newCode = "POKE " + intAddr + "," + value;
        if (oldPoke.equals(newCode)) {
            return null;
        }
        return newCode;
    }

    private String updateLetCommand(Let let, Map<String, Object> lineConstants, Line line, int index) {
        Variable variable = let.getVar();
        String varName = variable.getUpperCaseName();
        if (variable.isArray()) {
            lineConstants.remove(varName);
            return null;
        }
        var terms = let.getAllTerms().get(0);
        var termConstant = getTermConstant(terms, lineConstants);
        if (termConstant != null) {
            lineConstants.put(varName, termConstant);
            List<String> split = splitCommandIntoComponents(line.getLine());
            String newCode = varName + "=" + termConstant;
            if (termConstant instanceof String) {
                newCode = varName + "=\"" + termConstant + "\"";
            }
            if (newCode.endsWith(".0")) {
                newCode = newCode.substring(0, newCode.length() - 2);
            }

            String oldLetCode;
            try {
                oldLetCode = split.get(index).trim().toUpperCase();
            } catch (Exception ex) {
                Logger.log("Error: " + ex);
                Logger.log("Line: " + line.getLine());
                return null;
            }
            if (oldLetCode.equals(newCode.toUpperCase())) {
                return null;
            }

            String newLine = replaceComponent(line.getLine(), index, newCode);

            return newLine;
        }
        return null;
    }
}
