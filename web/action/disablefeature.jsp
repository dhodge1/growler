<%-- 
    Document   : disablefeature
    Created on : Feb 23, 2014, 7:59:12 PM
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
    
    FeaturePersistence fp2 = new FeaturePersistence();
    
    int fId = Integer.parseInt(request.getParameter("feature_ID"));
    
    fp2.disableFeatureState(fId);  
%>
