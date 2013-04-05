<%-- 
    Document   : adminspeaker.jsp
    Created on : Mar 5, 2013, 8:13:49 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of adminspeaker.jsp is for admins to be able to
                edit the speaker data.  The data that can be edited will be:
                2012 rank, the count of 2012 ranks, and whether or not it is 
                visible to the regular users.  It uses the ranks_2012 table, and
                speaker table.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="application" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="application" />
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
            <li class="selected"><a href="../view/speaker.jsp">Speakers</a></li>
            <li><a href="../view/speakerentry.jsp">Suggest a Speaker</a></li>
            <li><a href="">Help</a></li>
        </ul>
  </nav><!-- /.globalNavigation -->
  <% String list[] = request.getParameterValues("list");
    String rank[] = request.getParameterValues("newrank");
    String count[] = request.getParameterValues("newcount");
    String visible[] = request.getParameterValues("visible");
    
 //Convert the List of IDs into integers   
 int ids[] = new int[list.length];
 for (int i = 0; i < ids.length; i++) {
     ids[i] = Integer.parseInt(list[i]);
 }
 //Get the list of visibles from the check boxes
int visibles[] = new int[visible.length];
for (int i = 0; i < visibles.length; i++){
    visibles[i] = Integer.parseInt(visible[i]);
}
 //Convert the list of Rankings into doubles
 double ranks[] = new double[rank.length];
 for (int i = 0; i < ranks.length; i++) {
     ranks[i] = Double.parseDouble(rank[i]);
 }
 //Convert the list of Counts into integers
 int counts[] = new int[count.length];
 for (int i = 0; i < counts.length; i++) {
     counts[i] = Integer.parseInt(count[i]);
 }
 
 Connection connection = dataConnection.sendConnection();
 Statement statement = connection.createStatement();
 PreparedStatement insert = connection.prepareStatement(queries.updateSpeakerRankings());
 //update all the speaker rankings and counts
 for (int j = 0; j < ranks.length; j++) {
    insert.setDouble(1, ranks[j]);
    insert.setInt(2, counts[j]);
    insert.setInt(3, ids[j]);
    insert.execute();
 }
 PreparedStatement visibility = connection.prepareStatement(queries.promoteSpeaker());
 //Sort the array before using binary search
 Arrays.sort(visibles);
 //If the key is in the visibles array, we know the admin wants it visible
 for (int k = 0; k < ids.length; k++) {
     if (Arrays.binarySearch(visibles, ids[k]) >= 0 ) {
         visibility.setInt(1, 1);
     }
     else {
         visibility.setInt(1, 0);
     }
     visibility.setInt(2, ids[k]);
     visibility.execute();
 }
connection.close();
statement.close();
insert.close();
visibility.close();
response.sendRedirect("../admin/speaker.jsp");
%>
<%@ include file="../includes/footer.jsp" %> 
<%@ include file="../includes/scriptlist.jsp" %>
<%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>