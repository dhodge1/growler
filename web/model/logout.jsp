<%-- 
    Document   : logout
    Created on : Mar 12, 2013, 12:19:01 PM
    Author     : Justin Bauguess
    Purpose    : To process logging out of the system
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logging out...</title>
    </head>
    <body>
        <%
            String username = (String) session.getAttribute("user");
            if (username != null) {
                session.removeAttribute("user");
                session.removeAttribute("id");
                session.removeAttribute("message");
            }
            response.sendRedirect("../index.jsp");

        %>  
    </body>
</html>
