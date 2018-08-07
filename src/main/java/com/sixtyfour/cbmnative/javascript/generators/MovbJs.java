package com.sixtyfour.cbmnative.javascript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;
import com.sixtyfour.elements.Type;

/**
 * @author EgonOlsen
 * 
 */
public class MovbJs extends MovJs {

    @Override
    public String getMnemonic() {
	return "MOVB";
    }

    @Override
    public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
	    Map<String, String> name2label) {
	Operands ops = new Operands(line, name2label);

	Operand source = ops.getSource();
	Operand target = ops.getTarget();

	context.setLastMoveSource(source);
	context.setLastMoveTarget(target);

	if (!source.isIndexed() && !target.isIndexed()) {
	    if (source.getType() == Type.INTEGER) {
		noIndexIntegerSource(nCode, source, target);
	    } else {
		noIndexRealSource(nCode, source, target);
	    }
	} else {
	    if (target.isIndexed() && source.isIndexed()) {
		throw new RuntimeException("Invalid index mode (both sides are indexed!): " + line);
	    }

	    if (!target.isRegister() || !source.isRegister()) {
		if (target.isRegister() && source.isConstant()) {
		    indexedTargetWithConstant(nCode, source, target);
		} else {
		    throw new RuntimeException(
			    "Invalid index mode (at least one side isn't a register and source isn't a constant value either!): "
				    + line);
		}
	    } else {
		if (target.isIndexed()) {
		    indexedTarget(nCode, source, target);
		} else {
		    indexedSource(nCode, source, target);
		}
	    }
	}
    }

    private void indexedTargetWithConstant(List<String> nCode, Operand source, Operand target) {
	String from = getOpName(source);
	String to = getOpName(target);
	nCode.add("this._memory[Math.floor(" + to + ")]=Math.floor(" + from + ") & 255;");
    }

    private void indexedSource(List<String> nCode, Operand source, Operand target) {
	String from = getOpName(source);
	String to = getOpName(target);
	nCode.add(to + "=this._memory[Math.floor(" + from + ") & 65535];");
    }

    private void indexedTarget(List<String> nCode, Operand source, Operand target) {
	indexedTargetWithConstant(nCode, source, target);
    }

    private void noIndexRealSource(List<String> nCode, Operand source, Operand target) {
	String from = getOpName(source);
	String to = getOpName(target);
	
	if (isNumber(from)) {
	    from="this._memory["+from+"]";
	}
	if (isNumber(to)) {
	    to="this._memory["+to+"]";
	}
	
	nCode.add(to + "=Math.floor(" + from + ") & 255;");
    }

    private void noIndexIntegerSource(List<String> nCode, Operand source, Operand target) {
	noIndexRealSource(nCode, source, target);
    }

}
