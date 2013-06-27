<%-- 
    Document   : test
    Created on : Jun 4, 2013, 10:49:25 AM
    Author     : 162107
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String[] scrippsHeaders = new String[4];
scrippsHeaders[0] = "SN-USER";
scrippsHeaders[1] = "SN-AD-FIRST-NAME";
scrippsHeaders[2] = "SN-AD-LAST-NAME";
scrippsHeaders[3] = "SN-AD-EMAIL";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
            
            <%
        RegistrationPersistence rp = new RegistrationPersistence();
        ArrayList<Attendance> list = rp.getRegisteredWhoAttended();
        
        for (int i = 0; i < list.size(); i++) {
            out.print(list.get(i).getSessionId());
            out.print(" was attended by ");
            out.print(list.get(i).getUserId());
            out.print(" who actually registered interest.<br/>");
        }
            %>
    </body>
</html>
