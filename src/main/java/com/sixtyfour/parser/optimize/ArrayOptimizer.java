package com.sixtyfour.parser.optimize;

import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Dim;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.PotUtils;

/**
 * 
 * @author EgonOlsen
 *
 */
public class ArrayOptimizer {

	/**
	 * Optimizes access to x-dimensional array; x>1 at the expense of memory usage.
	 * @param machine
	 */
	public static void optimizeArrays(Machine machine) {
		List<Command> coms = machine.getCommandList();
		
		for (Command com:coms) {
			if (com instanceof Dim) {
				Dim dim = (Dim) com;
				List<Variable> vars = dim.getVars();
				for (Variable var:vars) {
					List<Atom> terms = dim.getTerms(var);
					if (terms.size()>1) {
						Atom term = terms.get(0);
						if (term instanceof Constant && term.getType() == Type.INTEGER) {
							int val = ((Number) term.eval(machine)).intValue()+1;
							int nextPot = PotUtils.getNearestPot(val);
							if (nextPot!=-1 && nextPot>val) {
								term = new Constant<Integer>(nextPot-1);
								terms.set(0, term);
								Logger.log("Extending array dimension of "+var.getName()+" to: "+(nextPot-1));
							}
						}
					}
				}
			}
		}
	}
	
	/**
	 * Optimizes the index term for multidimensional arrays if possible. Don't call
	 * this method on other terms or it will break your term. This method operates
	 * on the string representation of the term. It would have been nicer to apply
	 * these optimizations either on the term tree or while creating the term...but
	 * anyway...
	 * 
	 * @param term the index term
	 * @return the optimized term
	 */
	public static String optimizeLinearIndexTerm(String term) {
		int pos = 0;
		do {
			int lenTerm = term.length();
			pos = term.indexOf("int(", pos);
			if (pos != -1) {
				int sp = pos + 4;
				int ep = term.indexOf(")", sp);
				if (ep != -1) {
					String ns = term.substring(sp, ep);
					if (Parser.isInteger(ns) && ep < term.length() - 2 && term.charAt(ep + 1) == '*') {
						// Actually, this could be extended to handle floating point constants as well,
						// but
						// who uses those into constant array indices anyway?
						int fv = Integer.parseInt(ns);
						int sp1 = term.indexOf("+", ep);
						if (sp1 != -1) {
							ns = term.substring(ep + 2, sp1);
						} else {
							ns = term.substring(ep + 2);
						}
						ns = ns.substring(1, ns.length() - 1);
						if (Parser.isInteger(ns)) {
							int sv = Integer.parseInt(ns);
							int tv = fv * sv;
							if (tv == 0) {
								term = term.substring(0, pos > 0 ? pos - 1 : pos)
										+ (sp1 != -1 ? term.substring(sp1) : "");
							} else {
								term = term.substring(0, pos) + tv + (sp1 != -1 ? term.substring(sp1) : "");
							}
							pos = pos - (lenTerm - term.length());
						}
					} else {
						pos = ep;
					}
				} else {
					pos = sp;
				}
			}
		} while (pos != -1);
		return term;
	}
	
}
