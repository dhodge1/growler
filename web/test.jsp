<%-- 
    Document   : test
    Created on : Jun 4, 2013, 10:49:25 AM
    Author     : 162107
--%>

<%@page import="java.util.Enumeration"%>
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
            Enumeration<String> headers = request.getHeaderNames();
            while (headers.hasMoreElements()) {
                String hold = headers.nextElement();
                out.print(hold + ":" + request.getHeader(hold) + "<br/>");
            }
            
            
            %>
    </body>
</html>
