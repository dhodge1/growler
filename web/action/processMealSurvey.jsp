<%-- 
    Document   : processMealSurvey
    Created on : Mar 22, 2014, 1:51:14 AM
    Author     : David
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
  
  int q1 = Integer.parseInt(request.getParameter("q1"));
  int q2 = Integer.parseInt(request.getParameter("q2"));
  int q3 = Integer.parseInt(request.getParameter("q3"));
  String comments = "";
  if (request.getParameter("comment") != null) {
    comments = request.getParameter("comment");
  }
  
  SurveyPersistence sp = new SurveyPersistence();
  sp.submitMealSurvey(q1, q2, q3, comments);

  sp.insertMealSurveyCheck(Integer.parseInt(String.valueOf(session.getAttribute("id"))), 1);
  
  response.sendRedirect("../private/employee/mealSurveySubmitted.jsp");
%>
