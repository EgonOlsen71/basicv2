package sixtyfour.system;

import java.util.ArrayList;
import java.util.List;

/**
 * The Class DataStore.
 */
public class DataStore {
	
	/** The position. */
	private int position = 0;
	
	/** The datas. */
	private List<Object> datas = new ArrayList<Object>();

	/**
	 * Restore.
	 */
	public void restore() {
		position = 0;
	}

	/**
	 * Adds the.
	 * 
	 * @param data
	 *            the data
	 */
	public void add(String data) {
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
	 * Read.
	 * 
	 * @return the object
	 */
	public Object read() {
		if (position >= datas.size()) {
			System.out.println(position);
			return null;
		}
		return datas.get(position++);
	}

}
