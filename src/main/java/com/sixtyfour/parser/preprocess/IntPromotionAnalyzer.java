package com.sixtyfour.parser.preprocess;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

/**
 * BasicLoopAnalyzer parses a C64 BASIC V2 program in ASCII/text format
 * and conservatively determines if variables are 100% safe to be treated as integers.
 * This is a static analysis. It might fail ...
 *
 * @author EgonOlsen
 */
public class IntPromotionAnalyzer {

    // --- Token Types ---
    public enum TokenType {
        NUMBER, IDENTIFIER, STRING,
        PLUS, MINUS, MULTIPLY, DIVIDE, EXPONENT,
        EQUAL, NOT_EQUAL, LESS_THAN, LESS_EQUAL, GREATER_THAN, GREATER_EQUAL,
        AND, OR, NOT,
        FOR, TO, STEP, NEXT, LET, IF, THEN, GOTO, GOSUB, RETURN, INPUT, GET, READ, DATA, REM,
        PAREN_OPEN, PAREN_CLOSE, COMMA, COLON, SEMICOLON,
        FUNCTION, FN, KEYWORD,
        UNKNOWN
    }

    // --- Token Class ---
    public static class Token {
        public final TokenType type;
        public final String value;
        public final int lineNum;

        public Token(TokenType type, String value, int lineNum) {
            this.type = type;
            this.value = value;
            this.lineNum = lineNum;
        }

        @Override
        public String toString() {
            return String.format("%s(%s)@%d", type, value, lineNum);
        }
    }

    // --- AST Expressions ---
    public interface Expression {
        boolean isIntegerValued(Set<String> safeVariables);
    }

    public static class NumberConstantExpr implements Expression {
        public final String value;

        public NumberConstantExpr(String value) {
            this.value = value;
        }

        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            // C64 BASIC represents numbers with decimal points or E notation as floats
            if (value.contains(".") || value.toUpperCase().contains("E")) {
                return false;
            }
            try {
                long val = Long.parseLong(value);
                // Must fit in standard 16-bit signed integer: [-32768, 32767]
                return val >= -32768 && val <= 32767;
            } catch (NumberFormatException e) {
                return false;
            }
        }

