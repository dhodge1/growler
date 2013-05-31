/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

/**
 *
 * @author 162107
 */
public class Location {
    
    private int id;
    private String description;

    public Location(int id, String description) {
        this.id = id;
        this.description = description;
    }

    public Location() {
    }

    public Location(int id) {
        this.id = id;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
