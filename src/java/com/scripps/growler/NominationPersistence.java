/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;
import java.util.*;
/**
 *
 * @author 162107
 */
public class NominationPersistence extends GrowlerPersistence {
    
    private ArrayList<Nomination> nominations;
    
    public void addNomination(Nomination n) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into nomination (topic, description, duration, theme_id, speaker_id) " +
                    "values (?, ?, ?, ?, ?)");
            statement.setString(1, n.getTopic());
            statement.setString(2, n.getDescription());
            statement.setTime(3,n.getDuration());
            statement.setInt(4, n.getTheme());
            statement.setInt(5, n.getSpeaker());
            statement.execute();
        } catch (Exception e){
            
        } finally {
            closeJDBC();
        }
    }
}
