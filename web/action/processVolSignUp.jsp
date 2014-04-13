<%-- 
    Document   : processVolSignUp
    Created on : Apr 13, 2014, 9:48:51 AM
    Author     : Shaun
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
  } catch (Exception e) {
  }  
  
  String tasks = "", times = "";
  
  
  if (request.getParameter("tasks") != null) {
    tasks = request.getParameter("tasks");
  }else{
      tasks = "No Data Submitted.";
  }
  if (request.getParameter("times") != null) {
    times = request.getParameter("times");
  }else{
      times = "No Data Submitted.";
  }
  
  SurveyPersistence sp = new SurveyPersistence();
  sp.submitVolSignUpSurvey(user, tasks, times);

  response.sendRedirect("../private/employee/volSignUpConfirmation.jsp");
%>