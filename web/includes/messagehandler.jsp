<%-- 
    Document   : messagehandler
    Created on : Jun 14, 2013, 9:07:20 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  //Displaying error or success messages -- clear it out when done
    //Success messages start with "Success:", therefore we trim off the first 8 chars
    //Error messages start with "Error:", therefore we trim off the first 6 chars
    //The messages are sent (typically) from the pages in the action folder.
    String message = (String) session.getAttribute("message");
    String sessionName = "";
    if (message != null && message.startsWith("Success:") && !message.contains("Attendance")) {
        message = message.substring(8, message.length());
        out.print("<p class=feedbackMessage-success>" + message + "</p>");
        session.removeAttribute("message");
    } else if (message != null && message.startsWith("Success: Attendance")) {
        sessionName = (String) session.getAttribute("sessionName");
        message = message.substring(8, message.length());
        out.print("<p class=feedbackMessage-success>" + message + "</p>");
        out.print("<div id='modalDialog' title='Successfully Acknowledged Attendance'>");
        out.print("<p>Please take a survey.</p><p>This will enter you in a drawing for a fantastic prize.</p></div>");
        out.print("<div id='thanksDialog' title='Thanks Anyway'>");
        out.print("<p>Thanks anyway. You can always take a survey later.</p></div>");
        session.removeAttribute("message");
    } else if (message != null && message.startsWith("Error:")) {
        message = message.substring(6, message.length());
        out.print("<p class=feedbackMessage-error>" + message + "</p>");
        session.removeAttribute("message");
    } else if (message != null) {
        out.print("<p class=feedbackMessage-info>" + message + "</p>");
        session.removeAttribute("message");
    }
%>