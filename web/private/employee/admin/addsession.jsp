<%-- 
    Document   : addsession
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : 
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
        <title>Add a Session</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
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
                
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;width:165px;" src='../../../images/Techtoberfest2013small.png'/><span class="titlespan">Add a Session</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <%
                        SessionPersistence sp = new SessionPersistence();
                        ArrayList<Session> sessions = sp.getAllSessionsWithKeys(" ");
                    %>
                    <form method="post" action="../../../action/processSession.jsp" onSubmit="return validateValues();">
                        <div class="form-group">
                            <label class="required">Session Name: </label>
                            <input id="name" size='50' name="name" type="text" data-content="Enter the name of the Session" maxlength="70"/>
                        </div>
                        <div class="form-group">
                            <label class="required">Session Description: </label>
                            <textarea id="description" name="description" maxlength="250" rows="5" cols="50" data-content="Enter the name of the Session" ></textarea>
                        </div>
                        <div class="form-group">
                            <label>Date: </label>
                            <input name="date" id="datepicker" type="text" data-content="Enter a date for the Session"/>
                        </div>
                        <div class="form-group">
                            <label>Time: </label>
                            <select id="time" name="time">
                                <option value="null"> - No Time - </option>
                                <option value="08:00:00">8:00 AM</option>
                                <option value="08:30:00">8:30 AM</option>
                                <option value="09:00:00">9:00 AM</option>
                                <option value="09:30:00">9:30 AM</option>
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
                                <option value="17:00:00">5:00 PM</option>
                                <option value="17:30:00">5:30 PM</option>
                                <option value="18:00:00">6:00 PM</option>
                                <option value="18:30:00">6:30 PM</option>
                                <option value="19:00:00">7:00 PM</option>

                            </select>
                        </div>
                        <div class="form-group">
                            <label>Duration: </label>
                            <input id="duration" name="duration" type="number" step="1" max="120" min="15" data-content="Enter duration in minutes (Between 15 and 120)" />
                        </div>
                        <div class="form-group">
                            <label class="required">Location: </label>
                            <select name="location">
                                <%
                                    LocationPersistence lp = new LocationPersistence();
                                    ArrayList<Location> locations = lp.getAllLocations();
                                    for (int i = 0; i < locations.size(); i++) {
                                        out.print("<option value=" + locations.get(i).getId() + ">" + locations.get(i).getDescription() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-actions">
                            <input class="button button-primary" type="submit" value="Submit"/>
                        </div>
                    </form>
                
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script>
                                            $(function() {
                                                $("#datepicker").datepicker({minDate: new Date(2013, 10 - 1, 1), maxDate: new Date(2013, 10 - 1, 31)}).change(function() {
                                                    $("#datepicker").datepicker("option", "dateFormat", "yy-mm-dd");
                                                });
                                                ;
                                            });

        </script>
        <script>
            $(function() {
                $("input").autoinline();
            });
            function validateValues() {
                //Get the Duration value, make sure it's within the threshold, isn't blank, and is a number
                var myname = document.getElementById("name");
                if (!myname.value) {
                    alert('Please enter a Session Name');
                    myname.focus();
                    return false;
                }
                var mydesc = document.getElementById("description");
                if (!mydesc.value) {
                    alert('Please enter a Session Description');
                    mydesc.focus();
                    return false;
                }
                //  var mydate = document.getElementById("datepicker");
                //  if (!mydate.value) {
                //      alert('Please enter a date');
                //      mydate.focus();
                //      return false;
                //  }
                //  var myval = document.getElementById("duration");
                //  if (myval.value < 15 || myval.value > 120 || !myval.value || isNaN(myval.value)) {
                //      alert('Duration must be between 15 and 120');
                //      myval.focus();
                //      return false;
                //  }
                //  var mylocation = document.getElementById("location");
                //  if (!mylocation.value) {
                //      alert('Please enter a location');
                //      mylocation.focus();
                //      return false;
                //  }
                return true;
            }
        </script>
    </body>
</html>