package com.sixtyfour.cbmnative.mos6502.x16;

import java.util.Locale;

import com.sixtyfour.Basic;
import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.Unlinker;
import com.sixtyfour.cbmnative.mos6502.Optimizer6502;
import com.sixtyfour.cbmnative.mos6502.Unlinker6502;
import com.sixtyfour.cbmnative.mos6502.x16.generators.MovX;
import com.sixtyfour.cbmnative.mos6502.x16.generators.MovbX;
import com.sixtyfour.cbmnative.mos6502.x16.generators.RndX;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.extensions.x16.X16Extensions;

/**
 * A PlatformProvider implementation for the X16 target platform.
 * 
 * @author EgonOlsen
 *
 */
public class PlatformX16 implements PlatformProvider {

	@Override
	public int getStackSize() {
		return 20;
	}

	@Override
	public int getForStackSize() {
		return 20;
	}

	@Override
	public Optimizer getOptimizer() {
		return new Optimizer6502();
	}

	@Override
	public Transformer getTransformer() {
		return new TransformerX16();
	}

	@Override
	public Unlinker getUnlinker() {
		return new Unlinker6502();
	}

	@Override
	public boolean useLooseTypes() {
		return true;
	}

	@Override
	public int getMaxHeaderAddress() {
		return 2100;
	}

	@Override
	public int getBaseAddress() {
		return 2049;
	}

	@Override
	public int getBasicMemoryEndAddress() {
		return 40703;
	}

	@Override
	public void overrideConfig(CompilerConfig conf) {
		conf.setNonDecimalNumbersAware(true);
		conf.setEnhancedInstructionSet(true);
		Basic.registerExtension(new X16Extensions());
	}

	@Override
	public Generator getGenerator(String line) {
		line = line.trim().split(" ")[0].toUpperCase(Locale.ENGLISH);
		switch (line) {
		case "MOVB":
			return new MovbX();
		case "MOV":
			return new MovX();
		case "RND":
			return new RndX();
		default:
			return null;
		}
	}
}
