/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
//adding a comment to comment
package com.scripps.growler;

/**
 *
 * @author 162107
 */
public class Comment {
    private int session_id;
    private String description;

    public Comment() {
    }

    public int getSession_id() {
        return session_id;
    }

    public void setSession_id(int session_id) {
        this.session_id = session_id;
    }

    public Comment(int session_id, String description) {
        this.session_id = session_id;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
