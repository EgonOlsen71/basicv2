package com.sixtyfour.util;

import java.security.MessageDigest;

/**
 * @author EgonOlsen
 */
public class Md5 {

    public static String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(input.getBytes());

            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch(Exception ex) {
            throw new RuntimeException("Failed to create MD5 hash!", ex);
        }
    }

}
