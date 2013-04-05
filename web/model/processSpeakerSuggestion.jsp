<%-- 
    Document   : processSpeakerSuggestion
    Created on : Feb 27, 2013, 11:56:46 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of processSpeakerSuggesstion is to allow users or 
                admins to enter a speaker into the database.  It uses the speaker 
                table, and the fields first_name, last_name from user input, and 
                visible and suggested_by as non-user input values.
--%>

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
	<link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
<%@ include file="../includes/header.jsp" %> 

  <% String first_name = request.getParameter("first_name");
     String last_name = request.getParameter("last_name");
     String admin = request.getParameter("admin");
     
     
  Connection connect = dataConnection.sendConnection();
  PreparedStatement insert = connect.prepareStatement(queries.insertSpeaker());
  insert.setString(1, first_name);
  insert.setString(2, last_name);
  //If it's an admin using, use the admin user number
  if (admin == "true") {
      insert.setInt(3, 2023);
  }
  else { //otherwise, use the user's number (which is 0 during the pre-authentication phase)
      insert.setInt(3, 0);
   }
  insert.setInt(4, 0);

  insert.execute();
  connect.close();
  insert.close();
  if (admin == "true") {
      response.sendRedirect("../admin/speaker.jsp");
  }
   else {
      response.sendRedirect("../view/speaker.jsp");
   }
  %>
 
  
<%@ include file="../includes/footer.jsp" %>
<%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
