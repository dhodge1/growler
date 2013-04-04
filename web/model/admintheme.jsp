<%-- 
    Document   : admintheme
    Created on : Apr 2, 2013, 2:56:26 PM
    Author     : Justin Bauguess
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
	<link rel="stylesheet" href="../js/draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
 <%@ include file="../includes/header.jsp" %> 
 <nav class="globalNavigation">
        <ul>
            <li><a href="../view/theme.jsp">Themes</a></li>
            <li><a href="../view/themeentry.jsp">Suggest a Theme</a></li>
            <li><a href="../view/themedescription.jsp">Theme Descriptions</a></li>
            <li><a href="../view/speaker.jsp">Speakers</a></li>
            <li><a href="../view/speakerentry.jsp">Suggest a Speaker</a></li>
            <li><a href="">Help</a></li>
        </ul>
  </nav><!-- /.globalNavigation -->
  <% String list[] = request.getParameterValues("list");
    String visible[] = request.getParameterValues("visible");
 int ids[] = new int[list.length];
 for (int i = 0; i < list.length; i++) {
     ids[i] = Integer.parseInt(list[i]);
 }
 int[] visibles = new int[visible.length];
 for (int i = 0; i < visible.length; i++) {
     visibles[i] = Integer.parseInt(visible[i]);
 }
 Connection connection = dataConnection.sendConnection();
 Statement statement = connection.createStatement();
 PreparedStatement insert = connection.prepareStatement(queries.promoteTheme());
 for (int j = 0; j < ids.length; j++) {
    if (Arrays.binarySearch(visibles, ids[j]) >= 0){
        insert.setInt(1, 1);
       }
       else {
        insert.setInt(1, 0);
       }
    insert.setInt(2, ids[j]);
    insert.execute();
 }
connection.close();
statement.close();
insert.close();
response.sendRedirect("../admin/theme.jsp");
%>
<%@ include file="../includes/footer.jsp" %> 
<%@ include file="../includes/scriptlist.jsp" %>
<%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>