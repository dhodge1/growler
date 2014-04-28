/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

import java.util.*;
import java.sql.*;

/**
 *
 * @author David
 */
public class WinnerPersistence extends GrowlerPersistence {
    
    public ArrayList<Winner> getWinner() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("SELECT u.id as id, name, SUBTIME(NOW(), '4:00') as now FROM user u, attendance a where a.user_id = u.id and a.isSurveyTaken = 1 ORDER BY RAND() LIMIT 1");
            result = statement.executeQuery();
            ArrayList<Winner> winners = new ArrayList<Winner>();
            while (result.next()) {
                Winner w = new Winner();
                w.setId(result.getInt("id"));
                w.setName(result.getString("name"));
                w.setTimeDrawn(result.getString("now"));
                winners.add(w);
            }
            return winners;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<Winner> getAllWinners() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from winner");
            result = statement.executeQuery();
            ArrayList<Winner> allWinners = new ArrayList<Winner>();
            while (result.next()) {
                Winner w = new Winner();
                w.setId(result.getInt("winnerID"));
                w.setName(result.getString("name"));
                w.setClaimed(result.getBoolean("claimed"));
                w.setTimeDrawn(result.getString("timeDrawn"));
                allWinners.add(w);
            }
            return allWinners;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    public void insertWinner(Winner w) {
        try{
            initializeJDBC();
            statement = connection.prepareStatement("insert into winner(winnerID, name, timeDrawn) values(?, ?, ?)");
            statement.setInt(1, w.getId());
            statement.setString(2, w.getName());
            statement.setString(3, w.getTimeDrawn());
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
    }
    
    public void claimPrize(Winner w) {
        try{
            initializeJDBC();
            statement = connection.prepareStatement("update winner set claimed = 1 where winnerID = ? and timeDrawn = ?");
            statement.setInt(1, w.getId());
            statement.setString(2, w.getTimeDrawn());
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
    }
    
}
