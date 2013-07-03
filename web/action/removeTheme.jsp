<%-- 
    Document   : removeTheme
    Created on : May 31, 2013, 11:02:30 AM
    Author     : 162107
	Purpose	   : Allows an admin to delete a theme from the database
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />

        <%
                    int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
            
            String idString = request.getParameter("id");
            ThemePersistence tp = new ThemePersistence();
            Theme t = tp.getThemeByID(Integer.parseInt(idString));
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            String sql = "delete from theme where id = " + idString;
            int success = statement.executeUpdate(sql);
            
            session.setAttribute("message", "Success: The theme " + t.getName() +  " has been deleted!");
            connection.close();
            statement.close();
            response.sendRedirect("../private/employee/admin/theme.jsp");
            %>