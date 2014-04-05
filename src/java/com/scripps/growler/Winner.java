/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;
import java.util.*;

/**
 *
 * @author David
 */
public class Winner {
    
    private Integer id;
    private String name;
    private Boolean claimed;
    private String timeDrawn;
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer _id) {
        this.id = _id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String _name) {
        this.name = _name;
    }
    
    public Boolean getClaimed() {
        return claimed;
    }
    
    public void setClaimed(Boolean _claimed) {
        this.claimed = _claimed;
    }
    
    public String getTimeDrawn() {
        return timeDrawn;
    }
    
    public void setTimeDrawn(String _timeDrawn) {
        this.timeDrawn = _timeDrawn;
    }
    
    @Override
    public String toString() {
        return "Winner [id=" + id + ", name=" + name + ", claimed="
            + claimed + ", timeDrawn=" + timeDrawn + "]";
    }
    
    
}
