package com.sixtyfour.extensions.x16.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen71
 *
 */
public class Dos extends AbstractCommand {

    private boolean command = false;
    private boolean status = false;
    private List<Atom> pars;

    /**
     * 
     */
    public Dos() {
	super("DOS");
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.sixtyfour.elements.commands.AbstractCommand#parse(com.sixtyfour.
     * config.CompilerConfig, java.lang.String, int, int, int, boolean,
     * com.sixtyfour.system.Machine)
     */
    @Override
    public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
	    boolean lastPos, Machine machine) {
	super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
	linePart = TermEnhancer.removeWhiteSpace(linePart);
	linePart = linePart.substring(this.name.length());
	if (linePart.trim().isEmpty()) {
	    linePart = "\"\"";
	}
	term = Parser.getTerm(config, linePart, machine, false, true);
	pars = Parser.getParameters(term);

	if (pars.size() > 1) {
	    syntaxError(this);
	}
	if (pars.size() > 0 && !pars.get(0).getType().equals(Type.STRING)) {
	    syntaxError(this);
	}

	if (pars.size() == 0 || (pars.get(0).isConstant() && ((String) pars.get(0).eval(machine)).isEmpty())) {
	    status = true;
	} else {
	    command = true;
	}

	return null;
    }

    @Override
    public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
	// Do nothing in the local runtime for now.
	return null;
    }

    @Override
    public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
	NativeCompiler compiler = NativeCompiler.getCompiler();
	List<String> after = new ArrayList<String>();
	List<String> expr = new ArrayList<String>();
	List<String> before = new ArrayList<String>();

	try {
	    if (command) {
		expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(0)));
		expr.add("POP G");
		after.add("JSR DOSCALL");
	    } else if (status) {
		after.add("JSR DOSSTAT");
	    } else {
		syntaxError(this);
	    }

	} catch (ClassCastException e) {
	    syntaxError(this);
	}

	CodeContainer cc = new CodeContainer(before, expr, after);
	List<CodeContainer> ccs = new ArrayList<CodeContainer>();
	ccs.add(cc);
	return ccs;
    }

}
