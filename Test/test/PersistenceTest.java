/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import org.dbunit.*;
import org.junit.Test;
import com.scripps.growler.*;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import static org.junit.Assert.*;

/**
 *
 * @author 162107
 */
public class PersistenceTest {

    AttendancePersistence attendancePersist = new AttendancePersistence();
                SessionPersistence sessionPersist = new SessionPersistence();
                SpeakerPersistence speakerPersist = new SpeakerPersistence();
                SurveyPersistence surveyPersist = new SurveyPersistence();
                ThemePersistence themePersist = new ThemePersistence();
                UserPersistence userPersist = new UserPersistence();
    public PersistenceTest() {
            
    }
    
    @Test
    public void testTheme(){
        
        ArrayList<Theme> themes = themePersist.getUserRanks(2023);
        Theme t = new Theme();
        t.setId(999);
        t.setName("Testing Cases");
        org.junit.Assert.assertEquals("These are not equal", 999, t.getId());
        
        
        
    }
    
    @Test
    public void testConnection(){
        try {
        DataConnection dataConnection = new DataConnection();
        Connection connection = dataConnection.sendConnection();
        
        org.junit.Assert.assertNotNull("The connection is null", connection);
        Statement statement = connection.createStatement();
        org.junit.Assert.assertNotNull("The statement is null", statement);
               }
        catch (Exception e) {
            
        }
        
    }
}