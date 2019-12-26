package com.sixtyfour.system;

import java.util.ArrayList;
import java.util.List;

/**
 * This class contains a programs data stored in DATA lines as well as a pointer
 * to the currently active date.
 */
public class DataStore {

	/** The position */
	private int position = 0;

	/** The datas */
	private List<Object> datas = new ArrayList<Object>();

	/**
	 * Restores the data pointer, i.e. sets it to the first date.
	 */
	public void restore() {
		position = 0;
	}

	/**
	 * Returns the size of the current data store.
	 * 
	 * @return the size
	 */
	public int size() {
		return datas.size();
	}

	/**
	 * Adds a date. Internally, this will be converted to either an Integer or a
	 * Float or it will remain a String.
	 * 
	 * @param data the data
	 */
	public void add(String data) {
		if (data.startsWith("{STRING}")) {
			// Type indicated directly
			datas.add(data.substring(8));
			return;
		}
		try {
			Integer dat = Integer.valueOf(data.trim());
			datas.add(dat);
		} catch (NumberFormatException nfe) {
			try {
				Float dat = Float.valueOf(data.trim());
				datas.add(dat);
			} catch (NumberFormatException nfe2) {
				datas.add(data);
			}
		}
	}

	/**
	 * Reads the next date and increases the position pointer by one.
	 * 
	 * @return the data (can either be of type String, Integer, or Float)
	 */
	public Object read() {
		if (position >= datas.size()) {
			return null;
		}
		return datas.get(position++);
	}

	/**
	 * Clears the data store.
	 */
	public void clear() {
		restore();
		datas.clear();
	}

}
