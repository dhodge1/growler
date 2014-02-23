/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

/**
 *
 * @author David
 */
public class Feature {
    
    private int id;
    private String featureName;
    private Boolean featureState;
    
    public Feature() {
    }
    
    public Integer getId() {
        return id;
    }
    
    
    public void setId(Integer id){
        this.id = id;
    }
    
    public String getFeatureName(){
        return featureName;
    }
    
    public void setFeatureName(String name){
        this.featureName = name;
    }
    
    public Boolean getFeatureState() {
        return featureState;
    }
    
    public void setFeatureState(Boolean state) {
        this.featureState = state;
    }
}
