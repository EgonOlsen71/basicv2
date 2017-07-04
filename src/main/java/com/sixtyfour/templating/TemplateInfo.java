package com.sixtyfour.templating;

import java.io.File;

/**
 * @author EgonOlsen
 * 
 */
public class TemplateInfo {
	private String path;
	private String basicCode;
	private long modified;

	public TemplateInfo(String path) {
		this.path = path;
		File file = new File(path);
		modified = file.lastModified();
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getBasicCode() {
		return basicCode;
	}

	public void setBasicCode(String basicCode) {
		this.basicCode = basicCode;
	}

	public boolean hasChanged() {
		File file = new File(path);
		long modi = file.lastModified();
		if (modi != modified) {
			modified = modi;
			return true;
		}
		return false;
	}

	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}
		if (o instanceof TemplateInfo) {
			TemplateInfo ti = (TemplateInfo) o;
			return path.equals(ti.path);
		}
		return false;
	}

	@Override
	public int hashCode() {
		return path.hashCode();
	}
}