        @Override
        public String toString() {
            return value;
        }
    }

    public static class StringConstantExpr implements Expression {
        public final String value;

        public StringConstantExpr(String value) {
            this.value = value;
        }

        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            return false;
        }

        @Override
        public String toString() {
            return "\"" + value + "\"";
        }
    }

    public static class FloatConstantExpr implements Expression {
        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            return false;
        }

        @Override
        public String toString() {
            return "<float>";
        }
    }

    public static class VariableExpr implements Expression {
        public final String name; // Normalized to 2 chars + suffix

        public VariableExpr(String name) {
            this.name = name;
        }

        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            if (name.endsWith("%")) return true;
            if (name.endsWith("$")) return false;
            return safeVariables.contains(name);
        }

        @Override
        public String toString() {
            return name;
        }
    }

    public static class ArrayAccessExpr implements Expression {
        public final String name;
        public final List<Expression> args;

        public ArrayAccessExpr(String name, List<Expression> args) {
            this.name = name;
            this.args = args;
        }

        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            // Array variable names ending in % are integer arrays
            return name.endsWith("%");
        }

        @Override
        public String toString() {
            return name + "(" + args + ")";
        }
    }

    public static class UnaryOpExpr implements Expression {
        public final String op;
        public final Expression operand;

        public UnaryOpExpr(String op, Expression operand) {
            this.op = op;
            this.operand = operand;
        }

        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            if ("NOT".equalsIgnoreCase(op)) {
                // NOT in BASIC V2 converts its operand to an integer, returning an integer.
                return true;
            }
            return operand != null && operand.isIntegerValued(safeVariables);
        }

        @Override
        public String toString() {
            return op + " " + operand;
        }
    }

    public static class BinaryOpExpr implements Expression {
        public final String op;
        public final Expression left;
        public final Expression right;

        public BinaryOpExpr(String op, Expression left, Expression right) {
            this.op = op;
            this.left = left;
            this.right = right;
        }

        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            if (left == null || right == null) return false;

            switch (op) {
                case "+":
                case "-":
                case "*":
                    return left.isIntegerValued(safeVariables) && right.isIntegerValued(safeVariables);
                case "/":
                case "^":
                    return false; // Division and exponentiation produce floats in BASIC V2
                case "=":
                case "<>":
                case "<":
                case "<=":
                case ">":
                case ">=":
                    return true; // Comparison results are always integer (0 or -1)
                case "AND":
                case "OR":
                    return left.isIntegerValued(safeVariables) && right.isIntegerValued(safeVariables);
                default:
                    return false;
            }
        }

        @Override
        public String toString() {
            return "(" + left + " " + op + " " + right + ")";
        }
    }

    public static class FunctionCallExpr implements Expression {
        public final String funcName;
        public final List<Expression> args;

        public FunctionCallExpr(String funcName, List<Expression> args) {
            this.funcName = funcName;
            this.args = args;
        }

        @Override
        public boolean isIntegerValued(Set<String> safeVariables) {
            switch (funcName) {
                case "INT":
                case "PEEK":
                case "LEN":
                case "ASC":
                case "POS":
                case "FRE":
                case "SGN":
                    return true;
                case "ABS":
                    return !args.isEmpty() && args.get(0).isIntegerValued(safeVariables);
                default:
                    return false;
            }
        }

        @Override
        public String toString() {
            return funcName + "(" + args + ")";
        }
    }

    // --- AST Statements ---
    public static abstract class Statement {
        public int lineNum;
    }

    public static class ForStatement extends Statement {
        public final String variable; // Normalized
        public final Expression start;
        public final Expression end;
        public final Expression step; // Null if omitted

        public ForStatement(String variable, Expression start, Expression end, Expression step) {
            this.variable = variable;
            this.start = start;
            this.end = end;
            this.step = step;
        }

        @Override
        public String toString() {
            return String.format("FOR %s = %s TO %s%s", variable, start, end, (step != null ? " STEP " + step : ""));
        }
    }

    public static class NextStatement extends Statement {
        public final List<String> variables;

        public NextStatement(List<String> variables) {
            this.variables = variables;
        }

        @Override
        public String toString() {
            return "NEXT " + String.join(", ", variables);
        }
    }

    public static class AssignmentStatement extends Statement {
        public final String variable; // Normalized
        public final Expression expression;

        public AssignmentStatement(String variable, Expression expression) {
            this.variable = variable;
            this.expression = expression;
        }

        @Override
        public String toString() {
            return variable + " = " + expression;
        }
    }

    public static class InputStatement extends Statement {
        public final List<String> variables;

        public InputStatement(List<String> variables) {
            this.variables = variables;
        }

        @Override
        public String toString() {
            return "INPUT " + String.join(", ", variables);
        }
    }

    public static class GetStatement extends Statement {
        public final List<String> variables;

        public GetStatement(List<String> variables) {
            this.variables = variables;
        }

        @Override
        public String toString() {
            return "GET " + String.join(", ", variables);
        }
    }

    public static class ReadStatement extends Statement {
        public final List<String> variables;

        public ReadStatement(List<String> variables) {
            this.variables = variables;
        }

        @Override
        public String toString() {
            return "READ " + String.join(", ", variables);
        }
    }

    public static class DataStatement extends Statement {
        public final List<Token> constants;

        public DataStatement(List<Token> constants) {
            this.constants = constants;
        }

        @Override
        public String toString() {
            List<String> vals = new ArrayList<>();
            for (Token t : constants) vals.add(t.value);
            return "DATA " + String.join(", ", vals);
        }
    }

    public static class IfStatement extends Statement {
        public final Expression condition;
        public final Statement body;

        public IfStatement(Expression condition, Statement body) {
            this.condition = condition;
            this.body = body;
        }

        @Override
        public String toString() {
            return "IF " + condition + " THEN " + body;
        }
    }

    public static class OtherStatement extends Statement {
        @Override
        public String toString() {
            return "<other>";
        }
    }

    // --- Lexer implementation ---
    private static final String[] KEYWORDS = {
            "RESTORE",
            "INPUT#", "PRINT#", "RETURN", "VERIFY", "RIGHT$", "LEFT$",
            "GOSUB", "INPUT", "PRINT", "CLOSE",
            "GOTO", "NEXT", "STEP", "THEN", "OPEN", "READ", "PEEK", "POKE", "WAIT", "LOAD", "SAVE", "LIST", "STOP", "CONT", "DATA", "MID$", "CHR$", "STR$",
            "SGN", "INT", "ABS", "USR", "FRE", "POS", "SQR", "RND", "LOG", "EXP", "COS", "SIN", "TAN", "ATN", "LEN", "VAL", "ASC", "SYS", "CMD", "GET", "LET", "FOR", "DIM", "RUN", "END", "CLR", "NEW", "AND", "NOT",
            "TO", "FN", "OR", "IF", "ON",
            "<>", "<=", ">=", "=", "<", ">",
            "+", "-", "*", "/", "^", "(", ")", ",", ":", ";"
    };

    private static boolean startsWithIgnoreCase(String text, int start, String prefix) {
        if (start + prefix.length() > text.length()) return false;
        return text.substring(start, start + prefix.length()).equalsIgnoreCase(prefix);
    }

    private static String matchKeyword(String text, int start) {
        String sub = text.substring(start).toUpperCase();
        for (String kw : KEYWORDS) {
            if (sub.startsWith(kw)) {
                return text.substring(start, start + kw.length());
            }
        }
        return null;
    }

    private static TokenType getKeywordTokenType(String kw) {
        kw = kw.toUpperCase();
        switch (kw) {
            case "FOR": return TokenType.FOR;
            case "TO": return TokenType.TO;
            case "STEP": return TokenType.STEP;
            case "NEXT": return TokenType.NEXT;
            case "LET": return TokenType.LET;
            case "IF": return TokenType.IF;
            case "THEN": return TokenType.THEN;
            case "GOTO": return TokenType.GOTO;
            case "GOSUB": return TokenType.GOSUB;
            case "RETURN": return TokenType.RETURN;
            case "INPUT": return TokenType.INPUT;
            case "GET": return TokenType.GET;
            case "READ": return TokenType.READ;
            case "DATA": return TokenType.DATA;
            case "AND": return TokenType.AND;
            case "OR": return TokenType.OR;
            case "NOT": return TokenType.NOT;
            case "FN": return TokenType.FN;
            case "=": return TokenType.EQUAL;
            case "<>": return TokenType.NOT_EQUAL;
            case "<": return TokenType.LESS_THAN;
            case "<=": return TokenType.LESS_EQUAL;
            case ">": return TokenType.GREATER_THAN;
            case ">=": return TokenType.GREATER_EQUAL;
            case "+": return TokenType.PLUS;
            case "-": return TokenType.MINUS;
            case "*": return TokenType.MULTIPLY;
            case "/": return TokenType.DIVIDE;
            case "^": return TokenType.EXPONENT;
            case "(": return TokenType.PAREN_OPEN;
            case ")": return TokenType.PAREN_CLOSE;
            case ",": return TokenType.COMMA;
            case ":": return TokenType.COLON;
            case ";": return TokenType.SEMICOLON;

            // Functions
            case "SGN":
            case "INT":
            case "ABS":
            case "USR":
            case "FRE":
            case "POS":
            case "SQR":
            case "RND":
            case "LOG":
            case "EXP":
            case "COS":
            case "SIN":
            case "TAN":
            case "ATN":
            case "PEEK":
            case "LEN":
            case "VAL":
            case "ASC":
            case "LEFT$":
            case "RIGHT$":
            case "MID$":
            case "CHR$":
            case "STR$":
                return TokenType.FUNCTION;

            default:
                return TokenType.KEYWORD;
        }
    }

    public static List<Token> tokenizeLine(String lineText, int lineNum) {
        List<Token> tokens = new ArrayList<>();
        int i = 0;

        // Strip leading line number if present
        while (i < lineText.length() && Character.isWhitespace(lineText.charAt(i))) {
            i++;
        }
        if (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
            int start = i;
            while (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
                i++;
            }
            tokens.add(new Token(TokenType.NUMBER, lineText.substring(start, i), lineNum));
        }

        while (i < lineText.length()) {
            char c = lineText.charAt(i);
            if (Character.isWhitespace(c)) {
                i++;
                continue;
            }

            // String Literals
            if (c == '"') {
                int start = i;
                i++; // Skip start quote
                while (i < lineText.length() && lineText.charAt(i) != '"') {
                    i++;
                }
                if (i < lineText.length()) {
                    i++; // Consume closing quote
                }
                tokens.add(new Token(TokenType.STRING, lineText.substring(start, i), lineNum));
                continue;
            }

            // REM comments (discard rest of line)
            if (startsWithIgnoreCase(lineText, i, "REM")) {
                break;
            }

            // Keywords, Operators, Punctuation
            String matched = matchKeyword(lineText, i);
            if (matched != null) {
                tokens.add(new Token(getKeywordTokenType(matched), matched, lineNum));
                i += matched.length();
                continue;
            }

            // Numbers
            if (Character.isDigit(c) || c == '.') {
                int start = i;
                if (c == '.') {
                    i++;
                    if (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
                        while (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
                            i++;
                        }
                    } else {
                        tokens.add(new Token(TokenType.UNKNOWN, ".", lineNum));
                        continue;
                    }
                } else {
                    while (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
                        i++;
                    }
                    if (i < lineText.length() && lineText.charAt(i) == '.') {
                        i++;
                        while (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
                            i++;
                        }
                    }
                }
                // Exponent
                if (i < lineText.length() && (lineText.charAt(i) == 'E' || lineText.charAt(i) == 'e')) {
                    int ePos = i;
                    i++;
                    if (i < lineText.length() && (lineText.charAt(i) == '+' || lineText.charAt(i) == '-')) {
                        i++;
                    }
                    if (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
                        while (i < lineText.length() && Character.isDigit(lineText.charAt(i))) {
                            i++;
                        }
                    } else {
                        i = ePos; // Backtrack
                    }
                }
                tokens.add(new Token(TokenType.NUMBER, lineText.substring(start, i), lineNum));
                continue;
            }

            // Identifiers
            if (Character.isLetter(c)) {
                int start = i;
                i++;
                while (i < lineText.length() && Character.isLetterOrDigit(lineText.charAt(i))) {
                    i++;
                }
                if (i < lineText.length() && (lineText.charAt(i) == '%' || lineText.charAt(i) == '$')) {
                    i++;
                }
                tokens.add(new Token(TokenType.IDENTIFIER, lineText.substring(start, i), lineNum));
                continue;
            }

            // Unknown fallback
            tokens.add(new Token(TokenType.UNKNOWN, String.valueOf(c), lineNum));
            i++;
        }
        return tokens;
    }

    // --- Name Normalization ---
    public static String normalizeVariableName(String name) {
        if (name == null || name.isEmpty()) return "";
        name = name.toUpperCase();
        char last = name.charAt(name.length() - 1);
        boolean hasSuffix = (last == '%' || last == '$');
        String base = hasSuffix ? name.substring(0, name.length() - 1) : name;
        if (base.length() > 2) {
            base = base.substring(0, 2);
        }
        return base + (hasSuffix ? String.valueOf(last) : "");
    }

    // --- Parser Class ---
    public static class ExpressionParser {
        private final List<Token> tokens;
        private int pos;

        public ExpressionParser(List<Token> tokens) {
            this.tokens = tokens;
            this.pos = 0;
        }

        private Token peek() {
            if (pos >= tokens.size()) return null;
            return tokens.get(pos);
        }

        private Token consume() {
            if (pos >= tokens.size()) return null;
            return tokens.get(pos++);
        }

        private boolean match(TokenType... types) {
            Token t = peek();
            if (t == null) return false;
            for (TokenType type : types) {
                if (t.type == type) {
                    consume();
                    return true;
                }
            }
            return false;
        }

        public Expression parse() {
            return parseOr();
        }

        private Expression parseOr() {
            Expression expr = parseAnd();
            while (match(TokenType.OR)) {
                Expression right = parseAnd();
                expr = new BinaryOpExpr("OR", expr, right);
            }
            return expr;
        }

        private Expression parseAnd() {
            Expression expr = parseRelational();
            while (match(TokenType.AND)) {
                Expression right = parseRelational();
                expr = new BinaryOpExpr("AND", expr, right);
            }
            return expr;
        }

        private Expression parseRelational() {
            Expression expr = parseAdditive();
            while (true) {
                Token op = peek();
                if (op != null && (op.type == TokenType.EQUAL || op.type == TokenType.NOT_EQUAL ||
                        op.type == TokenType.LESS_THAN || op.type == TokenType.LESS_EQUAL ||
                        op.type == TokenType.GREATER_THAN || op.type == TokenType.GREATER_EQUAL)) {
                    consume();
                    Expression right = parseAdditive();
                    expr = new BinaryOpExpr(op.value, expr, right);
                } else {
                    break;
                }
            }
            return expr;
        }

        private Expression parseAdditive() {
            Expression expr = parseMultiplicative();
            while (true) {
                Token op = peek();
                if (op != null && (op.type == TokenType.PLUS || op.type == TokenType.MINUS)) {
                    consume();
                    Expression right = parseMultiplicative();
                    expr = new BinaryOpExpr(op.value, expr, right);
                } else {
                    break;
                }
            }
            return expr;
        }

        private Expression parseMultiplicative() {
            Expression expr = parseExponential();
            while (true) {
                Token op = peek();
                if (op != null && (op.type == TokenType.MULTIPLY || op.type == TokenType.DIVIDE)) {
                    consume();
                    Expression right = parseExponential();
                    expr = new BinaryOpExpr(op.value, expr, right);
                } else {
                    break;
                }
            }
            return expr;
        }

        private Expression parseExponential() {
            Expression expr = parseUnary();
            while (match(TokenType.EXPONENT)) {
                Expression right = parseUnary();
                expr = new BinaryOpExpr("^", expr, right);
            }
            return expr;
        }

        private Expression parseUnary() {
            Token op = peek();
            if (op != null && (op.type == TokenType.PLUS || op.type == TokenType.MINUS || op.type == TokenType.NOT)) {
                consume();
                Expression operand = parseUnary();
                return new UnaryOpExpr(op.value, operand);
            }
            return parsePrimary();
        }

        private Expression parsePrimary() {
            Token t = peek();
            if (t == null) return null;

            if (t.type == TokenType.NUMBER) {
                consume();
                return new NumberConstantExpr(t.value);
            }
            if (t.type == TokenType.STRING) {
                consume();
                return new StringConstantExpr(t.value);
            }
            if (t.type == TokenType.IDENTIFIER) {
                consume();
                String varName = normalizeVariableName(t.value);
                Token next = peek();
                if (next != null && next.type == TokenType.PAREN_OPEN) {
                    consume(); // consume '('
                    List<Expression> args = new ArrayList<>();
                    if (peek() != null && peek().type != TokenType.PAREN_CLOSE) {
                        args.add(parseOr());
                        while (match(TokenType.COMMA)) {
                            args.add(parseOr());
                        }
                    }
                    if (peek() != null && peek().type == TokenType.PAREN_CLOSE) {
                        consume(); // consume ')'
                    }
                    return new ArrayAccessExpr(varName, args);
                }
                return new VariableExpr(varName);
            }
            if (t.type == TokenType.FUNCTION) {
                consume();
                String funcName = t.value.toUpperCase();
                List<Expression> args = new ArrayList<>();
                Token next = peek();
                if (next != null && next.type == TokenType.PAREN_OPEN) {
                    consume(); // consume '('
                    if (peek() != null && peek().type != TokenType.PAREN_CLOSE) {
                        args.add(parseOr());
                        while (match(TokenType.COMMA)) {
                            args.add(parseOr());
                        }
                    }
                    if (peek() != null && peek().type == TokenType.PAREN_CLOSE) {
                        consume(); // consume ')'
                    }
                }
                return new FunctionCallExpr(funcName, args);
            }
            if (t.type == TokenType.FN) {
                consume();
                Token nameToken = peek();
                if (nameToken != null && nameToken.type == TokenType.IDENTIFIER) {
                    consume();
                }
                Token next = peek();
                if (next != null && next.type == TokenType.PAREN_OPEN) {
                    consume();
                    parseOr();
                    if (peek() != null && peek().type == TokenType.PAREN_CLOSE) {
                        consume();
                    }
                }
                return new FloatConstantExpr();
            }
            if (t.type == TokenType.PAREN_OPEN) {
                consume();
                Expression expr = parseOr();
                if (peek() != null && peek().type == TokenType.PAREN_CLOSE) {
                    consume();
                }
                return expr;
            }

            consume(); // Unknown/error
            return null;
        }
    }

    public static Statement parseStatement(List<Token> tokens, int start, int end) {
        if (start >= end) return null;

        Token t = tokens.get(start);

        // FOR Statement
        if (t.type == TokenType.FOR) {
            int eqPos = -1;
            for (int i = start + 1; i < end; i++) {
                if (tokens.get(i).type == TokenType.EQUAL) {
                    eqPos = i;
                    break;
                }
            }
            if (eqPos == -1) return null;

            Token varToken = tokens.get(start + 1);
            if (varToken.type != TokenType.IDENTIFIER) return null;
            String varName = normalizeVariableName(varToken.value);

            int toPos = -1;
            for (int i = eqPos + 1; i < end; i++) {
                if (tokens.get(i).type == TokenType.TO) {
                    toPos = i;
                    break;
                }
            }
            if (toPos == -1) return null;

            int stepPos = -1;
            for (int i = toPos + 1; i < end; i++) {
                if (tokens.get(i).type == TokenType.STEP) {
                    stepPos = i;
                    break;
                }
            }

            Expression startExpr = parseExpr(tokens.subList(eqPos + 1, toPos));
            Expression endExpr = parseExpr(tokens.subList(toPos + 1, stepPos != -1 ? stepPos : end));
            Expression stepExpr = null;
            if (stepPos != -1) {
                stepExpr = parseExpr(tokens.subList(stepPos + 1, end));
            }

            return new ForStatement(varName, startExpr, endExpr, stepExpr);
        }

        // NEXT Statement
        if (t.type == TokenType.NEXT) {
            List<String> vars = new ArrayList<>();
            for (int i = start + 1; i < end; i++) {
                Token vt = tokens.get(i);
                if (vt.type == TokenType.IDENTIFIER) {
                    vars.add(normalizeVariableName(vt.value));
                }
            }
            return new NextStatement(vars);
        }

        // LET Statement
        if (t.type == TokenType.LET) {
            int eqPos = -1;
            for (int i = start + 1; i < end; i++) {
                if (tokens.get(i).type == TokenType.EQUAL) {
                    eqPos = i;
                    break;
                }
            }
            if (eqPos != -1) {
                boolean isArray = false;
                for (int i = start + 1; i < eqPos; i++) {
                    if (tokens.get(i).type == TokenType.PAREN_OPEN) {
                        isArray = true;
                        break;
                    }
                }
                if (!isArray && eqPos == start + 2) {
                    String varName = normalizeVariableName(tokens.get(start + 1).value);
                    Expression expr = parseExpr(tokens.subList(eqPos + 1, end));
                    return new AssignmentStatement(varName, expr);
                }
            }
        }

        // Assignment without LET (e.g. A = 1)
        int eqPos = -1;
        int parenDepth = 0;
        for (int i = start; i < end; i++) {
            Token tok = tokens.get(i);
            if (tok.type == TokenType.PAREN_OPEN) parenDepth++;
            else if (tok.type == TokenType.PAREN_CLOSE) parenDepth--;
            else if (tok.type == TokenType.EQUAL && parenDepth == 0) {
                eqPos = i;
                break;
            }
        }
        if (eqPos != -1) {
            Token first = tokens.get(start);
            if (first.type == TokenType.IDENTIFIER) {
                boolean isArray = false;
                for (int i = start; i < eqPos; i++) {
                    if (tokens.get(i).type == TokenType.PAREN_OPEN) {
                        isArray = true;
                        break;
                    }
                }
                if (!isArray && eqPos == start + 1) {
                    String varName = normalizeVariableName(first.value);
                    Expression expr = parseExpr(tokens.subList(eqPos + 1, end));
                    return new AssignmentStatement(varName, expr);
                }
            }
        }

        // INPUT Statement
        if (t.type == TokenType.INPUT) {
            List<String> vars = new ArrayList<>();
            int i = start + 1;
            if (i < end && tokens.get(i).type == TokenType.STRING) {
                i++;
                if (i < end && tokens.get(i).type == TokenType.SEMICOLON) {
                    i++;
                }
            }
            for (; i < end; i++) {
                Token vt = tokens.get(i);
                if (vt.type == TokenType.IDENTIFIER) {
                    vars.add(normalizeVariableName(vt.value));
                }
            }
            return new InputStatement(vars);
        }

        // GET Statement
        if (t.type == TokenType.GET) {
            List<String> vars = new ArrayList<>();
            for (int i = start + 1; i < end; i++) {
                Token vt = tokens.get(i);
                if (vt.type == TokenType.IDENTIFIER) {
                    vars.add(normalizeVariableName(vt.value));
                }
            }
            return new GetStatement(vars);
        }

        // READ Statement
        if (t.type == TokenType.READ) {
            List<String> vars = new ArrayList<>();
            for (int i = start + 1; i < end; i++) {
                Token vt = tokens.get(i);
                if (vt.type == TokenType.IDENTIFIER) {
                    vars.add(normalizeVariableName(vt.value));
                }
            }
            return new ReadStatement(vars);
        }

        // DATA Statement
        if (t.type == TokenType.DATA) {
            List<Token> constants = new ArrayList<>();
            for (int i = start + 1; i < end; i++) {
                Token vt = tokens.get(i);
                if (vt.type != TokenType.COMMA) {
                    constants.add(vt);
                }
            }
            return new DataStatement(constants);
        }

        // IF Statement
        if (t.type == TokenType.IF) {
            int thenPos = -1;
            for (int i = start + 1; i < end; i++) {
                if (tokens.get(i).type == TokenType.THEN) {
                    thenPos = i;
                    break;
                }
            }
            if (thenPos != -1) {
                Expression cond = parseExpr(tokens.subList(start + 1, thenPos));
                if (thenPos + 1 < end) {
                    Token nextT = tokens.get(thenPos + 1);
                    if (nextT.type == TokenType.NUMBER) {
                        return new IfStatement(cond, null); // IF ... THEN <line_number>
                    } else {
                        Statement body = parseStatement(tokens, thenPos + 1, end);
                        return new IfStatement(cond, body);
                    }
                }
                return new IfStatement(cond, null);
            }
        }

        return new OtherStatement();
    }

    private static Expression parseExpr(List<Token> tokens) {
        if (tokens.isEmpty()) return null;
        ExpressionParser parser = new ExpressionParser(tokens);
        try {
            return parser.parse();
        } catch (Exception e) {
            return null; // fallback to unsafe on parsing errors
        }
    }

    public static List<Statement> parseTokens(List<Token> lineTokens) {
        List<Statement> statements = new ArrayList<>();
        if (lineTokens.isEmpty()) return statements;

        int start = 0;
        // Ignore leading line number
        if (lineTokens.get(0).type == TokenType.NUMBER) {
            start = 1;
        }

        int end = start;
        while (end < lineTokens.size()) {
            if (lineTokens.get(end).type == TokenType.COLON) {
                Statement stmt = parseStatement(lineTokens, start, end);
                if (stmt != null) {
                    stmt.lineNum = lineTokens.get(0).type == TokenType.NUMBER ?
                            Integer.parseInt(lineTokens.get(0).value) : 0;
                    statements.add(stmt);
                }
                start = end + 1;
            }
            end++;
        }
        if (start < end) {
            Statement stmt = parseStatement(lineTokens, start, end);
            if (stmt != null) {
                stmt.lineNum = lineTokens.get(0).type == TokenType.NUMBER ?
                        Integer.parseInt(lineTokens.get(0).value) : 0;
                statements.add(stmt);
            }
        }
        return statements;
    }

    // --- Float Data Check ---
    private static boolean isFloatDataToken(Token tok) {
        String val = tok.value;
        if (tok.type == TokenType.STRING) {
            if (val.startsWith("\"") && val.endsWith("\"")) {
                val = val.substring(1, val.length() - 1);
            }
        }
        if (val.contains(".") || val.toUpperCase().contains("E")) {
            try {
                Double.parseDouble(val);
                return true;
            } catch (NumberFormatException e) {
                return false;
            }
        }
        try {
            long l = Long.parseLong(val);
            if (l < -32768 || l > 32767) {
                return true; // value exceeds 16-bit signed int
            }
        } catch (NumberFormatException e) {
            // Not a number, so it is text data
        }
        return false;
    }

    // --- Analysis Result ---
    public static class AnalysisResult {
        public final Set<String> safeLoopVariables;
        public final Set<String> safeIntegerVariables;

        public AnalysisResult(Set<String> safeLoopVariables, Set<String> safeIntegerVariables) {
            this.safeLoopVariables = safeLoopVariables;
            this.safeIntegerVariables = safeIntegerVariables;
        }

        public Set<String> getAllSafeVariables() {
            Set<String> all = new HashSet<>(safeIntegerVariables);
            all.addAll(safeLoopVariables);
            return all;
        }

        @Override
        public String toString() {
            return "Loop Variables: " + safeLoopVariables + ", All Safe Variables: " + safeIntegerVariables;
        }
    }

    // --- Out-of-Range Comparison Safety Helpers ---
    private static Double getConstantValue(Expression expr) {
        if (expr instanceof NumberConstantExpr) {
            try {
                return Double.parseDouble(((NumberConstantExpr) expr).value);
            } catch (NumberFormatException e) {
                return null;
            }
        } else if (expr instanceof UnaryOpExpr) {
            UnaryOpExpr u = (UnaryOpExpr) expr;
            Double val = getConstantValue(u.operand);
            if (val != null) {
                if ("-".equals(u.op)) {
                    return -val;
                } else if ("+".equals(u.op)) {
                    return val;
                }
            }
        }
        return null;
    }

    private static boolean exprHasComparisonOutOfRange(Expression expr, String var) {
        if (expr == null) return false;

        if (expr instanceof BinaryOpExpr) {
            BinaryOpExpr b = (BinaryOpExpr) expr;
            String op = b.op;
            if ("=".equals(op) || "<>".equals(op) || "<".equals(op) || "<=".equals(op) || ">".equals(op) || ">=".equals(op)) {
                // Check left as var, right as out-of-range constant
                if (b.left instanceof VariableExpr && ((VariableExpr) b.left).name.equals(var)) {
                    Double val = getConstantValue(b.right);
                    if (val != null && (val <= -32768.0 || val >= 32767.0)) {
                        return true;
                    }
                }
                // Check right as var, left as out-of-range constant
                if (b.right instanceof VariableExpr && ((VariableExpr) b.right).name.equals(var)) {
                    Double val = getConstantValue(b.left);
                    if (val != null && (val <= -32768.0 || val >= 32767.0)) {
                        return true;
                    }
                }
            }
            // Recurse on left and right operands
            return exprHasComparisonOutOfRange(b.left, var) || exprHasComparisonOutOfRange(b.right, var);
        } else if (expr instanceof UnaryOpExpr) {
            return exprHasComparisonOutOfRange(((UnaryOpExpr) expr).operand, var);
        } else if (expr instanceof FunctionCallExpr) {
            for (Expression arg : ((FunctionCallExpr) expr).args) {
                if (exprHasComparisonOutOfRange(arg, var)) {
                    return true;
                }
            }
        } else if (expr instanceof ArrayAccessExpr) {
            for (Expression arg : ((ArrayAccessExpr) expr).args) {
                if (exprHasComparisonOutOfRange(arg, var)) {
                    return true;
                }
            }
        }
        return false;
    }

    private static boolean stmtHasComparisonOutOfRange(Statement stmt, String var) {
        if (stmt instanceof ForStatement) {
            ForStatement fs = (ForStatement) stmt;
            return exprHasComparisonOutOfRange(fs.start, var) ||
                    exprHasComparisonOutOfRange(fs.end, var) ||
                    exprHasComparisonOutOfRange(fs.step, var);
        } else if (stmt instanceof AssignmentStatement) {
            AssignmentStatement as = (AssignmentStatement) stmt;
            return exprHasComparisonOutOfRange(as.expression, var);
        } else if (stmt instanceof IfStatement) {
            IfStatement is = (IfStatement) stmt;
            return exprHasComparisonOutOfRange(is.condition, var);
        }
        return false;
    }

    private static boolean isComparisonOp(Token t) {
        return t.type == TokenType.EQUAL || t.type == TokenType.NOT_EQUAL ||
                t.type == TokenType.LESS_THAN || t.type == TokenType.LESS_EQUAL ||
                t.type == TokenType.GREATER_THAN || t.type == TokenType.GREATER_EQUAL;
    }

    private static Double getConstantFromTokens(List<Token> tokens, int startIdx) {
        if (startIdx >= tokens.size()) return null;
        Token t = tokens.get(startIdx);
        if (t.type == TokenType.NUMBER) {
            try {
                return Double.parseDouble(t.value);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        if ((t.type == TokenType.PLUS || t.type == TokenType.MINUS) && startIdx + 1 < tokens.size()) {
            Token next = tokens.get(startIdx + 1);
            if (next.type == TokenType.NUMBER) {
                try {
                    double val = Double.parseDouble(next.value);
                    return t.type == TokenType.MINUS ? -val : val;
                } catch (NumberFormatException e) {
                    return null;
                }
            }
        }
        return null;
    }

    private static Double getConstantFromTokensBackwards(List<Token> tokens, int endIdx) {
        if (endIdx < 0) return null;
        Token t = tokens.get(endIdx);
        if (t.type == TokenType.NUMBER) {
            if (endIdx - 1 >= 0) {
                Token prev = tokens.get(endIdx - 1);
                if (prev.type == TokenType.PLUS || prev.type == TokenType.MINUS) {
                    try {
                        double val = Double.parseDouble(t.value);
                        return prev.type == TokenType.MINUS ? -val : val;
                    } catch (NumberFormatException e) {
                        return null;
                    }
                }
            }
            try {
                return Double.parseDouble(t.value);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }

    private static boolean tokensHaveComparisonOutOfRange(List<Token> tokens, String var) {
        for (int i = 0; i < tokens.size(); i++) {
            Token t = tokens.get(i);
            if (t.type == TokenType.IDENTIFIER && normalizeVariableName(t.value).equals(var)) {
                if (i + 1 < tokens.size() && isComparisonOp(tokens.get(i + 1))) {
                    Double val = getConstantFromTokens(tokens, i + 2);
                    if (val != null && (val < -32768.0 || val > 32767.0)) {
                        return true;
                    }
                }
                if (i - 1 >= 0 && isComparisonOp(tokens.get(i - 1))) {
                    Double val = getConstantFromTokensBackwards(tokens, i - 2);
                    if (val != null && (val < -32768.0 || val > 32767.0)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    // --- Main Analyzer Logic ---
    public static AnalysisResult analyzeProgram(List<String> lines) {
        List<Statement> allStatements = new ArrayList<>();
        Set<String> allVariables = new HashSet<>();
        Set<String> loopVariables = new HashSet<>();
        List<List<Token>> allProgramTokens = new ArrayList<>();
        boolean hasFloatData = false;

        // 1. Tokenize and parse all statements
        for (int lineIdx = 0; lineIdx < lines.size(); lineIdx++) {
            String line = lines.get(lineIdx);
            if (line.trim().isEmpty()) continue;

            List<Token> tokens = tokenizeLine(line, lineIdx + 1);
            allProgramTokens.add(tokens);
            for (Token t : tokens) {
                if (t.type == TokenType.IDENTIFIER) {
                    allVariables.add(normalizeVariableName(t.value));
                }
            }

            List<Statement> stmts = parseTokens(tokens);
            allStatements.addAll(stmts);
        }

        // Helper to recursively collect nested statements from IFs
        List<Statement> flatStatements = new ArrayList<>();
        collectFlatStatements(allStatements, flatStatements);

        // Check for float data and loop variables
        for (Statement stmt : flatStatements) {
            if (stmt instanceof ForStatement) {
                loopVariables.add(((ForStatement) stmt).variable);
            } else if (stmt instanceof DataStatement) {
                for (Token t : ((DataStatement) stmt).constants) {
                    if (isFloatDataToken(t)) {
                        hasFloatData = true;
                    }
                }
            }
        }

        // 2. Filter candidate variables for iterative solver
        // Only float variables (no %, no $) that are not system-reserved (TI, ST) are candidates for optimization
        Set<String> candidates = new HashSet<>();
        for (String var : allVariables) {
            if (!var.endsWith("%") && !var.endsWith("$") && !var.equals("TI") && !var.equals("ST")) {
                candidates.add(var);
            }
        }

        // 3. Iterative type solver
        Set<String> safeSet = new HashSet<>(candidates);
        boolean changed = true;

        while (changed) {
            changed = false;
            Set<String> toRemove = new HashSet<>();

            for (String var : safeSet) {
                boolean isSafe = true;

                // Check all statements affecting var
                for (Statement stmt : flatStatements) {
                    // Check assignments to var
                    if (stmt instanceof AssignmentStatement) {
                        AssignmentStatement as = (AssignmentStatement) stmt;
                        if (as.variable.equals(var)) {
                            if (as.expression == null || !as.expression.isIntegerValued(safeSet)) {
                                isSafe = false;
                                break;
                            }
                        }
                    }

                    // Check FOR loop counter properties if var is the counter
                    if (stmt instanceof ForStatement) {
                        ForStatement fs = (ForStatement) stmt;
                        if (fs.variable.equals(var)) {
                            if (fs.start == null || !fs.start.isIntegerValued(safeSet)) {
                                isSafe = false;
                                break;
                            }
                            if (fs.end == null || !fs.end.isIntegerValued(safeSet)) {
                                isSafe = false;
                                break;
                            }
                            if (fs.step != null) {
                                if (!fs.step.isIntegerValued(safeSet)) {
                                    isSafe = false;
                                    break;
                                }
                                // Check if step is constant 0
                                if (fs.step instanceof NumberConstantExpr) {
                                    try {
                                        double stepVal = Double.parseDouble(((NumberConstantExpr) fs.step).value);
                                        if (stepVal == 0.0) {
                                            isSafe = false;
                                            break;
                                        }
                                    } catch (NumberFormatException e) {
                                        // Ignore
                                    }
                                }
                            }
                        }
                    }

                    // Check INPUT statements targeting var
                    if (stmt instanceof InputStatement) {
                        if (((InputStatement) stmt).variables.contains(var)) {
                            isSafe = false;
                            break;
                        }
                    }

                    // Check GET statements targeting var
                    if (stmt instanceof GetStatement) {
                        if (((GetStatement) stmt).variables.contains(var)) {
                            isSafe = false;
                            break;
                        }
                    }

                    // Check READ statements targeting var
                    if (stmt instanceof ReadStatement) {
                        if (((ReadStatement) stmt).variables.contains(var)) {
                            if (hasFloatData) {
                                isSafe = false;
                                break;
                            }
                        }
                    }

                    // Check if var is compared to an out-of-range value via AST expression
                    if (stmtHasComparisonOutOfRange(stmt, var)) {
                        isSafe = false;
                        break;
                    }
                }

                // Check if var is compared to an out-of-range value via token scanning
                if (isSafe) {
                    for (List<Token> toks : allProgramTokens) {
                        if (tokensHaveComparisonOutOfRange(toks, var)) {
                            isSafe = false;
                            break;
                        }
                    }
                }

                if (!isSafe) {
                    toRemove.add(var);
                }
            }

            if (!toRemove.isEmpty()) {
                safeSet.removeAll(toRemove);
                changed = true;
            }
        }

        // 4. Return both sets
        Set<String> safeLoops = new HashSet<>(loopVariables);
        safeLoops.retainAll(safeSet);
        return new AnalysisResult(safeLoops, safeSet);
    }

    private static void collectFlatStatements(List<Statement> source, List<Statement> target) {
        for (Statement s : source) {
            if (s != null) {
                target.add(s);
                if (s instanceof IfStatement) {
                    IfStatement is = (IfStatement) s;
                    if (is.body != null) {
                        collectFlatStatements(Collections.singletonList(is.body), target);
                    }
                }
            }
        }
    }

    // --- CLI Entry Point & Self Tests ---
    public static void main(String[] args) {
        if (args.length > 0) {
            // Read and analyze file
            String filePath = args[0];
            try {
                List<String> lines = Files.readAllLines(Paths.get(filePath));
                AnalysisResult result = analyzeProgram(lines);
                System.out.println("Analysis complete for: " + filePath);
                System.out.println("Safe integer loop variables: " + result.safeLoopVariables);
                System.out.println("All safe integer variables:   " + result.safeIntegerVariables);
            } catch (IOException e) {
                System.err.println("Error reading file: " + e.getMessage());
            }
        } else {
            // Run internal self test suite
            runSelfTests();
        }
    }

    private static void runSelfTests() {
        System.out.println("Running BasicLoopAnalyzer Self Tests...\n");
        int passed = 0;
        int failed = 0;

        // Test Case 1: Simple Safe Loop
        List<String> tc1 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 PRINT I",
                "30 NEXT I"
        );
        if (verifyTestCase("Simple Safe Loop", tc1, Collections.singleton("I"))) passed++; else failed++;

        // Test Case 2: Unsafe Float Bound
        List<String> tc2 = Arrays.asList(
                "10 FOR I = 1 TO 10.5",
                "20 PRINT I",
                "30 NEXT I"
        );
        if (verifyTestCase("Unsafe Float Bound", tc2, Collections.emptySet())) passed++; else failed++;

        // Test Case 3: Unsafe Float Step
        List<String> tc3 = Arrays.asList(
                "10 FOR I = 1 TO 10 STEP 0.5",
                "20 PRINT I",
                "30 NEXT I"
        );
        if (verifyTestCase("Unsafe Float Step", tc3, Collections.emptySet())) passed++; else failed++;

        // Test Case 4: Unsafe Float Assignment inside loop
        List<String> tc4 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 I = 3.5",
                "30 NEXT I"
        );
        if (verifyTestCase("Unsafe Float Assignment", tc4, Collections.emptySet())) passed++; else failed++;

        // Test Case 5: Large Constant Bound (outside 16-bit signed range)
        List<String> tc5 = Arrays.asList(
                "10 FOR I = 1 TO 40000",
                "20 PRINT I",
                "30 NEXT I"
        );
        if (verifyTestCase("Large Constant Bound", tc5, Collections.emptySet())) passed++; else failed++;

        // Test Case 6: division assignment (always unsafe)
        List<String> tc6 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 I = I / 2",
                "30 NEXT I"
        );
        if (verifyTestCase("Division Assignment", tc6, Collections.emptySet())) passed++; else failed++;

        // Test Case 7: Unsafe Input statement targeting loop variable
        List<String> tc7 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 INPUT I",
                "30 NEXT I"
        );
        if (verifyTestCase("Unsafe INPUT Statement", tc7, Collections.emptySet())) passed++; else failed++;

        // Test Case 8: Safe and Unsafe loops mixed
        List<String> tc8 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 FOR J = 1 TO 5 STEP 2",
                "30 FOR K = 1 TO 5 STEP 1.5",
                "40 NEXT K, J, I"
        );
        Set<String> expectedTc8 = new HashSet<>(Arrays.asList("I", "J"));
        if (verifyTestCase("Mixed Loops", tc8, expectedTc8)) passed++; else failed++;

        // Test Case 9: Dynamic MATCHING loops and subroutine modification
        List<String> tc9 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 GOSUB 100",
                "30 NEXT I",
                "40 END",
                "100 I = I + 2",
                "110 RETURN"
        );
        if (verifyTestCase("Dynamic NEXT & GOSUB Modification", tc9, Collections.singleton("I"))) passed++; else failed++;

        // Test Case 10: Array index and variables normalization
        List<String> tc10 = Arrays.asList(
                "10 FOR LOOPVAR = 1 TO 10",
                "20 A%(LO) = LO + 1",
                "30 NEXT LO"
        );
        // Normalized name for LOOPVAR and LO is LO. They should be detected as safe.
        if (verifyTestCase("Variable Name Normalization", tc10, Collections.singleton("LO"))) passed++; else failed++;

        // Test Case 11: Dependency propagation
        List<String> tc11 = Arrays.asList(
                "10 N = 10",
                "20 FOR I = 1 TO N",
                "30 NEXT I"
        );
        if (verifyTestCase("Dependency Propagation (Safe)", tc11, Collections.singleton("I"))) passed++; else failed++;

        // Test Case 12: Dependency propagation (Unsafe)
        List<String> tc12 = Arrays.asList(
                "10 N = 10.5",
                "20 FOR I = 1 TO N",
                "30 NEXT I"
        );
        if (verifyTestCase("Dependency Propagation (Unsafe)", tc12, Collections.emptySet())) passed++; else failed++;

        // Test Case 13: READ statement with integer data vs float data
        List<String> tc13a = Arrays.asList(
                "10 FOR I = 1 TO 5",
                "20 READ I",
                "30 NEXT I",
                "40 DATA 1, 2, 3, 4, 5"
        );
        if (verifyTestCase("READ Safe DATA", tc13a, Collections.singleton("I"))) passed++; else failed++;

        List<String> tc13b = Arrays.asList(
                "10 FOR I = 1 TO 5",
                "20 READ I",
                "30 NEXT I",
                "40 DATA 1, 2, 3.5, 4, 5"
        );
        if (verifyTestCase("READ Unsafe DATA", tc13b, Collections.emptySet())) passed++; else failed++;

        // Test Case 14: Unspaced code (spaces are ignored outside strings/comments in BASIC V2)
        List<String> tc14 = Arrays.asList(
                "10FORI=1TO10STEP2",
                "20PRINTI",
                "30NEXTI"
        );
        if (verifyTestCase("Unspaced Code", tc14, Collections.singleton("I"))) passed++; else failed++;

        // Test Case 15: General non-loop safe variable detection
        List<String> tc15 = Arrays.asList(
                "10 A = 5",
                "20 B = 10.5",
                "30 FOR I = 1 TO A",
                "40 NEXT I"
        );
        // I is safe loop variable. A is safe non-loop variable. B is unsafe non-loop variable.
        if (verifyTestCaseAll("Non-Loop Safe Variable Detection", tc15, Collections.singleton("I"), new HashSet<>(Arrays.asList("I", "A")))) passed++; else failed++;

        // Test Case 16: System-reserved variables exclusion (TI, ST) and getAllSafeVariables verification
        List<String> tc16 = Arrays.asList(
                "10 A = 5",
                "20 PRINT TI",
                "30 PRINT ST",
                "40 FOR I = 1 TO A",
                "50 NEXT I"
        );
        // TI and ST must be excluded. Safe variables union should be [I, A].
        if (verifyTestCaseUnion("System Variables Exclusion & Union Set", tc16, new HashSet<>(Arrays.asList("I", "A")))) passed++; else failed++;

        // Test Case 17: Variable compared to out-of-range positive constant in IF statement
        List<String> tc17 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 IF I > 40000 THEN PRINT I",
                "30 NEXT I"
        );
        if (verifyTestCase("Compare to Positive Out-Of-Range", tc17, Collections.emptySet())) passed++; else failed++;

        // Test Case 18: Variable compared to out-of-range negative constant in IF statement
        List<String> tc18 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 IF I < -32769 THEN PRINT I",
                "30 NEXT I"
        );
        if (verifyTestCase("Compare to Negative Out-Of-Range", tc18, Collections.emptySet())) passed++; else failed++;

        // Test Case 19: Variable compared to out-of-range constant in assignment
        List<String> tc19 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 A = I > 50000",
                "30 NEXT I"
        );
        if (verifyTestCase("Compare in Assignment", tc19, Collections.emptySet())) passed++; else failed++;

        // Test Case 20: Variable compared to out-of-range constant in print (token level scan test)
        List<String> tc20 = Arrays.asList(
                "10 FOR I = 1 TO 10",
                "20 PRINT I < -40000",
                "30 NEXT I"
        );
        if (verifyTestCase("Compare in Print Statement", tc20, Collections.emptySet())) passed++; else failed++;

        System.out.println(String.format("\nTest Run Complete. Passed: %d, Failed: %d", passed, failed));
    }

    private static boolean verifyTestCase(String name, List<String> lines, Set<String> expected) {
        Set<String> actual = analyzeProgram(lines).safeLoopVariables;
        boolean matches = actual.equals(expected);
        if (matches) {
            System.out.println(String.format("  [ PASS ] %s", name));
        } else {
            System.out.println(String.format("  [ FAIL ] %s", name));
            System.out.println(String.format("           Expected: %s", expected));
            System.out.println(String.format("           Actual:   %s", actual));
        }
        return matches;
    }

    private static boolean verifyTestCaseAll(String name, List<String> lines, Set<String> expectedLoops, Set<String> expectedAll) {
        AnalysisResult result = analyzeProgram(lines);
        boolean loopsMatch = result.safeLoopVariables.equals(expectedLoops);
        boolean allMatch = result.safeIntegerVariables.equals(expectedAll);
        boolean matches = loopsMatch && allMatch;
        if (matches) {
            System.out.println(String.format("  [ PASS ] %s", name));
        } else {
            System.out.println(String.format("  [ FAIL ] %s", name));
            if (!loopsMatch) {
                System.out.println(String.format("           Expected Loop: %s", expectedLoops));
                System.out.println(String.format("           Actual Loop:   %s", result.safeLoopVariables));
            }
            if (!allMatch) {
                System.out.println(String.format("           Expected All:  %s", expectedAll));
                System.out.println(String.format("           Actual All:    %s", result.safeIntegerVariables));
            }
        }
        return matches;
    }

    private static boolean verifyTestCaseUnion(String name, List<String> lines, Set<String> expectedUnion) {
        AnalysisResult result = analyzeProgram(lines);
        Set<String> actualUnion = result.getAllSafeVariables();
        boolean matches = actualUnion.equals(expectedUnion);
        if (matches) {
            System.out.println(String.format("  [ PASS ] %s", name));
        } else {
            System.out.println(String.format("  [ FAIL ] %s", name));
            System.out.println(String.format("           Expected Union: %s", expectedUnion));
            System.out.println(String.format("           Actual Union:   %s", actualUnion));
        }
        return matches;
    }
}
