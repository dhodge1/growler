<%-- 
    Document   : enablefeature
    Created on : Feb 23, 2014, 7:58:40 PM
    Author     : David
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    int user = 0;
    if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
        response.sendRedirect("../../../index.jsp");
    }
    try {
      user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
    } catch (Exception e) {
    }
    
    FeaturePersistence fp1 = new FeaturePersistence();
    
    int fId = Integer.parseInt(request.getParameter("feature_ID"));
    
    fp1.enableFeatureState(fId);
%>
