package com.sixtyfour.plugins.impl;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.mos6502.util.Converter;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.plugins.FileMode;
import com.sixtyfour.plugins.FileType;
import com.sixtyfour.plugins.FileWrapper;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.PrintConsumer;

/**
 * A simple implementation of a device provider that provides access to files in the working directory.
 */
public class FileDeviceProvider implements DeviceProvider {

	/** The number 2 file. */
	private Map<Integer, FileWrapper> number2File = new HashMap<Integer, FileWrapper>();

	/** The console output. */
	private OutputChannel consoleOutput = null;
	
	private String workDirectory;
	
	private int status = 0;

	/**
	 * Instantiates a new memory device provider.
	 * 
	 * @param consoleOutput the console output
	 */
	public FileDeviceProvider(OutputChannel consoleOutput, String workDirectory) {
		this.consoleOutput = consoleOutput;
		this.workDirectory = workDirectory;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#close(int)
	 */
	public void close(int fileNumber) {
		if (!number2File.containsKey(fileNumber)) {
			return;
		}

		FileWrapper file = number2File.remove(fileNumber);
		if (file.getDeviceNumber() == 3) {
			dump(consoleOutput, file, fileNumber);
		}
		if (file.getFileMode()==FileMode.APPEND || file.getFileMode()==FileMode.WRITE|| file.getFileMode()==FileMode.MODIFY) {
			writeToDisk(file);
		}
		status = 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#inputString(int)
	 */
	@Override
	public String inputString(int fileNumber) {
		return getFilePart(fileNumber);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#getChar(int)
	 */
	@Override
	public char getChar(int fileNumber) {
		FileWrapper file = number2File.get(fileNumber);
		checkReadMode(fileNumber, file);
		if (file.getDeviceNumber() == 3) {
			return ' ';
		}
		if (file.getPointer() >= file.getContentAsString().length()) {
			throw new RuntimeException("File length exceeded: " + fileNumber);
		}
		char c = file.getContentAsString().charAt(file.getPointer());
		file.incPointer();
		return c;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#inputNumber(int)
	 */
	@Override
	public Float inputNumber(int fileNumber) {
		String val = getFilePart(fileNumber);
		if (val.length() == 0) {
			val = "0";
		}
		try {
			return Float.valueOf(val);
		} catch (Exception e) {
			throw new RuntimeException("Bad data error: " + val);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.PrintConsumer#println(int, java.lang.String)
	 */
	@Override
	public void println(int fileNumber, String content) {
		print(fileNumber, content + "\n");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.PrintConsumer#print(int, java.lang.String)
	 */
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#open(int)
	 */
	public void open(int fileNumber) {
		open(fileNumber, 1);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#open(int, int)
	 */
	public void open(int fileNumber, int device) {
		open(fileNumber, device, 0);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#open(int, int, int)
	 */
	public void open(int fileNumber, int device, int secondaryAddress) {
		open(fileNumber, device, secondaryAddress, "tmp_" + System.nanoTime());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#isOpen(int)
	 */
	public boolean isOpen(int fileNumber) {
		return number2File.containsKey(fileNumber);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#open(int, int, int, java.lang.String)
	 */
	public void open(int fileNumber, int device, int secondaryAddress, String fileName) {
		//System.out.println("Open: "+fileName+"/"+device+"/"+secondaryAddress);
		FileWrapper file = new FileWrapper();
		file.setDeviceNumber(device);
		file.setFileName(fileName);
		file.setFileMode(FileMode.WRITE);
		file.setFileType(FileType.SEQ);
		file.reset();
		status = 0;

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
				readFromDisk(file);
			}
		} else {
			print(fileNumber, fileName);
		}

		if (secondaryAddress == 15) {
			file.setFileMode(FileMode.STATUS);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#dump(sixtyfour.plugins.PrintConsumer,
	 * sixtyfour.plugins.FileWrapper, int)
	 */
	@Override
	public void dump(PrintConsumer pc, FileWrapper file, int fileNumber) {
		for (String line : file.getContent()) {
			pc.print(fileNumber, line);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#save(java.lang.String, int, int)
	 */
	@Override
	public void save(String fileName, int device, int secondary) {
		// System.out.println(fileName + "/" + device + "/" + secondary);
		// Do nothing...
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#load(java.lang.String, int, int)
	 */
	@Override
	public void load(CompilerConfig config, String fileName, int device, int secondary) {
		// System.out.println(fileName + "/" + device + "/" + secondary);
		// Do nothing...
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.DeviceProvider#verify(java.lang.String, int, int)
	 */
	@Override
	public void verify(String fileName, int device, int secondary) {
		// System.out.println(fileName + "/" + device + "/" + secondary);
		// Do nothing...
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrint(int, java.lang.String)
	 */
	@Override
	public void systemPrint(int id, String txt) {
		this.print(id, txt);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.plugins.PrintConsumer#systemPrintln(int, java.lang.String)
	 */
	@Override
	public void systemPrintln(int id, String txt) {
		this.println(id, txt);
	}

	/**
	 * Check read mode.
	 * 
	 * @param fileNumber the file number
	 * @param file       the file
	 */
	private void checkReadMode(int fileNumber, FileWrapper file) {
		if (file == null) {
			throw new RuntimeException("File not open error: " + fileNumber);
		}
		if (!file.getFileMode().equals(FileMode.READ)) {
			throw new RuntimeException("File not open for reading: " + fileNumber+"/"+file.getFileMode());
		}
	}

	/**
	 * Gets the file part.
	 * 
	 * @param fileNumber the file number
	 * @return the file part
	 */
	private String getFilePart(int fileNumber) {
		FileWrapper file = number2File.get(fileNumber);
		checkReadMode(fileNumber, file);
		if (file.getDeviceNumber() == 3) {
			return "";
		}

		String data = file.getContentAsString();
		int pos = file.getPosition();
		int cnt = 0;
		StringBuilder part = new StringBuilder();
		String ret = null;
		boolean inString = false;
		int i;
		for (i = 0; i < data.length(); i++) {
			char c = data.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '\n' || c == '\r' || c == ',' || c == ':') {
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
		if (i+1 >= data.length()) {
			status = 64;
		}
		if (ret==null) {
			ret="";
			status = 64;
		}
		return ret;
	}
	
	private void writeToDisk(FileWrapper file) {
		throw new RuntimeException("not implemented: write to disk!");
	}
	
	private void readFromDisk(FileWrapper file) {
		try {
			File fily = new File(workDirectory, file.getFileName());
			List<String> content = new ArrayList<>(Arrays.asList(Loader.loadProgram(new FileInputStream(fily))));
			content = content.stream().map(p-> p.isBlank()?p:(p+"\n")).map(p -> Converter.convertCase(p, false)).collect(Collectors.toList());
			file.setContent(content);
		} catch(Exception e) {
			e.printStackTrace();
			throw new RuntimeException("file not found: "+file.getFileName());
		}
		
	}

	@Override
	public Integer getStatus() {
		return status;
	}
}
