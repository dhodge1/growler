<%-- 
    Document   : messagehandler
    Created on : Jun 14, 2013, 9:07:20 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  //Displaying error or success messages -- clear it out when done
    String message = (String) session.getAttribute("message");
    if (message != null && message.startsWith("Success")) {
        out.print("<p class=feedbackMessage-success>" + message + "</p>");
        session.removeAttribute("message");
    } else if (message != null && message.startsWith("Error")) {
        out.print("<p class=feedbackMessage-error>" + message + "</p>");
        session.removeAttribute("message");
    }
%>
