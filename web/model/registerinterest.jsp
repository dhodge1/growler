<%-- 
    Document   : registerinterest
    Created on : Jun 11, 2013, 9:04:19 AM
    Author     : 162107
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Techtoberfest Sessions</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <%
                    int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
    <%
        //Get the necessary values
        
        String[] interest = request.getParameterValues("interest");
        String[] names = request.getParameterValues("name");
        //Convert the List of sessionIDs into integers   
        int ids[] = new int[names.length];
        for (int i = 0; i < ids.length; i++) {
            ids[i] = Integer.parseInt(names[i]);
        }
        //Clear out the old ranks
        DataConnection dc = new DataConnection();
        Connection connection = dc.sendConnection();
        Statement dstatement = connection.createStatement();
        dstatement.execute("delete from registration where user_id = " + user);
        try {
            //Convert the List of registered sessionIDs into integers   
            int interests[] = new int[interest.length];
            for (int i = 0; i < interest.length; i++) {
                interests[i] = Integer.parseInt(interest[i]);
            }
            PreparedStatement statement = connection.prepareStatement("insert into registration (user_id, session_id, date_registered, time_registered) "
                    + " values (?, ?, curdate(), curtime())");
            //Search through the array for values to enter
            Arrays.sort(interests);
            Arrays.sort(ids);
            for (int i = 0; i < ids.length; i++) {
                if (Arrays.binarySearch(interests, ids[i]) >= 0) {
                    try {
                        statement.setInt(1, user);
                        statement.setInt(2, ids[i]);
                        statement.execute();
                    } catch (Exception e) {
                    }
                }
            }
            session.setAttribute("message", "Success: Your interest has been registered!");
        } catch (Exception e) {
            session.setAttribute("message", "Success: Your interests have been removed!");
        }
        //Prepare SQL

        response.sendRedirect("../view/sessionschedule.jsp");

    %>

</html>
