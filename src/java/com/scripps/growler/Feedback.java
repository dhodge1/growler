/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;
import java.util.*;


/**
 * Thuy To
 * returns feedback message from email application
 */
public class Feedback
{
  String feedbackMessage;
  boolean success;
  
  public Feedback()
  {
    this.feedbackMessage = new String();
    this.success = false;
  }
 
  public Feedback(String feedbackMessage)
  {
    this(); 
    this.setFeedbackMessage(feedbackMessage);
  }
  
  public Feedback(String feedbackMessage, boolean success)
  { 
    this.setFeedbackMessage(feedbackMessage);
    this.setSuccess(success);
  }
  
  public String getFeedbackMessage()
  {
     return(this.getFeedbackMessage());
  }
  public void setFeedbackMessage(String feedbackMessage)
  {
     this.feedbackMessage = feedbackMessage;  
  }        
  public boolean isSuccess()
  {
    return(this.success);   
  }
  public void setSuccess(boolean success)
  {
    this.success = success;
  }         
}
