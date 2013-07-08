<%-- 
    Document   : room
    Created on : Jun 11, 2013, 12:57:59 PM
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
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Admin Rooms</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/demo.css" />  
        <link rel="stylesheet" href="../../../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../../css/theme.css" /><!--Theme CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            String sort = "";
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                sort = request.getParameter("sort");
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                <div class="span8">
                    <h2 class="bordered"><img style="padding-bottom:0" src='../../../images/Techtoberfest2013small.png'/><span class="titlespan">Rooms</span></h2>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="span8">
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <tr>
                            <th>Room Number
                                <a href="room.jsp?sort=number_asc"><i class="icon12-sortUp"></i></a>
                                <a href="room.jsp?sort=number_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Name
                                <a href="room.jsp?sort=name_asc"><i class="icon12-sortUp"></i></a>
                                <a href="room.jsp?sort=name_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Capacity
                                <a href="room.jsp?sort=capacity_asc"><i class="icon12-sortUp"></i></a>
                                <a href="room.jsp?sort=capacity_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Building
                                <a href="room.jsp?sort=building_asc"><i class="icon12-sortUp"></i></a>
                                <a href="room.jsp?sort=building_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Edit</th>
                            <th>Remove</th>
                        </tr>
                        <%
                            LocationPersistence lp = new LocationPersistence();
                            ArrayList<Location> locations = lp.getAllLocations(" ");
                            try {
                                if (sort.equals("number_asc")) {
                                    locations = lp.getAllLocations(" order by id asc");
                                } else if (sort.equals("number_desc")) {
                                    locations = lp.getAllLocations(" order by id desc");
                                } else if (sort.equals("name_asc")) {
                                    locations = lp.getAllLocations(" order by description asc");
                                } else if (sort.equals("name_desc")) {
                                    locations = lp.getAllLocations(" order by description desc");
                                } else if (sort.equals("capacity_asc")) {
                                    locations = lp.getAllLocations(" order by capacity asc");
                                } else if (sort.equals("capacity_desc")) {
                                    locations = lp.getAllLocations(" order by capacity desc");
                                } else if (sort.equals("building_asc")) {
                                    locations = lp.getAllLocations(" order by building asc");
                                } else if (sort.equals("building_desc")) {
                                    locations = lp.getAllLocations(" order by building desc");
                                }
                            } catch (Exception e) {
                            }
                            for (int i = 0; i < locations.size(); i++) {
                                out.print("<tr>");
                                out.print("<td>");
                                out.print(locations.get(i).getId());
                                out.print("</td>");
                                out.print("<td>");
                                out.print(locations.get(i).getDescription());
                                out.print("</td>");
                                out.print("<td>");
                                out.print(locations.get(i).getCapacity());
                                out.print("</td>");
                                out.print("<td>");
                                out.print(locations.get(i).getBuilding());
                                out.print("</td>");
                                out.print("<td><a href=\"editroom.jsp?id=" + locations.get(i).getId() + "\">Edit</td>");
                                out.print("<td><a href=\"../../../action/deleteroom.jsp?id=" + locations.get(i).getId() + "\">Delete</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                    <a href="addroom.jsp" class="button button-primary" id="add">Add a New Room</a>
                </div>
            </div>
        </div>


        <%@ include file="../../../includes/footer.jsp" %>
        <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>