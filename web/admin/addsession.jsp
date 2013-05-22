<%-- 
    Document   : addsession
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of addsession(admin) is to allow the admin to add
                a new session to the database.
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
        <title>Growler Project</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script>
            $(function() {
                $("#datepicker").datepicker();
            });
        </script>
    </head>
    <body id="growler1">
        <%@include file="../includes/isadmin.jsp" %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="content">
                <!-- Begin Content -->
                <div class="row">
                    <div class="span12">
                        <img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/>  <!-- Techtoberfest logo-->
                        <h1 class = "bordered">Sessions</h1>
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span2">
                                    <p></p>
                                </div>
                                <div class="span6">
                                    <section>
                                        <form method="post" action="../model/processSession.jsp">
                                            <table>
                                                <tr>
                                                    <td>Session Name</td>
                                                    <td>Date</td>
                                                    <td>Time</td>
                                                    <td>Duration</td>
                                                    <td>Location</td>

                                                </tr>
                                                <tr>
                                                    <td><input name="name" type="text"/></td>
                                                    <td><input name="date" id="datepicker" type="text"/></td>
                                                    <td><select name="time">
                                                            <option value="09:00:00">9:00 AM</option>
                                                            <option value="09:00:00">9:30 AM</option>
                                                            <option value="10:00:00">10:00 AM</option>
                                                            <option value="10:30:00">10:30 AM</option>
                                                            <option value="11:00:00">11:00 AM</option>
                                                            <option value="11:30:00">11:30 AM</option>
                                                            <option value="12:00:00">12:00 PM</option>
                                                            <option value="12:30:00">12:30 PM</option>
                                                            <option value="13:00:00">1:00 PM</option>
                                                            <option value="13:30:00">1:30 PM</option>
                                                            <option value="14:00:00">2:00 PM</option>
                                                            <option value="14:30:00">2:30 PM</option>
                                                            <option value="15:00:00">3:00 PM</option>
                                                            <option value="15:30:00">3:30 PM</option>
                                                            <option value="16:00:00">4:00 PM</option>
                                                            <option value="16:30:00">4:30 PM</option>
                                                        </select></td>
                                                    <td><input name="duration" type="number"/></td>
                                                    <td><input name="location" type="number"/></td>
                                                </tr>
                                            </table>
                                            <input type="submit" value="Submit"/>
                                        </form>
                                    </section>
                                </div>
                                <div class="span4">
                                    <p></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Content -->
            </div>	
        </div>
        <div class="row">
            <div class="span8">
                <p></p>
            </div>
            <div class="span2">
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
