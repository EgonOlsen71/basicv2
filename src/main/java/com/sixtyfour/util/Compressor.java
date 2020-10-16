package com.sixtyfour.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.Loader;

/**
 * A simple compressor that can compress and uncompress byte[]-arrays based on a
 * simple and most likely inefficient sliding window algorithm that I came with
 * while being half asleep.
 * 
 * Not used for anything ATM, but it might get some use later...
 * 
 * @author EgonOlsen
 *
 */
public class Compressor {

	public static boolean FAST = true;

	private static final int MAX_WINDOW_SIZE = 128;
	private static final int MIN_WINDOW_SIZE = 12;
	private static final int CHUNK_SIZE = 32768;

	public static void main(String[] args) throws Exception {
		
		// testCompressor("C:\\Users\\EgonOlsen\\Desktop\\test.txt");
		// testCompressor("C:\\Users\\EgonOlsen\\Desktop\\++affine.prg");
		// testCompressor("C:\\Users\\EgonOlsen\\Desktop\\affine.bas");
		// testCompressor("C:\\Users\\EgonOlsen\\Desktop\\++corona.prg");
		testCompressor("E:\\src\\workspace2018\\Adventure\\build\\++xam.prg");
		
	}

	private static void testCompressor(String fileName) throws Exception {
		log("Compressing " + fileName);
		byte[] bytes = Loader.loadBlob(fileName);
		byte[] compressedBytes = compress(bytes);
		// byte[] uncompressedBytes = decompress(compressedBytes);
		byte[] uncompressedBytes = decompressInMemory(compressedBytes);
		log("Uncompressed size: " + uncompressedBytes.length);
		log("Equals: " + Arrays.equals(bytes, uncompressedBytes));

		/*
		 * System.out.println(
		 * "###########################################################");
		 * System.out.println(new String(bytes, "ISO-8859-1")); System.out.println(
		 * "###########################################################");
		 * System.out.println(new String(uncompressedBytes, "ISO-8859-1"));
		 */
	}

	public static byte[] compress(byte[] dump) {
		long time = System.currentTimeMillis();
		int windowSize = MAX_WINDOW_SIZE;
		int minSize = MIN_WINDOW_SIZE;
		int len = dump.length;
		if (len > 65536) {
			throw new RuntimeException("This compressor can't compress anything larger than 64KB!");
		}
		byte[] window = new byte[windowSize];
		fillWindow(dump, window, 0);

		List<Part> parts = findMatches(dump, windowSize, minSize, len, window, FAST);

		byte[] bos = compress(parts, dump);

		if (bos.length >= len) {
			log("No further compression possible!");
			return null;
		}

		log("Binary compressed from " + len + " to " + bos.length + " bytes in " + (System.currentTimeMillis() - time)
				+ "ms");

		DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.ENGLISH);
		DecimalFormat decFor = new DecimalFormat("###.##", symbols);

