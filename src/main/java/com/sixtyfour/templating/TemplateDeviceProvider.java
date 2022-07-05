package com.sixtyfour.templating;

import java.util.Map.Entry;

import com.sixtyfour.Basic;
import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.impl.MemoryDeviceProvider;
import com.sixtyfour.system.Machine;

/**
 * A device provider implementation used in templates to add support for the
 * load-command to include other templates.
 * 
 * @author EgonOlsen
 * 
 */
public class TemplateDeviceProvider extends MemoryDeviceProvider {
	private Template baseTemplate;

	/**
	 * @param consoleOutput
	 */
	public TemplateDeviceProvider(Basic basic, Template baseTemplate) {
		super(basic.getOutputChannel());
		this.baseTemplate = baseTemplate;
	}

	@Override
	public void load(CompilerConfig config, String fileName, int device, int secondary) {
		if (device == 8) {
			TemplateManager tm = TemplateManager.getInstance();

			String baseName = baseTemplate.getPath().replace('\\', '/');
			int pos = baseName.lastIndexOf('/');
			if (pos != -1) {
				baseName = baseName.substring(0, pos + 1);
				if (fileName.startsWith("/") || fileName.startsWith("\\")) {
					fileName = fileName.substring(1);
				}
				fileName = baseName + fileName;
			}

			Template tmpl = tm.getTemplate(fileName);
			OutputChannel oo = baseTemplate.getMachine().getOutputChannel();

			try {
				Machine base = baseTemplate.getMachine();
				for (Entry<String, Variable> entry : base.getVariables().entrySet()) {
					if (entry.getValue().isSystem()) {
						continue;
					}
					tmpl.getMachine().addOrSet(entry.getValue());
				}

				String result = tmpl.processPart();
				oo.print(0, result);
			} finally {
				//
			}
		} else {
			Logger.log("Device not found, load call ignored: " + device);
		}

	}

}
