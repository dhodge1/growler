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
        
        
        
        
            ReportGenerator rg = new ReportGenerator();
            String result = rg.createReport();
            
            out.print(result);
            %>
    </body>
</html>
