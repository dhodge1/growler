/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import java.util.List;
import javax.swing.JOptionPane;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.apache.log4j.Logger;
import org.openqa.selenium.ie.InternetExplorerDriver;

/**
 *
 * @author 162107
 */
public class SeleniumTest {
    
    public WebDriver driver = new FirefoxDriver(); 
    
    @Test
    public void testOpen() throws Exception {
    
        
        driver.get("http://sni-techtoberfest.elasticbeanstalk.com");
        driver.manage().window().maximize();
        driver.findElement(By.name("username")).sendKeys("808300");
        driver.findElement(By.name("password")).sendKeys("password");
        WebElement button = driver.findElement(By.id("send"));
        button.click();
        
        driver.navigate().to("http://sni-techtoberfest.elasticbeanstalk.com/admin/speaker.jsp");
        
    }
    
    @Test 
    public void testChangeVisibilityOnTheme() throws Exception {
        List<WebElement> visible = driver.findElements(By.name("last"));
            WebElement l = visible.get(3);
            l.clear();
            l.sendKeys("UH OH!");
    }
    
    
}
