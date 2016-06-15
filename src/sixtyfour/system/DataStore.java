package sixtyfour.system;

import java.util.ArrayList;
import java.util.List;

public class DataStore {
	private int position = 0;
	private List<Object> datas = new ArrayList<Object>();

	public void restore() {
		position = 0;
	}

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

	public Object read() {
		if (position >= datas.size()) {
			System.out.println(position);
			return null;
		}
		return datas.get(position++);
	}

}
