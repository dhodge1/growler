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
    
    ArrayList<Comment> comments = new ArrayList<Comment>();
    /**
     * Adds a comment to the database
     * @param c The Comment object
     */
    public void addComment(Comment c) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into comments (session_id, comment) values (?, ?)");
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
            statement = connection.prepareStatement("select session_id, comment from comments where session_id = ? order by comment");
            statement.setInt(1, id);
            result = statement.executeQuery();
            //ArrayList<Comment> comments = new ArrayList<Comment>();
            while (result.next()) {
                Comment c = new Comment(result.getInt("session_id"), result.getString("comments"));
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
            statement = connection.prepareStatement("select session_id, comment from comments order by session_id, comment");
            result = statement.executeQuery();
            //ArrayList<Comment> comments = new ArrayList<Comment>();
            while (result.next()) {
                Comment c = new Comment(result.getInt("session_id"), result.getString("comment"));
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
    //*************************************************************************
    //**********************ADDED CODE START HERE******************************
    /**************************************************************************
     * Thuy To
     * 04/07/2014
     **************************************************************************/
    
    public ArrayList<Comment> getCommentBySessionIdForFeedback(int id)
    {
       try 
       {
           String preparedQuery =  "SELECT session_id, comment FROM comments  "                     
                                   +"WHERE session_id = ? ";
                                         
           initializeJDBC();
           statement = connection.prepareStatement(preparedQuery);
           statement.setInt(1, id );
           result = statement.executeQuery();
           while (result.next()) 
           {
               Comment c = new Comment();
               c.setSession_id(result.getInt("session_id"));
               c.setDescription(result.getString("comment"));
               comments.add(c);
           }
           return comments;
       } 
       catch (Exception e) {
       }
       finally 
       {
           closeJDBC();
       }
       return comments;
    } 
}
