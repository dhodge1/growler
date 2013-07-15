<%-- 
    Document   : processThemes
    Created on : Jul 15, 2013, 9:19:42 AM
    Author     : 162107
--%>

<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Testing the Themes Output</title>
    </head>
    <body>
        <table>
            <tr>
                <td>Param Value</td>
            </tr>
        <% 
            
            String list[] = request.getParameterValues("list");
            
            for (int i = 0; i < list.length; i++) {
                out.print("<tr><td>");
                out.print(list[i]);
                out.print("</td></tr>");
            }
        %>
        </table>
    </body>
</html>
