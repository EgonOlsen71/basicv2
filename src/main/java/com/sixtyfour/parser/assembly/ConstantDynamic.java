package com.sixtyfour.parser.assembly;

import com.sixtyfour.config.CompilerConfig;

public class ConstantDynamic implements ConstantValue {

	private String name;
	private String value;
	private CompilerConfig config;
	private ConstantsContainer ccon;

	public ConstantDynamic(String left, String right, CompilerConfig config, ConstantsContainer ccon) {
		this.name = left;
		this.value = right;
		this.config = config;
		this.ccon = ccon;
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public int getValue() {
		return apply().getValue();
	}

	@Override
	public String toString() {
		return name + "=" + value;
	}

	private ConstantValue apply() {
		ConstantValue cv = AssemblyParser.getConstant(config, name + "=" + value, ccon);
		if (cv instanceof ConstantDynamic) {
			// This happens, if the constant can't be resolved when it's first used. This might be ok,
			// because it's a simple label anyway...or it's an error because it's a calculation based
			// on an unresolved label. But I can't detect this here...:-(
		    return new ConstantByte(name, 0);
			
		}
		return cv;
	}

}
