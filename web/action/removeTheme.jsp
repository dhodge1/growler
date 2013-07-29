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
            tp.deleteTheme(t);
            %>