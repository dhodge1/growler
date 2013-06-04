/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;


import org.openqa.selenium.ie.InternetExplorerDriver;

/**
 *
 * @author 162107
 */
public class SeleniumTest {
    
    
    
    public void testOpen() throws Exception {
    
        WebDriver driver = new InternetExplorerDriver();
        driver.get("http://www.google.com");
        System.out.println("Page title is: " + driver.getTitle());
        
    }
    
    
}
