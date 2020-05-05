package com.sixtyfour.parser.logic;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;

/**
 * A logic term.
 */
public class LogicTerm implements LogicBlock {

	/** The not. */
	private boolean not = false;

	/** The blocks. */
	private List<LogicBlock> blocks = new ArrayList<LogicBlock>();

	/** The ops. */
	private List<LogicOp> ops = new ArrayList<LogicOp>();

	/** The name. */
	private String name;

	/**
	 * Instantiates a new logic term.
	 * 
	 * @param name the name, which is an internal marker for this block used at
	 *             parse time.
	 */
	public LogicTerm(String name) {
		ops.add(new LogicAnd());
		this.name = name;
	}

	/**
	 * Adds a new logic block to the term.
	 * 
	 * @param block the new block
	 * @param op    the operation used between the two
	 */
	public void add(LogicBlock block, LogicOp op) {
		blocks.add(block);
		ops.add(op);
	}

	/**
	 * Returns the first logic operation if there is one.
	 * 
	 * @return the operation or null
	 */
	public LogicOp getFirstOperation() {
		if (ops.isEmpty() || blocks.size() < 2) {
			return null;
		}
		return ops.get(0);
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<CodeContainer> ret = new ArrayList<CodeContainer>();
		if (blocks.size() == 0) {
			return ret;
		}
		for (int i = 0; i < blocks.size(); i++) {
			LogicBlock nextBlock = blocks.get(i);
			ret.addAll(nextBlock.evalToCode(config, machine));
		}
		return ret;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.parser.logic.LogicBlock#evalToBoolean(sixtyfour.system.Machine)
	 */
	@Override
	public boolean evalToBoolean(Machine machine) {
		if (blocks.size() == 0) {
			return true;
		}
		boolean res = true;
		for (int i = 0; i < blocks.size(); i++) {
			LogicBlock nextBlock = blocks.get(i);
			LogicOp nextOp = ops.get(i);
			if (res || !nextOp.isAnd()) {
				// Skip unnecessary calculations (res is false AND something
				// will always be false anyway)
				res = nextOp.eval(machine, res, nextBlock);
			}
		}

		if (not) {
			res = !res;
		}
		return res;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.logic.LogicBlock#not()
	 */
	@Override
	public void not() {
		not = !not;
	}

	/**
	 * Gets the name.
	 * 
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Sets the name.
	 * 
	 * @param name the new name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		if (not) {
			sb.append(" NOT ");
		}
		for (int i = 0; i < blocks.size(); i++) {
			LogicBlock nextBlock = blocks.get(i);
			LogicOp nextOp = ops.get(i + 1);
			sb.append("(").append(nextBlock).append(" ").append(i != blocks.size() - 1 ? nextOp : "").append(")");
		}
		return sb.toString();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		boolean ok = evalToBoolean(machine);
		return ok ? -1 : 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#getType(boolean)
	 */
	@Override
	public Type getType(boolean ignoreMT) {
		return Type.INTEGER;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#toCode(com.sixtyfour.system.Machine)
	 */
	@Override
	public String toCode(Machine machine) {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#isConstant()
	 */
	@Override
	public boolean isConstant() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.logic.LogicBlock#getTerms()
	 */
	@Override
	public List<Term> getTerms() {
		List<Term> terms = new ArrayList<Term>();
		for (LogicBlock block : blocks) {
			terms.addAll(block.getTerms());
		}
		return terms;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}
		if (o instanceof LogicTerm) {

			boolean eq = true;

			int size0 = blocks.size();
			int size1 = ((LogicTerm) o).blocks.size();

			if (size0 != size1) {
				return false;
			}

			for (int i = 0; i < size0; i++) {
				LogicBlock lb0 = blocks.get(i);
				LogicBlock lb1 = ((LogicTerm) o).blocks.get(i);
				eq &= lb0.equals(lb1);
				if (!eq) {
					break;
				}
			}

			size0 = ops.size();
			size1 = ((LogicTerm) o).ops.size();

			if (size0 != size1) {
				return false;
			}

			for (int i = 0; i < size0; i++) {
				LogicOp lo0 = ops.get(i);
				LogicOp lo1 = ((LogicTerm) o).ops.get(i);
				eq &= lo0.equals(lo1);
				if (!eq) {
					break;
				}
			}
			return eq;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		// Not very elegant, but should do it for now...
		return name.hashCode();
	}

}
