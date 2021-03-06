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
 * The Default mail server for FROM @gmail
 * email address is "smtp.gmail.com" 
 * 
 * @author Thuy To
 * Resources: Murach's Java servlets and JSP and www.codejava.net
 * Version: 2
 */
public class EmailUtilSMTPLocal
{
   
   
   public static void sendMail(String to, String subject,
                               String body, boolean bodyIsHTML) throws 
                               AddressException, MessagingException 
                             
   {
     final String username = "scrippsproject2014@gmail.com";
     final String password = "capstoneteam2014";   
     //sets environment properties
     Properties props = new Properties();   
     //The default mail server is
     //smtp.gmail.com
     props.put("mail.smtp.host", "smtp.gmail.com");  
     props.put("mail.smtp.port",587 );
     props.put("mail.smtp.auth", "true");
     //use of the STARTTLS command is prefered in case where the 
     //server supports both SSL and none SSL connection
     props.put("mail.smtp.starttls.enable", "true");
    
     
     //creates new session with authenticator
     Authenticator auth = new Authenticator() {
            @Override
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username,password );
            }
        };     
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
     Address fromAddress = new InternetAddress(username);
     Address[] emailList = InternetAddress.parse(to);
     message.setFrom(fromAddress);
     message.setRecipients(Message.RecipientType.TO, emailList);
     // Send the message
     Transport.send(message);
   } 
}
