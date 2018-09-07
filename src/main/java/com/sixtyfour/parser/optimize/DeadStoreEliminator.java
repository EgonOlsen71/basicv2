package com.sixtyfour.parser.optimize;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.sixtyfour.Basic;
import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Let;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;

/**
 * Eliminates dead variable stores from the code.
 * 
 * @author EgonOlsen
 * 
 */
public class DeadStoreEliminator {

	/**
	 * Eliminates dead variable stores from the code.
	 * 
	 * @param config the compiler configuration
	 * @param basic the Basic instance
	 * @return true, if something has been optimized
	 */
	public static boolean eliminateDeadStores(CompilerConfig config, Basic basic) {
		if (config.isDeadStoreElimination()) {
			Logger.log("Eliminating dead stores...");
			List<Command> commands = basic.getMachine().getCommandList();
			Set<Term> terms = new HashSet<Term>();

			// Collect all the terms used in the program first...
			for (Command cmd : commands) {
				List<Term> cmdTerms = cmd.getAllTerms();
				for (Term cmdTerm : cmdTerms) {
					if (cmdTerm != null && !ConstantPropagator.checkForConstant(config, basic.getMachine(), cmdTerm)) {
						terms.add(cmdTerm);
					}
				}
			}

			// Then check LETs, if a variable that has a value assigned to it is
			// actually used anywhere...

			List<Command> toRemove = new ArrayList<Command>();
			for (Command cmd : commands) {
				if (cmd.isCommand("LET")) {
					Let let = (Let) cmd;
					String varName = let.getVar().getUpperCaseName();
					if (!config.isDeadStoreEliminationOfStrings()) {
						if (varName.contains("$")) {
							continue;
						}
					}
					// System.out.println(let.getVar()+"/"+let.getVar().isSupposedToBeArray());
					if (varName.equals("TI$") || let.getVar().isSupposedToBeArray()) {
						continue;
					}
					boolean found = findVariableInTerms(varName, terms);
					if (!found) {
						toRemove.add(cmd);
					}
				}
			}

			basic.removeCommands(toRemove);

			return toRemove.size() > 0;
		} else {
			return false;
		}
	}

	private static boolean findVariableInTerms(String varName, Set<Term> terms) {
		boolean found = false;
		for (Term term : terms) {
			found |= findVariable(varName, term);
			if (found) {
				break;
			}
		}
		return found;
	}

	private static boolean findVariable(String varName, Term term) {
		boolean found = false;
		Atom left = term.getLeft();
		Atom right = term.getRight();

		if (left != null && left.isTerm()) {
			found = findVariable(varName, (Term) left);
		}
		if (!found && right != null && right.isTerm()) {
			found = findVariable(varName, (Term) right);
		}

		if (!found && left != null && left instanceof Function) {
			found = findVariable(varName, ((Function) left).getTerm());
		}

		if (!found && right != null && right instanceof Function) {
			found = findVariable(varName, ((Function) right).getTerm());
		}

		if (!found && left != null && left instanceof Variable) {
			found = ((Variable) left).getUpperCaseName().equals(varName);
		}

		if (!found && right != null && right instanceof Variable) {
			found = ((Variable) right).getUpperCaseName().equals(varName);
		}
		return found;
	}
}
