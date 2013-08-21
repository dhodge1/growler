/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;
import java.util.regex.*;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;

/**
 *
 * @author "Justin Bauguess"
 */
public class Test {

    public static void main (String args[]) {
        
        
        WebDriver driver = new InternetExplorerDriver();
        driver.get("http://growler.elasticbeanstalk.com/");
        driver.manage().window().maximize();
        System.out.println(driver.getTitle());
        
        //Pattern myPattern = Pattern.compile("^[A-Za-z0-9_](\\.[A-Za-z0-9])?@[A-Za-z0-9_]\\.[com|org|net]$");
        
    }
}
