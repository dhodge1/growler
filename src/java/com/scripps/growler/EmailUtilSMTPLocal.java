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
 * A helper class for sending e-mail messages with a local SMTP(Simple
 * Mail Transfer Protocol). 
 * 
 * @author Thuy To
 * Resources: Murach's Java servlets and JSP and www.codejava.net
 * Version: 1
 */
public class EmailUtilSMTPLocal
{
   public static void sendMail(String to, String from, String subject,
                               String body, boolean bodyIsHTML) throws 
                               AddressException, MessagingException 
                             
   {
     //get a email session for a local SMTP server
     Properties props = new Properties();  
     props.put("mail.transport.protocol","smtps"); 
     props.put("mail.smtp.host", "smtp.gmail.com");
    // props.put("mail.smtp.host", "localhost");  
     props.put("mail.smtp.port", 465);
     props.put("mail.smtp.auth", "true");
     props.put("mail.smtps.quitwait", "false");
     Session session = Session.getDefaultInstance(props);
     session.setDebug(true);
     /*
     Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
    */
     //Create a message
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
     Address[] mailList = { new InternetAddress(to) };
     //Address toAddress = new InternetAddress(to);
     message.setFrom(fromAddress);
     message.setRecipients(Message.RecipientType.TO, mailList);
     // Send the message
     Transport transport = session.getTransport();
     transport.connect("thuytohuynh@gmail.com","phimhay49day");
     transport.sendMessage(message, message.getAllRecipients());
     Transport.send(message);
   } 
}
