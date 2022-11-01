package com.sixtyfour.cbmnative.crossoptimizer.passes.lineconstantpropagator;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.functions.AbstractFunction;
import com.sixtyfour.elements.functions.Int;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;

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

    private static Object evaluateBinaryExpression(Object leftValue, Object rightValue, String operator) {
        var result = BinaryExpressionEvaluator.eval(operator, leftValue, rightValue);
        return result;
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

    static Object evaluateAtomToConstant(Atom termVariable, Map<String, Object> lineConstants) {
        if (termVariable instanceof Term) {

            Object result = simplifyTerm((Term) termVariable, lineConstants);
            if (result != null) {
                return result;
            }

        }
        if (termVariable.isConstant()) {
            return evaluateTermToConstant(termVariable);
        }
        if (termVariable instanceof Int) {
            Object simplification = simplifyFunction(termVariable, lineConstants);
            if (simplification == null) {
                return null;
            }
            return simplification;

        }
        if (!(termVariable instanceof Variable)) {
            return null;
        }
        Variable rightVar = (Variable) termVariable;
        String name = rightVar.getUpperCaseName();
        Object value = lineConstants.get(name);
        return value;
    }

    private static Object simplifyFunction(Atom termVariable, Map<String, Object> lineConstants) {
        AbstractFunction func = (AbstractFunction) termVariable;
        Term param = func.getTerm();
        var termConstant = evaluateAtomToConstant(param, lineConstants);
        if (termConstant == null) {
            return null;
        }
        return BinaryExpressionEvaluator.eval("INT", termConstant, "0");
    }
}
