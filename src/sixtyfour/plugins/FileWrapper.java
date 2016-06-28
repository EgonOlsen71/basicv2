package sixtyfour.plugins;

import java.util.ArrayList;
import java.util.List;

public class FileWrapper {
	private int deviceNumber;
	private int secondaryAddress;
	private FileType fileType;
	private String fileName;
	private FileMode mode;
	private int recordLength;
	private List<String> content;
	private int position = 0;
	private int pointer = 0;
	private String contentAsString;

	public FileWrapper() {
		content = new ArrayList<String>();
	}

	public int getRecordLength() {
		return recordLength;
	}

	public void setRecordLength(int recordLength) {
		this.recordLength = recordLength;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getDeviceNumber() {
		return deviceNumber;
	}

	public void setDeviceNumber(int deviceNumber) {
		this.deviceNumber = deviceNumber;
	}

	public int getSecondaryAddress() {
		return secondaryAddress;
	}

	public void setSecondaryAddress(int secondaryAddress) {
		this.secondaryAddress = secondaryAddress;
	}

	public List<String> getContent() {
		return content;
	}

	public void setContent(List<String> content) {
		this.content = content;
		reset();
	}

	public void print(String txt) {
		// System.out.print(txt);
		this.content.add(txt);
		position++;
	}

	public FileType getFileType() {
		return fileType;
	}

	public void setFileType(FileType fileType) {
		this.fileType = fileType;
	}

	public FileMode getFileMode() {
		return mode;
	}

	public void setFileMode(FileMode mode) {
		this.mode = mode;
	}

	public int getPosition() {
		return position;
	}

	public int getPointer() {
		return pointer;
	}

	public void reset() {
		this.position = 0;
		this.pointer = 0;
	}

	public void nextPosition() {
		position++;
	}

	public void incPointer() {
		pointer++;
	}

	public String getContentAsString() {
		if (contentAsString == null) {
			StringBuilder sb = new StringBuilder();
			for (String line : content) {
				sb.append(line);
			}
			contentAsString = sb.toString();
		}
		return contentAsString;
	}

}
