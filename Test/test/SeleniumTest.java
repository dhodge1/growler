/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import java.util.*;
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
    Calendar today = Calendar.getInstance();
        Random random = new Random(today.getTimeInMillis());
    
    @Test
    public void testThemeSuggestion() throws Exception {
        driver.get("http://growler.elasticbeanstalk.com");
        driver.manage().window().maximize();
        driver.findElement(By.name("username")).sendKeys("202300");
        driver.findElement(By.name("password")).sendKeys("password");
        WebElement button = driver.findElement(By.id("send"));
        button.click();
        driver.navigate().to("http://growler.elasticbeanstalk.com/view/themeentry.jsp");
        driver.findElement(By.name("name")).sendKeys("Selenium Test: " + random.nextDouble());
        driver.findElement(By.id("tip2")).sendKeys("A Description to Test!!");
        driver.findElement(By.name("reason")).sendKeys("There is no good reason.");
        driver.findElement(By.id("send")).click();
        driver.close();
    }
    
    @Test
    public void testOpen() throws Exception {
        driver.get("http://growler.elasticbeanstalk.com");
        driver.manage().window().maximize();
        driver.findElement(By.name("username")).sendKeys("202300");
        driver.findElement(By.name("password")).sendKeys("password");
        WebElement button = driver.findElement(By.id("send"));
        button.click();
        driver.navigate().to("http://growler.elasticbeanstalk.com/view/sessionschedule.jsp");
        List<WebElement> e = driver.findElements(By.name("interest"));
        for (int i = 0; i < e.size(); i++) {
            e.get(i).click();
        }
        driver.findElement(By.id("send")).click();
        driver.close();
    }
    
    @Test
    public void testSpeakerSuggest() throws Exception {
        driver.get("http://growler.elasticbeanstalk.com");
        driver.manage().window().maximize();
        driver.findElement(By.name("username")).sendKeys("202300");
        driver.findElement(By.name("password")).sendKeys("password");
        WebElement button = driver.findElement(By.id("send"));
        button.click();
        driver.navigate().to("http://growler.elasticbeanstalk.com/view/speakerentry.jsp");
        driver.findElement(By.name("first_name")).sendKeys("Spkr: " + random.nextInt(15));
        driver.findElement(By.name("last_name")).sendKeys("Spkr: " + random.nextInt(16));
        driver.findElement(By.id("send")).click();
        driver.close();
    }
    
    
    
    
}
