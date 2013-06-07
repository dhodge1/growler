/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;
import java.util.regex.*;

/**
 *
 * @author "Justin Bauguess"
 */
public class Test {

    public static void main (String args[]) {
        Pattern myPattern = Pattern.compile("^[A-Za-z0-9_](\\.[A-Za-z0-9])?@[A-Za-z0-9_]\\.[com|org|net]$");
        
    }
}
