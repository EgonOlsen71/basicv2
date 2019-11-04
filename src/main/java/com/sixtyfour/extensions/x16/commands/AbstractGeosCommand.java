package com.sixtyfour.extensions.x16.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen71
 *
 */
public class AbstractGeosCommand extends AbstractCommand {

    /** The pars. */
   protected List<Atom> pars;
    
    public AbstractGeosCommand(String name) {
	super(name);
    }
    
    @Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(config, this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.size() < 4 || pars.size() > 5) {
			syntaxError(linePart);
		}

		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.STRING, Type.STRING);
		return null;
	}
    
    protected List<CodeContainer> evalToCode(CompilerConfig config, Machine machine, String callLabel) {
		Atom xs = pars.get(0);
		Atom ys = pars.get(1);
		Atom xe = pars.get(2);
		Atom ye = pars.get(3);
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> before = new ArrayList<String>();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();

		expr.addAll(compiler.compileToPseudoCode(config, machine, xs));
		expr.addAll(compiler.compileToPseudoCode(config, machine, ys));
		expr.addAll(compiler.compileToPseudoCode(config, machine, xe));
		expr.addAll(compiler.compileToPseudoCode(config, machine, ye));

		if (pars.size()==5) {
		    // Color given
		    expr.addAll(compiler.compileToPseudoCode(config, machine, pars.get(4)));
		    after.add("POP C");
		} else {
		    // No color given
		    after.add("MOV C,#0{REAL}");
		}
		
		after.add("POP E");
		after.add("POP D");
		after.add("POP Y");
		after.add("POP X");
		after.add("JSR "+callLabel);

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

}
