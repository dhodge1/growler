<%-- 
    Document   : processThemeSuggestion
    Created on : Feb 26, 2013, 11:51:27 PM
    Author     : Robert Brown
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="application" />
<jsp:setProperty name="dataConnection" property = "*" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="application" />
<jsp:setProperty name="queries" property = "*" />
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
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
<%@ include file="../includes/header.jsp" %> 

  <% String name = request.getParameter("name");
     String description = request.getParameter("description");
     String reason = "";
     int user = 0;
     if (request.getParameter("reason") != null)
     {
        reason = request.getParameter("reason");
     }
     else {
        reason = " ";
        user = 2023;
     }
  Connection connect = dataConnection.sendConnection();
  PreparedStatement insert = connect.prepareStatement(queries.insertUserTheme());
  insert.setString(1, name);
  insert.setString(2, description);
  insert.setString(3, reason);
  insert.setInt(4, user);
  insert.setBoolean(5, false);
  insert.setBoolean(6, false);
  insert.execute();
  %>
  <% if (request.getParameter("reason") != null) { %>
  <jsp:forward page="../view/theme.jsp"/>
  <%
   }
   else {
     %><jsp:forward page="../admin/theme.jsp"/>
   <% }
  %>
 <%@ include file="../includes/footer.jsp" %> 
 <%@ include file="../includes/scriptlist.jsp" %> 
    </body>
</html>
