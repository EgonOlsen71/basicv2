package com.sixtyfour.cbmnative;

import java.util.HashSet;
import java.util.Set;

import com.sixtyfour.elements.Type;

/**
 * A single operand
 * 
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

	/**
	 * Gets the register of this operand.
	 * 
	 * @return the register
	 */
	public String getRegister() {
		return register;
	}

	/**
	 * Gets the name of the register of the operand. This is the name that it gets
	 * in native code.
	 * 
	 * @return the name
	 */
	public String getRegisterName() {
		return register + "_REG";
	}

	/**
	 * Sets the register.
	 * 
	 * @param register the register
	 */
	public void setRegister(String register) {
		this.register = register;
		if (register != null) {
			type = Type.REAL;
			if (register.equalsIgnoreCase("A") || register.equalsIgnoreCase("B") || register.equalsIgnoreCase("G")) {
				type = Type.INTEGER;
			}
		}
	}

	/**
	 * Gets the type.
	 * 
	 * @return the type
	 */
	public Type getType() {
		return type;
	}

	/**
	 * Sets the type.
	 * 
	 * @param type the type
	 */
	public void setType(Type type) {
		this.type = type;
	}

	/**
	 * Gets the address.
	 * 
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * Sets the address.
	 * 
	 * @param address the address
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * Is it referencing a constant?
	 * 
	 * @return is it?
	 */
	public boolean isConstant() {
		return address != null && address.startsWith("CONST");
	}

	/**
	 * Is it referencing an integer register?
	 * 
	 * @return is it?
	 */
	public boolean isIntegerRegister() {
		return INT_REGS.contains(register);
	}

	/**
	 * Is it indexed?
	 * 
	 * @return is it?
	 */
	public boolean isIndexed() {
		return indexed;
	}

	/**
	 * Sets if it's indexed.
	 * 
	 * @param indexed is it indexed?
	 */
	public void setIndexed(boolean indexed) {
		this.indexed = indexed;
	}

	/**
	 * Is it a register?
	 * 
	 * @return is it?
	 */
	public boolean isRegister() {
		return register != null;
	}

	/**
	 * Is it an address?
	 * 
	 * @return is it?
	 */
	public boolean isAddress() {
		return address != null;
	}

	@Override
	public String toString() {
		return register + " / " + type + " / " + address + " / " + indexed;
	}

	/**
	 * Is it an array?
	 * 
	 * @return is it?
	 */
	public boolean isArray() {
		return array;
	}

	/**
	 * Set if it's an array.
	 * 
	 * @param array is it an array?
	 */
	public void setArray(boolean array) {
		this.array = array;
	}

	/**
	 * Returns the value.
	 * 
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * Sets the value
	 * 
	 * @param value the value
	 */
	public void setValue(String value) {
		this.value = value;
	}
}
