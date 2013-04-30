<%-- 
    Document   : processThemeRanking
    Created on : Mar 5, 2013, 3:31:47 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of processThemeRanking is to process the data submitted 
                from theme.jsp.  It will rank the top ten themes only, the store them
                in the database.  For intial user stories, it will be placed in 
                the isolated_theme_ranking table.  Once users are remembered, it
                will be modified to store data in the theme_ranking table.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>Growler Project</title><!-- Title -->
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../js/draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
 <%@ include file="../includes/header.jsp" %> 
 <%@ include file="../includes/usernav.jsp" %>
 <% String list[] = request.getParameterValues("list");
 int ids[] = new int[list.length];
 for (int i = 0; i < list.length; i++) {
     ids[i] = Integer.parseInt(list[i]);
 }
 String idString = String.valueOf(session.getAttribute("id"));
 int id = Integer.parseInt(idString);
 Connection connection = dataConnection.sendConnection();
 Statement statement = connection.createStatement();
 ResultSet result = statement.executeQuery("select user_id from theme_ranking where user_id = " + id);
 //Check to see if the user already has voted.  If so, redirect to the theme page
 boolean a = false;
 while(result.next()){
    a = true;
 }
 if (a) {
     out.print("You have already voted!");
 }
 else {
 //If they haven't voted, take their votes and put them in the database
 PreparedStatement insert = connection.prepareStatement(queries.insertThemeRanks());
 //three fields to put: theme_ID (int), user_id (int), theme_rank (int)
 for (int j = 0; j < list.length && j < 10; j++) {
     insert.setInt(1, ids[j]);
     insert.setInt(2, id);
     insert.setInt(3, 10-j);
     insert.execute();
 }
 insert.close();
 out.print("Your votes have been recorded!");
 }
 response.sendRedirect("../view/theme.jsp");
 connection.close();
 statement.close();
 result.close();
 %>
 
<%@ include file="../includes/footer.jsp" %> 
<%@ include file="../includes/scriptlist.jsp" %>
<%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>
