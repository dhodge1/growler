<%-- 
    Document   : processThemeEdit
    Created on : Jun 4, 2013, 2:58:43 PM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@include file="../includes/isadmin.jsp" %>
<!DOCTYPE html>
<html>
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
        
        session.setAttribute("message", "Theme successfully changed");
        response.sendRedirect("../admin/theme.jsp");
        
    %>

</html>
