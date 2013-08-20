<%-- 
    Document   : headerdump
    Created on : Jun 5, 2013, 10:05:27 AM
    Author     : 162107
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="com.scripps.growler.DataConnection" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Dump Page</title>
    </head>
    <body>
        <h2>cookie monster</h2>
        <%

        %>
        <h1>These are the Headers we are receiving</h1>
        <%
            
            Enumeration<String> headerNames = request.getHeaderNames();
            out.print("<table>");
            out.print("<tr>");
            out.print("<th>");
            out.print("Header Name");
            out.print("</th>");
            out.print("<th>");
            out.print("Content");
            out.print("</th>");
            out.print("</tr>");
            while (headerNames.hasMoreElements()){
                String header = headerNames.nextElement();
                out.print("<tr>");
                out.print("<td>");
                out.print(header);
                out.print("</td>");
                out.print("<td>");
                out.print(request.getHeader(header));
                out.print("</td>");
                out.print("</tr>");
            }
            out.print("</table>");
            
            %>
            <h2>Session Variables</h2>
            <%
            Enumeration sessionVars = session.getAttributeNames();
            
            out.print("<table>");
            out.print("<tr>");
            out.print("<th>");
            out.print("Header Name");
            out.print("</th>");
            out.print("<th>");
            out.print("Content");
            out.print("</th>");
            out.print("</tr>");
            while (sessionVars.hasMoreElements()){
                String sessionInfo = (String)sessionVars.nextElement();
                out.print("<tr>");
                out.print("<td>");
                out.print(sessionInfo);
                out.print("</td>");
                out.print("<td>");
                out.print(session.getAttribute(sessionInfo));
                out.print("</td>");
                out.print("</tr>");
            }
            out.print("</table>");
            
            %>
            <h2>Cookies</h2>
            <%
            Cookie[] cookies2 = request.getCookies();
            for (int i = 0; i < cookies2.length; i++) {
                out.print(cookies2[i].getName() + ": " + cookies2[i].getValue() + "<br/>");
            }

            
            %>
    </body>
</html>