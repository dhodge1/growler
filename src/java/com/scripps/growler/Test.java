/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

import java.util.Calendar;



/**
 *
 * @author "Justin Bauguess"
 */
public class Test {

    public static void main (String args[]) {
        Calendar today = Calendar.getInstance();
        String date = today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH) + 1) + "-" + today.get(Calendar.DATE);
        String time = today.get(Calendar.HOUR_OF_DAY) + ":" + today.get(Calendar.MINUTE) + ":" + today.get(Calendar.SECOND);
        System.out.println(date);
        System.out.println(time);
        Calendar other = Calendar.getInstance();
        String date2 = other.get(Calendar.YEAR) + "-" + (other.get(Calendar.MONTH) + 1) + "-" + other.get(Calendar.DATE);
        System.out.println(date2);
        other.set(2013, 06, 05, 12, 30, 00);
        System.out.println(today.compareTo(other));
        System.out.println(other.compareTo(today));
        
        
    }
}
