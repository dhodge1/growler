/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;
import java.util.Date;
import java.util.Properties;
 
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Address;

/**
 * A helper class for sending e-mail messages with SMTP(Simple
 * Mail Transfer Protocol). 
 * This class uses the @scrippsnetworks as a FROM address, therefore the 
 * default mail server for this class is "mail.office365.com"
 *
 * 
 * 
 * @author Thuy To
 * Resources: Murach's Java servlets and JSP and www.codejava.net
 * Version: 2
 **/
public class EmailUtilSMTPScripps
{
   public static void sendMail(String to, String subject,
                               String body, boolean bodyIsHTML) throws 
                               AddressException, MessagingException 
                             
   {
     //***************************************************
     //**Since we have a share Scripps Networks mail box,**
     //**we use the usernam and password below to creates**
     //**new session with authenticator. Then we use the **
     //**sni-techtoberfest-help@scrippsnetworks.com email** 
     //** address as a FROM address for this class.      **
     //****************************************************
     final String username = "Thuy.To@scrippsnetworks.com";
     final String password = "xotujevA14";
     final String from = "sni-techtoberfest-help@scrippsnetworks.com";
     //sets environment properties
     Properties props = new Properties();   
     //The default mail server is
     //mail.office365.com
     props.put("mail.smtp.host", "mail.office365.com");  
     props.put("mail.smtp.port",587 );
     props.put("mail.smtp.auth", "true");
     //use of the STARTTLS command is prefered in case where the 
     //server supports both SSL and none SSL connection
     props.put("mail.smtp.starttls.enable", "true");
      
     //creates new Autheticatior
     Authenticator auth = new Authenticator() {
            @Override
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username,password );
            }
        };     
     //creates new session with authenticator
     Session session = Session.getInstance(props,auth);
     //Creates a message info
     Message message = new MimeMessage(session);
     message.setSubject(subject);
     if(bodyIsHTML)
     {    
       message.setContent(body,"text/html");
     }
     else
     {
       message.setText(body);
     }
     //Address the message
     Address fromAddress = new InternetAddress(from);
     Address[] emailList = InternetAddress.parse(to);
     message.setFrom(fromAddress);
     message.setRecipients(Message.RecipientType.TO, emailList);
     // Send the message
     Transport.send(message);
   } 
}
