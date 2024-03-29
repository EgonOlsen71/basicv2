package com.sixtyfour.system;

/**
 * Converts back and forth between Java floats and the actual memory
 * representation that the C64 uses.
 * 
 * 
 * @author EgonOlsen
 * 
 */
public class Conversions {

	private static final double ACC_CORRECTOR = 0.00000000001d;

	/**
	 * Compacts a C64 float from extended 6 byte representation to condensed 5 byte
	 * representation.
	 * 
	 * @param number the number in 6 byte format
	 * @return the number in 5 byte format
	 */
	public static int[] compactFloat(int[] number) {
		int[] res = new int[5];
		System.arraycopy(number, 0, res, 0, 5);
		res[1] = (res[1] & 0b01111111) | (number[5] == 0 ? 0 : 0x80);
		return res;
	}

	/**
	 * Extracts the 6 byte representation from a 5 byte one.
	 * 
	 * @param number the number in 5 byte format
	 * @return the number in 6 byte format
	 */
	public static int[] extractFloat(int[] number) {
		int[] res = new int[6];
		System.arraycopy(number, 0, res, 0, 5);
		res[5] = (res[1] & 0x80) == 0 ? 0 : 0xff;
		res[1] = res[1] | 0x80;
		return res;
	}

	/**
	 * Converts a float from Java into C64 format (extended, i.e. 6 bytes)
	 * 
	 * @param number the number to convert
	 * @return the result
	 */
	public static int[] convertFloat(float number) {
		return convertDouble(number);
	}

	/**
	 * Converts a double from Java into C64 format (extended, i.e. 6 bytes)
	 * 
	 * @param number the number to convert
	 * @return the result
	 */
	public static int[] convertDouble(double number) {
		int sign, bit, beit, flag, count, ei = 0;
		double num = number;
		int[] mem = new int[4];

		if (num == 0) {
			return new int[6];
		}

		if (num < 0) {
			sign = 128;
			num = -num;
		} else {
			sign = 0;
		}

		double a = Math.pow(2, 126);

		beit = 0;
		flag = 0;
		count = 0;

		for (int i = 126; i >= -128 && beit < 4; i--) {
			if (num + ACC_CORRECTOR >= a) {
				bit = 1;
				if (flag == 0) {
					ei = i;
				}
				flag = 1;
			} else {
				bit = 0;
			}

			if (flag == 1) {
				mem[beit] = mem[beit] * 2 + bit;
				count++;
				if (count > 7) {
					count = 0;
					beit++;
				}
				num = num - a * bit;
			}
			a /= 2d;
		}

		mem[0] -= 128;
		int[] res = new int[6];
		res[0] = 129 + ei;
		res[1] = mem[0] | 0x80;
		res[2] = mem[1];
		res[3] = mem[2];
		res[4] = mem[3];
		res[5] = sign == 0 ? 0 : 255;
		return res;
	}

	/**
	 * Converts a float from C64 6 byte format into Java format.
	 * 
	 * @param machine the current machine
	 * @param addr    the address, where the float is stored (0x61 for FAC(1))
	 * @return the float value
	 */
	public static float convertFloat(Machine machine, int addr) {
		int[] ram = machine.getRam();
		return convertFloat(ram[addr] & 0xff, ram[addr + 5] & 0x80, ram[addr + 4] & 0xff, ram[addr + 3] & 0xff,
				ram[addr + 2] & 0xff, ram[addr + 1] & 0xff);
	}

	/**
	 * Converts an ASCII char to the corresponsing PETSCII char
	 * 
	 * @param c
	 * @return
	 */
	public static char convertAscii2Petscii(char c) {
		if (c > 64 && c < 91) {
			return (char) (c + 32);
		}
		if (c > 96 && c < 123) {
			return (char) (c - 32);
		}
		return c;
	}

	/**
	 * Converts a float from C64 5 byte format into Java format.
	 * 
	 * @param machine the current machine
	 * @param addr    the address, where the float is stored
	 * @return the float value
	 */
	public static float convertCompactFloat(Machine machine, int addr) {
		int[] ram = machine.getRam();
		int[] res = new int[6];
		System.arraycopy(ram, addr, res, 0, 5);
		res[5] = (res[1] & 0x80) == 0 ? 0 : 0xff;
		res[1] = res[1] | 0x80;
		return convertFloat(res[0] & 0xff, res[5] & 0xff, res[4] & 0xff, res[3] & 0xff, res[2] & 0xff, res[1] & 0xff);
	}

	/**
	 * Converts a float from C64 format into Java format.
	 * 
	 * @param exp the exponent
	 * @param neg the negative flag (either 0 for positive or 0xFF for negative
	 *            values)
	 * @param m1  the mantissa, part 1
	 * @param m2  the mantissa, part 2
	 * @param m3  the mantissa, part 3
	 * @param m4  the mantissa, part 4
	 * @return the float value
	 */
	public static float convertFloat(int exp, int neg, int m1, int m2, int m3, int m4) {
		if (exp == 0) {
			return 0;
		}
		double expf = exp - 128;
		double man = ((neg != 0 ? -1d : 1d) * ((m4 | 0x80) * Math.pow(2d, -8d) + m3 * (Math.pow(2d, -16d))
				+ m2 * (Math.pow(2d, -24d)) + m1 * (Math.pow(2d, -32d))));
		return (float) (man * Math.pow(2, expf));
	}

	/**
	 * Converts a float from C64 format into Java format as a double.
	 * 
	 * @param exp the exponent
	 * @param neg the negative flag (either 0 for positive or 0xFF for negative
	 *            values)
	 * @param m1  the mantissa, part 1
	 * @param m2  the mantissa, part 2
	 * @param m3  the mantissa, part 3
	 * @param m4  the mantissa, part 4
	 * @return the float value
	 */
	public static double convertDouble(int exp, int neg, int m1, int m2, int m3, int m4) {
		if (exp == 0) {
			return 0;
		}
		double expf = exp - 128;
		double man = ((neg != 0 ? -1d : 1d) * ((m4 | 0x80) * Math.pow(2d, -8d) + m3 * (Math.pow(2d, -16d))
				+ m2 * (Math.pow(2d, -24d)) + m1 * (Math.pow(2d, -32d))));
		return (double) (man * Math.pow(2, expf));
	}
}
