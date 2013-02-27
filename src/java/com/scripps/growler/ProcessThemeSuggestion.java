/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

/**
 *
 * @author "Justin Bauguess"
 */
public class ProcessThemeSuggestion {
    private String name;
    private String description;
    private String reason;
    
    public void setName(String s) {
        name = s;
    }
    
    public String getName() {
        return(this.name);
    }
    
    public void setDescription(String s) {
        description = s;
    }
    
    public String getDescription() {
        return(this.description);
    }
    
    public void setReason(String s) {
        reason = s;
    }
    public String getReason() {
        return(this.reason);
    }
}
