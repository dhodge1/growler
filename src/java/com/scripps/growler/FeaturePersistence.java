/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

import java.sql.*;
import java.util.*;

/**
 *
 * @author David
 */
public class FeaturePersistence extends GrowlerPersistence {
    
    public FeaturePersistence() {
    }
    
    public Feature getFeatureState(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select featureState from feature where featureID = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            Feature f = new Feature();
            if (result.next()) {
                f.setFeatureState(result.getBoolean("featureState"));
            }
            return f;
        } catch (Exception e) { 
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
    public void enableFeatureState(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update feature set featureState = 1 where featureID = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
    
    public void disableFeatureState(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update feature set featureState = 0 where featureID = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
    
}
