package com.sixtyfour.cbmnative.crossoptimizer.passes.lineconstantpropagator;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.functions.AbstractFunction;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.logic.LogicTerm;

import java.util.Map;

public class ConstantEvaluator {
    public static Object simplifyTerm(Term evalTerm, Map<String, Object> lineConstants) {
        var leftConstant = evaluateAtomToConstant(evalTerm.getLeft(), lineConstants);
        if (leftConstant == null) {
            return null;
        }
        var rightConstant = evaluateAtomToConstant(evalTerm.getRight(), lineConstants);
        if (rightConstant == null) {
            return null;
        }
        return evaluateBinaryExpression(leftConstant, rightConstant, evalTerm.getOperator().toString());
    }

    public static Object simplifyLogicTerm(LogicTerm evalTerm, Map<String, Object> lineConstants) {
        var leftConstant = simplifyTerm(evalTerm.getLeft(), lineConstants);
        if (leftConstant == null) {
            return null;
        }
        var rightConstant = simplifyTerm(evalTerm.getRight(), lineConstants);
        if (rightConstant == null) {
            return null;
        }
        return evaluateBinaryExpression(leftConstant, rightConstant, evalTerm.getComparator().toString());
    }

    private static Object evaluateBinaryExpression(Object leftValue, Object rightValue, String operator) {
        return BinaryExpressionEvaluator.eval(operator, leftValue, rightValue);
    }

    private static Object evaluateTermToConstant(Atom term) {
        if (!term.isConstant()) {
            return null;
        }
        Type termType = term.getType();
        String termExpression = term.toString();
        if (termType.equals(Type.INTEGER)) {
            return Integer.parseInt(termExpression);
        }
        if (termType.equals(Type.REAL)) {
            return Float.parseFloat(termExpression);
        }
        if (termType.equals(Type.STRING)) {
            return termExpression;
        }
        return null;
    }

    static Object solveVariable(Atom termVariable, Map<String, Object> lineConstants) {
        if (!(termVariable instanceof Variable)) {
            return null;
        }
        Variable rightVar = (Variable) termVariable;
        String name = rightVar.getUpperCaseName();
        if (!lineConstants.containsKey(name)) {
            return null;
        }
        return lineConstants.get(name);
    }

    static Object evaluateAtomToConstant(Atom termVariable, Map<String, Object> lineConstants) {
        if (termVariable instanceof Term) {
            Object result = simplifyTerm((Term) termVariable, lineConstants);
            if (result != null) {
                return result;
            }
        }
        if (termVariable instanceof LogicTerm) {
            Object result = simplifyLogicTerm((LogicTerm) termVariable, lineConstants);
            if (result != null) {
                return result;
            }
        }
        Object solvedAsVariable = solveVariable(termVariable, lineConstants);
        if (solvedAsVariable != null) {
            return solvedAsVariable;
        }
        if (termVariable.isConstant()) {
            return evaluateTermToConstant(termVariable);
        }
        if (termVariable instanceof AbstractFunction) {
            return simplifyFunction((AbstractFunction) termVariable, lineConstants);
        }
        return null;
    }

    private static Object simplifyFunction(AbstractFunction func, Map<String, Object> lineConstants) {
        String funcName = func.getName();
        switch (funcName) {
            case "RND":
            case "PEEK":
            case "[]":
                return null;
            default:
                break;
        }
        Term param = func.getTerm();
        var termConstant = evaluateAtomToConstant(param, lineConstants);
        if (termConstant == null) {
            return null;
        }
        if (funcName.equals("INT")) {
            return BinaryExpressionEvaluator.eval("INT", termConstant, "0");
        }
        return BinaryExpressionEvaluator.eval(funcName, termConstant, "0");
    }
}
