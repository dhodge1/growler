/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.util.ArrayList;

/**
 *
 * @author 162107
 */
public class CommentPersistence extends GrowlerPersistence {
    
    /**
     * Adds a comment to the database
     * @param c The Comment object
     */
    public void addComment(Comment c) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into comment (session_id, description) values (?, ?)");
            statement.setInt(1, c.getSession_id());
            statement.setString(2, c.getDescription());
            statement.executeUpdate();
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        
    }
    /**
     * Gets all the comments for a particular session
     * @param id The session to query for
     * @return A list of comments for the session
     */
    public ArrayList<Comment> getCommentsBySession(int id){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select session_id, description from comment where session_id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            ArrayList<Comment> comments = new ArrayList<Comment>();
            while (result.next()) {
                Comment c = new Comment(result.getInt("session_id"), result.getString("description"));
                comments.add(c);
            }
            return comments;
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    /**
     * Gets a list of every comment made
     * @return A list of every comment
     */
    public ArrayList<Comment> getAllComments(){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select session_id, description from comment");
            result = statement.executeQuery();
            ArrayList<Comment> comments = new ArrayList<Comment>();
            while (result.next()) {
                Comment c = new Comment(result.getInt("session_id"), result.getString("description"));
                comments.add(c);
            }
            return comments;
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        return null;
    }
}
