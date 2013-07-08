<%-- 
    Document   : editroom
    Created on : Jun 11, 2013, 1:28:02 PM
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
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
        </style>

        <script src="../../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
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

                <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/><span>Edit a Room</span></h2>

            </div>
            <br/>
            <div class="row">

                <%
                    String id = "TBD";
                    LocationPersistence lp = new LocationPersistence();
                    Location location;
                    try {
                        id = request.getParameter("id");
                        location = lp.getLocationById(id);
                    } catch (Exception e) {
                        id = "TBD";
                        location = lp.getLocationById("TBD");
                    }


                %>
                <form id="action" method="post" action="../../../action/processroom.jsp">
                    <div class="form-group">
                        <label class="required">Room ID:</label>
                        <input type="text" maxlength="10" id="tip" name="id" class="input-xlarge" value="<% out.print(location.getId());%>" data-content="Room ID, 10 Characters or Less"/><br/>
                        <span id="error_id" class="message_container">
                            <span>Please Enter a Room ID</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Room Name:</label>
                        <input type="text" maxlength="20" id="tip1" name="name"  class="input-xlarge" value="<% out.print(location.getDescription());%>" data-content="Room Name, 20 Characters or Less"/><br/>
                        <span id="error_name" class="message_container">
                            <span>Please Enter a Room Name</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Capacity:</label>
                        <% out.print("<input value=\"" + location.getCapacity() + "\" type=\"number\" min=\"0\" max=\"999\" step=\"1\" id=\"tip2\" name=\"capacity\"  data-content=\"Maximum Capacity, 0 to 999\"/>");%><br/>
                        <span id="error_capacity" class="message_container">
                            <span>Please Enter a Capacity</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Building Name:</label>
                        <select id="building" name="building">
                            <% String building = "";
                                try {
                                    building = location.getBuilding();
                                } catch (Exception e) {
                                    building = "TBD";
                                }
                            %>
                            <option value="0"> - Please Select a Building- </option>
                                    <option value="KXTC" <% if (building.equals("KXTC")) {
                                            out.print(" selected ");
                                        }%>>Knoxville Tech Center</option>
                            <option value="KXOFFICE" <% if (building.equals("KXOFFICE")) {
                                    out.print(" selected ");
                                }%>>Knoxville Office</option>
                                    <option value="TBD" <% if (building.equals("TBD")) {
                                            out.print(" selected ");
                                        }%>>TBD</option>
                        </select>
                        <span id="error_building" class="message_container">
                            <span>Please Select a Building</span>
                        </span>
                    </div>
                    <br/>
                    <br/>
                    <input id="send" type="submit" value="Submit Changes" class="button button-primary"/>
                    <a id="cancel" class="button" href="room.jsp">Cancel</a>
                </form>

            </div>
        </div>


        <%@ include file="../../../includes/footer.jsp" %>
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="../../../js/addroom.js"></script>


    </body>
</html>
