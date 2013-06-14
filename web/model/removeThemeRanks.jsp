<%-- 
    Document   : removeThemeRanks
    Created on : May 31, 2013, 7:50:07 AM
    Author     : 162107
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<!DOCTYPE html>
<html>
    <head>
        <%
            String idString = String.valueOf(session.getAttribute("id"));
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            String sql = "delete from theme_ranking where user_id = " + idString;
            int success = statement.executeUpdate(sql);
            session.setAttribute("message", "Success: Your Rankings have been removed!");
            connection.close();
            statement.close();
            response.sendRedirect("../view/theme.jsp");
            %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
    </body>
</html>
