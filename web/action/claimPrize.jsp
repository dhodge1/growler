<%-- 
    Document   : claimPrize
    Created on : Apr 5, 2014, 5:38:02 AM
    Author     : David
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page import="com.google.gson.Gson;" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    WinnerPersistence wp = new WinnerPersistence();
    Gson gson = new Gson();
    
    String winner = request.getParameter("winner");
    
    Winner win = gson.fromJson(winner, Winner.class);
    
    wp.claimPrize(win);
%>