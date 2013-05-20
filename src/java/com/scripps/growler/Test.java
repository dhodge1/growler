/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

import java.security.MessageDigest;

/**
 *
 * @author "Justin Bauguess"
 */
public class Test {
    public static String bytesToHex(byte[] b) {
      char hexDigit[] = {'0', '1', '2', '3', '4', '5', '6', '7',
                         '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
      StringBuffer buf = new StringBuffer();
      for (int j=0; j<b.length; j++) {
         buf.append(hexDigit[(b[j] >> 4) & 0x0f]);
         buf.append(hexDigit[b[j] & 0x0f]);
      }
      return buf.toString();
   }
    public static void main (String args[]) {
        for (int i=0; i<100; i++) {
        try {
        MessageDigest sha = MessageDigest.getInstance("sha-1");
        String password = String.valueOf(i);
        sha.update(password.getBytes());
        byte pwd[] = sha.digest();
        String pw = bytesToHex(pwd);
        System.out.println(pw);
        }
        catch (Exception e) {
            
        }
        try {
            MessageDigest sha = MessageDigest.getInstance("sha-1");
            String password = "thisword";
            sha.update(password.getBytes());
            byte pwd2[] = sha.digest();
            String p1 = bytesToHex(pwd2);
            System.out.println(p1);
            String password2 = "Thisword";
            sha.update(password2.getBytes());
            byte pwd3[] = sha.digest();
            String p2 = bytesToHex(pwd3);
            System.out.println(p2);
        }
        catch (Exception e) {
            
        }
        }
    }
}
