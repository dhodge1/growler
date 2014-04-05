<%-- 
    Document   : getWinner
    Created on : Apr 5, 2014, 5:11:35 AM
    Author     : David
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page import="com.google.gson.Gson" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    WinnerPersistence wp = new WinnerPersistence();
    ArrayList<Winner> winners = wp.getWinner();
    
    Winner win = winners.get(0);
    Gson gson = new Gson();
    
    String json = gson.toJson(win);
    
    //System.out.println(json);
    out.print(json);
      
%>