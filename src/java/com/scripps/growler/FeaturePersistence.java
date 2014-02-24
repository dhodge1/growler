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
    
    public ArrayList<Feature> getFeatureSet() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from feature");
            result = statement.executeQuery();
            ArrayList<Feature> features = new ArrayList<Feature>();
            while (result.next()) {
                Feature f = new Feature();
                f.setId(result.getInt("featureID"));
                f.setFeatureName(result.getString("featureName"));
                f.setFeatureState(result.getBoolean("featureState"));
                features.add(f);
            }
            closeJDBC();
            return features;
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
            statement.execute();
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
            statement.execute();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
    
}
