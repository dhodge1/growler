<%-- 
    Document   : validateKey
    Created on : Oct 1, 2013, 9:17:38 PM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.scripps.growler.*"%>
<% 
    
    String key = request.getParameter("key");
    int sessionId = Integer.parseInt(request.getParameter("sessionId"));
    SessionPersistence sp = new SessionPersistence();
    
    boolean ok = sp.checkKey(key, sessionId);
    
    if (ok) {
        response.getWriter().write("ok");
    }
    else {
        response.getWriter().write("no");
    }
    
    
    
%>