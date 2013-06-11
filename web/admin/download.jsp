<%-- 
    Document   : download
    Created on : Jun 10, 2013, 4:07:56 PM
    Author     : 162107
--%>

<%@page import="com.scripps.growler.ReportGenerator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <% 
        ReportGenerator rg = new ReportGenerator();
        String type = request.getParameter("type");
        if (type == "survey") {
            rg.createReport();
        }
        
        response.sendRedirect("../admin/surveyReport.jsp");
    %>
</html>
