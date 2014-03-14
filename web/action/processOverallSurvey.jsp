<%-- 
    Document   : processOverallSurvey
    Created on : Mar 13, 2014, 9:53:26 PM
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
  int q4 = 0;
  String comments = "";
  if (request.getParameter("q4") != null) {
    q4 = Integer.parseInt(request.getParameter("q4"));
  }
  if (request.getParameter("comment") != null) {
    comments = request.getParameter("comment");
  }
  
  SurveyPersistence sp = new SurveyPersistence();
  sp.submitOverallSurvey(q1, q2, q3, q4, comments);

  sp.insertSurveyCheck(Integer.parseInt(String.valueOf(session.getAttribute("id"))), 1);
  
  response.sendRedirect("../private/employee/overallSurveySubmitted.jsp");
%>
