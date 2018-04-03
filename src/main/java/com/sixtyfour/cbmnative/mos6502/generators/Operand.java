package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.HashSet;
import java.util.Set;

import com.sixtyfour.elements.Type;

/**
 * @author EgonOlsen
 * 
 */
public class Operand {

	private static final Set<String> INT_REGS = new HashSet<String>() {
		private static final long serialVersionUID = 1L;
		{
			this.add("A");
			this.add("B");
			this.add("G");
		}
	};

	private String register;
	private Type type;
	private String address;
	private String value;
	private boolean array;
	private boolean indexed;

	public String getRegister() {
		return register;
	}

	public String getRegisterName() {
		return register + "_REG";
	}

	public void setRegister(String register) {
		this.register = register;
		if (register != null) {
			type = Type.REAL;
			if (register.equalsIgnoreCase("A") || register.equalsIgnoreCase("B") || register.equalsIgnoreCase("G")) {
				type = Type.INTEGER;
			}
		}
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public String getAddress() {
		return address;
	}

	public boolean isConstant() {
		return address != null && address.startsWith("CONST");
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public boolean isIntegerRegister() {
		return INT_REGS.contains(register);
	}

	public boolean isIndexed() {
		return indexed;
	}

	public void setIndexed(boolean indexed) {
		this.indexed = indexed;
	}

	public boolean isRegister() {
		return register != null;
	}

	public boolean isAddress() {
		return address != null;
	}

	@Override
	public String toString() {
		return register + " / " + type + " / " + address + " / " + indexed;
	}

	public boolean isArray() {
		return array;
	}

	public void setArray(boolean array) {
		this.array = array;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
