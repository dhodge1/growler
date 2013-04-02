<%-- 
    Document   : login
    Created on : Mar 12, 2013, 12:15:42 PM
    Author     : Robert Brown
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            
        String username = request.getParameter("username");            
        String password = request.getParameter("password");           
        out.println("Checking login<br>");            
        if (username == null || password == null) {                
            out.print("Invalid paramters ");            
        }            
        // Here you put the check on the username and password            
        if (username.toLowerCase().trim().equals("admin") && password.toLowerCase().trim().equals("admin")) {
                   out.println("Welcome " + username + " <a href=\"/ProjectGrowler/index.jsp\">Back to main</a>");                
                   session.setAttribute("Admin", username);             
                          %><jsp:forward page="../admin/theme.jsp"/> <%
           }           
        else {                
            out.println("Invalid username and password");
            session.setAttribute("anon", username);
                          %> <jsp:forward page="../view/theme.jsp"/><%
        }%> 
    </body>
</html>
