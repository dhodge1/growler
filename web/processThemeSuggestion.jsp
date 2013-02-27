<%-- 
    Document   : processThemeSuggestion
    Created on : Feb 26, 2013, 11:51:27 PM
    Author     : Robert Brown
--%>
<jsp:useBean id="processTheme" class="com.scripps.growler.ProcessThemeSuggestion" />
<jsp:setProperty name = "processTheme" property = "*" />
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
  <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
  <header class="pageHeader">
    <div class="pageHeader-portal">
      <div class="pageHeader-logo">
        <a href="/"></a>
      </div>
    </div>
  </header><!-- /.pageHeader -->
	<nav class="globalNavigation">
        <ul>
            <li class="selected"><a href="index.jsp">Themes</a></li>
            <li><a href="themeentry.jsp">Suggest a Theme</a></li>
            <li><a href="">Speakers</a></li>
            <li><a href="">Suggest a Speaker</a></li>
            <li><a href="">Help</a></li>
        </ul>
  </nav><!-- /.globalNavigation -->

  <% String name = request.getParameter("name");
     String description = request.getParameter("description");
     String reason = request.getParameter("reason");
     
    out.println(name); 
  Connection connect = dataConnection.sendConnection();
  PreparedStatement insert = connect.prepareStatement(queries.insertTheme());
  insert.setInt(1 , dataConnection.countRows());
  insert.setString(2, name);
  insert.setString(3, description);
  insert.setString(4, reason);
  insert.setInt(5, 2023);
  insert.setBoolean(6, false);
  insert.setBoolean(7, false);
  insert.execute();
  %>

  <footer class="pageFooter">
    <hr />
    <p>Scripps Networks Interactive Bootstrap version 1.2.0.<!-- Application name --></p>
    <p>Copyright &copy; 2013 Scripps Networks Interactive</p>
  </footer><!-- /.pageFooter -->
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="jquery.sortable.js"></script><!--Drag and drop for non-iOS-->
	<script src="js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
	<script src="js/libs/jquery.dataTables.1.9.3.min.js" type="text/javascript"></script>
	<script src="js/libs/sniui.dataTables.1.0.0.min.js" type="text/javascript"></script>
    </body>
</html>
