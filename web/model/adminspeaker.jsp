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
        <title>Techtoberfest</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../js/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <% String list[] = request.getParameterValues("list");
            String first[] = request.getParameterValues("first");
            String last[] = request.getParameterValues("last");
            String rank[] = request.getParameterValues("newrank");
            String count[] = request.getParameterValues("newcount");
            String visible[] = request.getParameterValues("visible");
            String lastyear[] = request.getParameterValues("lastyear");

            
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            PreparedStatement insert = connection.prepareStatement(queries.updateSpeakerRankings());
            
            //Convert the List of IDs into integers   
            int ids[] = new int[list.length];
            for (int i = 0; i < ids.length; i++) {
                ids[i] = Integer.parseInt(list[i]);
            }
            
            
            //Get the list of visibles from the check boxes
            int visibles[] = new int[visible.length];
            for (int i = 0; i < visibles.length; i++) {
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

            //Get if the speaker spoke last year
            int lasts[] = new int[lastyear.length];
            for (int i = 0; i < lasts.length; i++) {
                lasts[i] = Integer.parseInt(lastyear[i]);
            }


            Arrays.sort(lasts);
            //delete any entries that are flagged as not speaking last year
            PreparedStatement delete = connection.prepareStatement("delete from ranks_2012 where speaker_id = ?");
            for (int k = 0; k < ranks.length; k++) {
                if (Arrays.binarySearch(lasts, ids[k]) < 0) {
                    delete.setInt(1, ids[k]);
                    delete.execute();
                }
            }

            //look for and add any new entries
            PreparedStatement add = connection.prepareStatement("insert into ranks_2012 (speaker_id, rating, count) values (?, ?, ?)");
            for (int k = 0; k < ranks.length; k++) {
                if ((Arrays.binarySearch(lasts, ids[k]) >= 0) && ranks[k] > 0 && counts[k] > 0) {
                    add.setInt(1, ids[k]);
                    add.setDouble(2, ranks[k]);
                    add.setInt(3, counts[k]);
                    try {
                    add.execute();
                    }
                    catch (Exception e) {
                        
                    }
                }
            }

            //update all the speaker rankings and counts
            for (int j = 0; j < ranks.length; j++) {
                if ((Arrays.binarySearch(lasts, ids[j]) >= 0)) { //if they are listed as yes for last year
                    insert.setDouble(1, ranks[j]);
                    insert.setInt(2, counts[j]);
                    insert.setInt(3, ids[j]);
                    insert.execute();
                }
            }
            PreparedStatement visibility = connection.prepareStatement(queries.promoteSpeaker());
            //Sort the array before using binary search
            Arrays.sort(visibles);
            //If the key is in the visibles array, we know the admin wants it visible
            for (int k = 0; k < ids.length; k++) {
                if (Arrays.binarySearch(visibles, ids[k]) >= 0) {
                    visibility.setInt(1, 1);
                } else {
                    visibility.setInt(1, 0);
                }
                visibility.setInt(2, ids[k]);
                visibility.execute();
            }
            PreparedStatement nameUpdate = connection.prepareStatement("update speaker " +
                    "set first_name = ?, last_name = ? where id = ?");
            for (int l = 0; l < ids.length; l++) {
                nameUpdate.setString(1, first[l]);
                nameUpdate.setString(2, last[l]);
                nameUpdate.setInt(3,ids[l]);
                nameUpdate.execute();
            }
            
            connection.close();
            statement.close();
            insert.close();
            visibility.close();
            session.setAttribute("message", "Success: Updates Successful");
            response.sendRedirect("../admin/speaker.jsp");
        %>
        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
        <%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>