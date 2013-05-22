/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import com.scripps.growler.*;
import java.util.ArrayList;
import java.sql.*;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author 162107
 */
public class NewEmptyJUnitTest {
    
    public NewEmptyJUnitTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }
    @Test
    public void arrayIsNotNull() {
        SpeakerPersistence sp = new SpeakerPersistence();
        ArrayList<Speaker> speakers = sp.getUserRanks(2023);
        org.junit.Assert.assertNotNull("Speakers is null", speakers);
        
    }
    @Test
    public void arrayIsNull() {
        SpeakerPersistence sp = new SpeakerPersistence();
        ArrayList<Speaker> speakers = sp.getUserRanks(2023);
        org.junit.Assert.assertNull("Speakers is not null", speakers);
               
        
    }

}