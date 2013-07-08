<%-- 
    Document   : processThemeEdit
    Created on : Jun 4, 2013, 2:58:43 PM
    Author     : 162107
	Purpose    : Allows an admin to edit a theme's information
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@include file="../includes/isadmin.jsp" %>
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
                %>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String desc = request.getParameter("description");
        String reason = request.getParameter("reason");
        String creator = request.getParameter("creator");
        
        ThemePersistence tp = new ThemePersistence();
        Theme t = new Theme();
        t.setId(id);
        t.setName(name);
        t.setDescription(desc);
        t.setReason(reason);
        t.setCreatorId(Integer.parseInt(creator));
        if (request.getParameter("visible").equals("true")) {
            t.setVisible(true);
        }
        else {
            t.setVisible(false);
        }
        tp.updateTheme(t);
        
        session.setAttribute("message", "Success: Theme successfully changed");
        response.sendRedirect("../private/employee/admin/theme.jsp");
    %>