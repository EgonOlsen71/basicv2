package com.sixtyfour.cbmnative.crossoptimizer.passes.lineconstantpropagator;

import com.sixtyfour.Logger;

public class BinaryExpressionEvaluator {
    public static Object eval(String operator, Object left, Object right) {
        String leftStr = left.toString();
        String rightStr = right.toString();
        switch (operator) {
            case "+":
                return Add(left, right);
            case "/":
                return Divide(leftStr, rightStr);
            case "*":
                return Multiply(leftStr, rightStr);
            case "|":
                return BitOr(left, rightStr);
            case "INT":
                return CastToInt(leftStr);
            case "ABS":
                return AbsValue(leftStr);
            case "EQUAL":
                return equalValue(left, right);
            case "NOT_EQUAL":
                return notEqualValue(left, right);
            case "LARGER":
                return largerValue(left, right);
            case "SMALLER":
                return smallerValue(left, right);
            case "LARGER_OR_EQUAL":
                return largerOrEqualValue(left, right);
            case "SMALLER_OR_EQUAL":
                return smallerOrEqualValue(left, right);
            default:
                throw new RuntimeException("It wasn't implemented: " + operator);
        }
    }

    private static Object notEqualValue(Object left, Object right) {
        if (left instanceof Integer) {
            int leftInt = (Integer) left;
            int rightInt = (Integer) right;
            return mapBool(leftInt != rightInt);
        }
        return null;
    }
    private static Object equalValue(Object left, Object right) {
        if (left instanceof Integer) {
            int leftInt = (Integer) left;
            int rightInt = (Integer) right;
            return mapBool(leftInt == rightInt);
        }
        return null;
    }

    private static Object smallerOrEqualValue(Object left, Object right) {
        if (left instanceof Integer) {
            int leftInt = (Integer) left;
            int rightInt = (Integer) right;
            return mapBool(leftInt <= rightInt);
        }
        return null;
    }

    private static Object smallerValue(Object left, Object right) {
        if (left instanceof Integer) {
            int leftInt = (Integer) left;
            int rightInt = (Integer) right;
            return mapBool(leftInt < rightInt);
        }
        return null;
    }

    private static Object largerOrEqualValue(Object left, Object right) {
        if (left instanceof Integer) {
            int leftInt = (Integer) left;
            int rightInt = (Integer) right;
            return mapBool(leftInt >= rightInt);
        }
        return null;
    }


    private static Object largerValue(Object left, Object right) {
        if (left instanceof Integer) {
            int leftInt = (Integer) left;
            int rightInt = (Integer) right;
            return mapBool(leftInt > rightInt);
        }
        return null;
    }

    static int mapBool(boolean b) {
        return b ? 1 : 0;
    }

    private static Object AbsValue(String leftStr) {
        float value = Float.parseFloat(leftStr);
        return Math.abs(value);
    }

    private static Object Multiply(String leftStr, String rightStr) {
        return Float.parseFloat(leftStr) * Float.parseFloat(rightStr);
    }

    private static Object Add(Object left, Object right) {
        if ((left instanceof Double) || (left instanceof Integer) || (left instanceof Float)) {
            return Float.parseFloat(left.toString()) + Float.parseFloat(right.toString());
        }
        if (left instanceof String) {
            return left.toString() + right;
        }
        return null;
    }

    private static Object CastToInt(String leftStr) {
        return (int) Float.parseFloat(leftStr);
    }

    private static Object BitOr(Object left, String rightStr) {
        if (left instanceof String) {
            return left;
        }
        if (left instanceof Float) {
            return left;
        }
        if (left instanceof Double) {
            return left;
        }
        String leftStr = left.toString();
        try {
            return Integer.parseInt(leftStr) | Integer.parseInt(rightStr);
        } catch (Exception ex) {
            logFailedOp("|", leftStr, rightStr);
            return null;
        }
    }

    static void logFailedOp(String operator, String left, String right) {
        Logger.log("Failed to evaluate operation: " + left + " " + operator + " " + right);
    }

    private static Object Divide(String leftStr, String rightStr) {
        return Float.parseFloat(leftStr) / Float.parseFloat(rightStr);
    }
}
