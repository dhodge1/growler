/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;
import java.util.*;

/**
 *
 * @author "Justin Bauguess"
 */
public class NewClass {
    public static void main(String[] args) {
        Calendar today = Calendar.getInstance();
        System.out.print(today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH)+1) + "-" + today.get(Calendar.DATE));
    }
}
