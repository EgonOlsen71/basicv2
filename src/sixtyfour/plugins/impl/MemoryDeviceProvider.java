package sixtyfour.plugins.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import sixtyfour.plugins.DeviceProvider;
import sixtyfour.plugins.FileMode;
import sixtyfour.plugins.FileType;
import sixtyfour.plugins.FileWrapper;
import sixtyfour.plugins.OutputChannel;
import sixtyfour.plugins.PrintConsumer;

public class MemoryDeviceProvider implements DeviceProvider {
	private Map<Integer, FileWrapper> number2File = new HashMap<Integer, FileWrapper>();
	private List<FileWrapper> closedFiles = new ArrayList<FileWrapper>();
	private OutputChannel consoleOutput = null;

	public MemoryDeviceProvider(OutputChannel consoleOutput) {
		this.consoleOutput = consoleOutput;
	}

	public void close(int fileNumber) {
		if (!number2File.containsKey(fileNumber)) {
			return;
		}

		FileWrapper file = number2File.remove(fileNumber);
		if (file.getDeviceNumber() == 3) {
			dump(consoleOutput, file, fileNumber);
		}

		if (!file.getFileMode().equals(FileMode.READ) && !file.getFileMode().equals(FileMode.STATUS)) {
			closedFiles.add(file);
		}

		// debug output
		// for (String line : file.getContent())
		// {
		// System.out.print(line);
		// }
	}

	@Override
	public String inputString(int fileNumber) {
		return getFilePart(fileNumber);
	}

	@Override
	public char getChar(int fileNumber) {
		FileWrapper file = number2File.get(fileNumber);
		checkReadMode(fileNumber, file);
		if (file.getPointer() >= file.getContentAsString().length()) {
			throw new RuntimeException("File length exceeded: " + fileNumber);
		}
		char c = file.getContentAsString().charAt(file.getPointer());
		file.incPointer();
		return c;
	}

	@Override
	public Float inputNumber(int fileNumber) {
		String val = getFilePart(fileNumber);
		try {
			return Float.valueOf(val);
		} catch (Exception e) {
			throw new RuntimeException("Bad data error: " + val);
		}
	}

	@Override
	public void println(int fileNumber, String content) {
		print(fileNumber, content + "\n");
	}

	@Override
	public void print(int fileNumber, String content) {
		FileWrapper file = number2File.get(fileNumber);
		if (file == null) {
			throw new RuntimeException("File not open error: " + fileNumber);
		}
		if (file.getFileMode().equals(FileMode.READ)) {
			throw new RuntimeException("File not open for modifications: " + fileNumber);
		}
		file.print(content);
	}

	public void open(int fileNumber) {
		open(fileNumber, 1);
	}

	public void open(int fileNumber, int device) {
		open(fileNumber, device, 0);
	}

	public void open(int fileNumber, int device, int secondaryAddress) {
		open(fileNumber, device, secondaryAddress, "");
	}

	public boolean isOpen(int fileNumber) {
		return number2File.containsKey(fileNumber);
	}

	public void open(int fileNumber, int device, int secondaryAddress, String fileName) {
		FileWrapper file = new FileWrapper();
		file.setDeviceNumber(device);
		file.setFileName(fileName);
		file.setFileMode(FileMode.WRITE);
		file.setFileType(FileType.SEQ);
		file.reset();

		if (number2File.size() >= 10) {
			throw new RuntimeException("Too many files error!");
		}

		if (number2File.containsKey(fileNumber)) {
			throw new RuntimeException("File open error: " + fileNumber);
		}

		if (device < 0 || device > 11) {
			throw new RuntimeException("Device not present error: " + device);
		}

		number2File.put(fileNumber, file);

		// Floppy or Tape
		if (device >= 8 && device <= 11 || device == 1) {
			file.setFileMode(FileMode.READ);
			boolean explicitType = false;
			String[] nameParts = fileName.split(",");
			file.setFileName(nameParts[0]);
			if (nameParts.length > 1) {
				file.setFileType(FileType.getFileType(nameParts[1]));
				explicitType = true;
				if (nameParts.length > 2) {
					if (!file.getFileType().equals(FileType.REL)) {
						file.setFileMode(FileMode.getFileMode(nameParts[2]));
					} else {
						file.setFileMode(FileMode.WRITE);
						if (nameParts[2].length() == 0) {
							file.setRecordLength(0);
						} else {
							file.setRecordLength((int) nameParts[2].charAt(0));
						}
					}
				}
			}
			if (secondaryAddress == 0) {
				file.setFileMode(FileMode.READ);
				if (!explicitType) {
					file.setFileType(FileType.PRG);
				}
			} else if (secondaryAddress == 1) {
				file.setFileMode(FileMode.WRITE);
				if (!explicitType) {
					file.setFileType(FileType.PRG);
				}
			}

			if (file.getFileMode().equals(FileMode.MODIFY)) {
				for (FileWrapper fw : number2File.values()) {
					if (fw.getFileName().equals(file.getFileName())) {
						file.setContent(fw.getContent());
						break;
					}
				}
			}

			if (file.getFileMode().equals(FileMode.READ) || file.getFileMode().equals(FileMode.APPEND)) {
				for (FileWrapper fw : closedFiles) {
					if (fw.getFileName().equals(file.getFileName())) {
						file.setContent(fw.getContent());
						break;
					}
				}
			}
			if (file.getFileMode().equals(FileMode.WRITE) || file.getFileMode().equals(FileMode.APPEND)) {
				for (Iterator<FileWrapper> fitty = closedFiles.iterator(); fitty.hasNext();) {
					FileWrapper fw = fitty.next();
					if (fw.getFileName().equals(file.getFileName())) {
						fitty.remove();
						break;
					}
				}
			}
		} else {
			print(fileNumber, fileName);
		}

		if (secondaryAddress == 15) {
			file.setFileMode(FileMode.STATUS);
		}
	}

	@Override
	public void dump(PrintConsumer pc, FileWrapper file, int fileNumber) {
		for (String line : file.getContent()) {
			pc.print(fileNumber, line);
		}
	}

	private void checkReadMode(int fileNumber, FileWrapper file) {
		if (file == null) {
			throw new RuntimeException("File not open error: " + fileNumber);
		}
		if (!file.getFileMode().equals(FileMode.READ)) {
			throw new RuntimeException("File not open for reading: " + fileNumber);
		}
	}

	private String getFilePart(int fileNumber) {
		FileWrapper file = number2File.get(fileNumber);
		checkReadMode(fileNumber, file);
		String data = file.getContentAsString();
		int pos = file.getPosition();
		int cnt = 0;
		StringBuilder part = new StringBuilder();
		String ret = null;
		boolean inString = false;
		for (int i = 0; i < data.length(); i++) {
			char c = data.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '\n' || c == '\r' || c == ',' || c == ';' || c == ':') {
					if (cnt == pos) {
						ret = part.toString();
						break;
					} else {
						part.setLength(0);
						cnt++;
						continue;
					}
				}
			}
			part.append(c);
		}
		file.nextPosition();
		return ret;
	}

}