		log("Compression ratio: 1:" + decFor.format(((float) len / bos.length)));
		return bos;
	}

	/**
	 * Decompresses the compressed data
	 * 
	 * @param bytes
	 * @return
	 */
	public static byte[] decompress(byte[] bytes) {
		long time = System.currentTimeMillis();
		int clen = bytes.length;
		int data = readLowHigh(bytes, 0);
		int compLen = readLowHigh(bytes, 2);
		int ucLen = readLowHigh(bytes, 4);
		int headerOffset = 6;
		int dataPos = headerOffset;

		byte[] res = new byte[65536];
		int pos = 0;
		for (int i = data; i < clen;) {
			int start = readLowHigh(bytes, i);
			int target = 0;
			i += 2;
			do {
				int len = bytes[i] & 0xFF;
				i++;
				target = 0;
				if (len != 0) {
					target = readLowHigh(bytes, i);
					int copyLen = target - pos;
					if (copyLen > 0) {
						System.arraycopy(bytes, dataPos, res, pos, copyLen);
						dataPos += copyLen;
						pos = target;
					}
					System.arraycopy(res, start, res, target, len);
					pos += len;
					i += 2;
				} else {
					i++;
				}
			} while (target > 0);
		}
		if (dataPos < data) {
			int len = data - dataPos;
			System.arraycopy(bytes, dataPos, res, pos, len);
			pos += len;
		}

		if (pos != ucLen) {
			throw new RuntimeException("Failed to decompress, size mismatch: " + pos + "/" + ucLen);
		}
		log("Decompressed from " + compLen + " to " + ucLen + " bytes in " + (System.currentTimeMillis() - time)
				+ "ms!");

		return Arrays.copyOf(res, pos);
	}

	/**
	 * Decompresses the compressed data but unlike decompress(), it does that in one
	 * block of 64K memory just like the real machine would have to do it.
	 * 
	 * @param bytes
	 * @return
	 */
	public static byte[] decompressInMemory(byte[] bytes) {
		long time = System.currentTimeMillis();
		int data = readLowHigh(bytes, 0);
		int compLen = readLowHigh(bytes, 2);
		int ucLen = readLowHigh(bytes, 4);

		int memStart = 2049;
		int memEnd = 53248;
		int headerOffset = 6;

		int byteCount = 0;
		int totalLen = compLen - headerOffset;

		byte[] res = new byte[65536];
		// Copy into memory just like it would be located on a real machine...
		System.arraycopy(bytes, headerOffset, res, memStart, totalLen);

		// Copy compressed data to the end of memory...
		int dataPos = memEnd - totalLen;
		data -= headerOffset;
		int compPos = dataPos + data;
		System.arraycopy(res, memStart, res, dataPos, totalLen);
		int pos = memStart;

		for (int i = compPos; i < memEnd;) {
			int start = readLowHigh(res, i) + memStart;
			int target = 0;
			i += 2;
			do {
				int len = res[i] & 0xFF;
				i++;
				target = 0;
				if (len != 0) {
					target = readLowHigh(res, i) + memStart;
					int copyLen = target - pos;
					if (copyLen > 0) {
						// Copy uncompressed data back down into memory...
						byteCount += moveData(res, dataPos, pos, copyLen);
						dataPos += copyLen;
						pos = target;
					}

					byteCount += moveData(res, start, target, len);
					pos += len;
					i += 2;
				} else {
					i++;
				}
			} while (target > 0);
		}

		int left = compPos - dataPos;
		if (left > 0) {
			byteCount += moveData(res, dataPos, pos, left);
			pos += left;
		}

		int newLen = pos - memStart;
		if (newLen != ucLen) {
			throw new RuntimeException("Failed to decompress, size mismatch: " + newLen + "/" + ucLen);
		}

		log("Decompressed from " + compLen + " to " + ucLen + " bytes in " + (System.currentTimeMillis() - time)
				+ "ms! (" + byteCount + " bytes moved)");

		return Arrays.copyOfRange(res, memStart, memStart + ucLen);
	}

	private static int moveData(byte[] res, int dataPos, int pos, int dataLen) {
		System.arraycopy(res, dataPos, res, pos, dataLen);
		return dataLen;
	}

	private static byte[] compress(List<Part> parts, byte[] dump) {
		ByteArrayOutputStream footer = new ByteArrayOutputStream();
		ByteArrayOutputStream data = new ByteArrayOutputStream();

		int pos = 0;
		int lastStart = -1;
		for (Part part : parts) {
			int start = part.sourceAddress;
			int target = part.targetAddress;
			if (target > pos) {
				data.write(dump, pos, target - pos);
				pos = target;
			}
			pos += part.size;

			if (start != lastStart) {
				if (lastStart != -1) {
					writeEndFlag(footer);
				}
				writeLowHigh(footer, start);
			}
			lastStart = start;
			footer.write(part.size);
			writeLowHigh(footer, part.targetAddress);
		}

		data.write(dump, pos, dump.length - pos);
		writeEndFlag(footer);

		ByteArrayOutputStream res = new ByteArrayOutputStream();
		int dataLen = data.size() + 6;
		writeLowHigh(res, dataLen);
		writeLowHigh(res, dataLen + footer.size());
		writeLowHigh(res, dump.length);

		try {
			res.write(data.toByteArray());
			res.write(footer.toByteArray());
		} catch (IOException e) {
			//
		}
		return res.toByteArray();
	}

	private static void writeEndFlag(ByteArrayOutputStream header) {
		header.write(0);
		header.write(0);
	}

	private static int readLowHigh(byte[] bytes, int pos) {
		return (bytes[pos] & 0xFF) + ((bytes[pos + 1] & 0xFF) << 8);
	}

	private static void writeLowHigh(ByteArrayOutputStream header, int start) {
		header.write((start & 0xFF));
		header.write((start >> 8));
	}

	/**
	 * This is O(n*n) and therefore quite inefficient...anyway, it will do for
	 * now...
	 * 
	 * @param dump
	 * @param windowSize
	 * @param minSize
	 * @param len
	 * @param windowPos
	 * @param window
	 * @param fastMode   Less compression, but a lot faster.
	 * @return
	 */
	private static List<Part> findMatches(byte[] dump, int windowSize, int minSize, int len, byte[] window,
			boolean fastMode) {
		int curSize = windowSize;
		int largest = 0;
		int windowPos = 0;
		List<Part> parts = new ArrayList<>();
		byte[] covered = new byte[len];

		int cnt = 0;
		int chunkSize = CHUNK_SIZE;

		for (int lenPart = Math.min(len, chunkSize); lenPart <= len; lenPart += chunkSize) {
			do {
				for (int i = windowPos + curSize; i < lenPart - curSize; i++) {
					if (covered[i] > 0) {
						continue;
					}
					cnt++;
					boolean match = true;

					for (int p = 0; p < curSize; p++) {
						if (covered[i + p] != 0) {
							match = false;
							break;
						}
						if (dump[i + p] != window[p]) {
							match = false;
							if (p > largest) {
								largest = p;
							}
							break;
						}
					}

					if (match) {

						for (int h = i; h < i + curSize; h++) {
							covered[h] = 1;
						}

						Part part = new Part(windowPos, i, curSize);
						parts.add(part);
						i += curSize - 1;
					}
				}
				if (largest >= minSize) {
					curSize = largest;
					largest = 0;
				} else {
					if (fastMode) {
						windowPos += Math.max(largest, 1);
						if (windowPos + windowSize >= lenPart) {
							windowPos -= (windowPos + windowSize - lenPart);
						}
					} else {
						windowPos++;
					}
					curSize = windowSize;
					largest = 0;
					fillWindow(dump, window, windowPos);
				}
			} while (windowPos + curSize < lenPart);
			windowPos = lenPart - curSize;
		}
		Collections.sort(parts, new Comparator<Part>() {

			@Override
			public int compare(Part p1, Part p2) {
				return p1.targetAddress - p2.targetAddress;
			}

		});

		// parts.forEach(p -> System.out.println(p));
		log("Iterations taken: " + cnt);

		return parts;
	}

	private static void fillWindow(byte[] dump, byte[] window, int pos) {
		System.arraycopy(dump, pos, window, 0, window.length);
	}

	private static void log(String txt) {
		System.out.println(txt);
	}

	private static class Part {

		Part(int source, int target, int size) {
			this.sourceAddress = source;
			this.targetAddress = target;
			this.size = size;
		}

		int sourceAddress;
		int targetAddress;
		int size;

		@Override
		public String toString() {
			return "block@ " + sourceAddress + "/" + targetAddress + "/" + size;
		}
	}

}
