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
        <title>Manage Rooms</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            .table {
                margin-bottom: 0px;
            }
            .pullRight {
                float:right;
                font-weight: normal;
                font-family: Arial;
                font-size: 11px;
                position: relative;
                top: 30px;
            }
            .modals{
                display:none;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
            h1, h3 {
                font-weight: normal;
            }
            .pager li {
                cursor: pointer;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            String sort = "";
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                sort = request.getParameter("sort");
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            LocationPersistence locationPersist = new LocationPersistence();
            ArrayList<Location> locations = locationPersist.getAllLocations(" order by description ");
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
                            <div class="row">
                                <ul class="breadcrumb">
                                    <li><a href="../../../private/employee/home.jsp">Home</a></li>
                                    <li class='ieFix'>Manage Rooms</li>
                                </ul>
                            </div>
                            <div class="row mediumBottomMargin">
                                <h1>Manage Rooms</h1>
                            </div>
                            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
                            <div class="row largeBottomMargin">
                                <h3>Use the table below to add, edit or delete existing rooms.</h3>
                            </div>
                            <div class='row largeBottomMargin'></div>
                            <div class="row mediumBottomMargin">
                                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Room Details</span><a href="../../../private/employee/admin/addroom.jsp" class="pullRight button button-primary">Add Room</a></h2>
                            </div>
                            <div class="row largeBottomMargin">
                                <form>
                                    <input type='hidden' id='current_page' value="1" />
                                    <input type='hidden' id='show_per_page' value='20' />
                                    <input type='hidden' id='total' value='<%= locations.size()%>'/>
                                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>Name</th>
                                                <th>Capacity</th>
                                                <th>Building</th>
                                                <th>Assigned to Session?</th>
                                                <th><!-- Actions --></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (int i = 0; i < locations.size(); i++) {
                                            %>
                                            <tr <% out.print("id='row" + i + "'");%>>
                                                <td> <% out.print(locations.get(i).getId()); %>
                                                </td>
                                                <td><% out.print(locations.get(i).getDescription()); %>
                                                    <input type="hidden" <% out.print("id='rowfor" + locations.get(i).getId() + "'");%> />
                                                </td>
                                                <td><% out.print(locations.get(i).getCapacity()); %></td>
                                                <td><% out.print(locations.get(i).getBuilding()); %></td>
                                                <td><% if (locationPersist.getRoomAssignments(locations.get(i).getId()).size() != 0) {
                                                        out.print("<i class='icon16-check'></i>");
                                                    } else {
                                                        out.print("");
                                                    }%>
                                                </td>
                                                <td>
                                                    <div class="actionMenu">
                                                        <a class="actionMenu-toggle" data-toggle="dropdown" href="#">Actions<b class="caret"></b></a>
                                                        <ul class="actionMenu-menu" role="menu">
                                                            <li><a <% out.print("href='../../../private/employee/admin/assignroom.jsp?roomId=" + locations.get(i).getId() + "'");%>><i class="icon16-userAdd"></i>Assign</a></li>
                                                            <li><a <% out.print("href='../../../private/employee/admin/editroom.jsp?id=" + locations.get(i).getId() + "'");%>><i class="icon16-approve"></i>Edit</a></li>
                                                            <li><a class="showModal3"><% out.print("<input type='hidden' name='delete' value='" + locations.get(i).getId() + "' />");%>
                                                                    <% out.print("<div class='modalDelete' id='modaldelete" + locations.get(i).getId() + "' title='Delete Confirmation'>");
                                                                        out.print("Is it ok to delete this room?<br/><br/>");
                                                                        out.print(locations.get(i).getDescription());
                                                                        out.print("</div>");
                                                                    %>
                                                                    <i class="icon16-pageRemove"></i>Delete</a></li>
                                                        </ul>
                                                    </div>
                                                </td>
                                            </tr>
                                            <% } //close the for loop %>
                                        </tbody>
                                    </table>
                                    <div class="pager">
                                        <ul>
                                            <li class="pager-arrow"><a onclick="first();"><i class="icon12-first"></i></a></li>
                                            <li class="pager-arrow"><a onclick="prev();"><i class="icon12-previous"></i></a></li>
                                                    <% int rows = locations.size();
                                                        int pages = 0;
                                                        if (rows % 20 == 0) {
                                                            pages = (rows / 20);
                                                        } else {
                                                            pages = (rows / 20) + 1;
                                                        }
                                                        for (int i = 0; i < pages; i++) {
                                                            out.print("<li id=\"page" + (i + 1) + "\"><a onclick='page(" + (i + 1) + ");'>" + (i + 1) + "</a></li>");
                                                        }
                                                    %>
                                            <li class="pager-arrow"><a onclick="next();"><i class="icon12-next"></i></a></li>
                                            <li class="pager-arrow"><a onclick="last();"><i class="icon12-last"></i></a></li>
                                        </ul>
                                        <div class="pager-pageJump">
                                            <span>Page <input class="input-mini" onchange="pageJump();" type="text" id="pagejump"/> of <%= pages%></span>
                                        </div>
                                    </div>
                                </form>
                            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %>
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/bootstrap-dropdown.2.0.4.min.js"></script>
                        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.js"></script>
                        <script src="../../../js/pagination.js"></script>
                        <script>
                                                $(document).ready(function() {
                                                    var page = 1;
                                                    $("#current_page").val(page);
                                                    var total = parseInt($("#total").val());
                                                    var pages = Math.floor((total / parseInt($("#show_per_page").val())) + 1);
                                                    for (var i = 20; i < total + 1; i++) {
                                                        $("#row" + i).hide();
                                                    }
                                                    unActive();
                                                    $("#page1").addClass("active");
                                                    $(".modals").dialog({autoOpen: false, dialogClass: "no-close",
                                                        buttons: {
                                                            'ok': {
                                                                'class': 'button button-primary',
                                                                click: function() {
                                                                    $(this).dialog('close');
                                                                },
                                                                text: 'Ok'
                                                            }}
                                                    });
                                                    $(".modalDelete").dialog({
                                                        autoOpen: false,
                                                        dialogClass: "no-close",
                                                        buttons: {
                                                            'ok': {
                                                                'class': 'button button-primary',
                                                                click: function() {
                                                                    var room = $(this).prop("id");
                                                                    room = room.substring(11);
                                                                    $.post("../../../action/deleteroom.jsp", {id: room}, function(data, success) {
                                                                    });
                                                                    $("#rowfor" + room).parent().parent().remove();
                                                                    $(this).dialog('close');
                                                                },
                                                                text: 'Yes'
                                                            },
                                                            'cancel': {
                                                                click: function() {

                                                                    $(this).dialog('close');
                                                                },
                                                                text: 'No, return to manage rooms table'
                                                            }
                                                        },
                                                    });
                                                     $(".showModal").click(function() {
                                                        var speaker = $(this).children().val();
                                                        $("#modal" + speaker).dialog("open");
                                                    });
                                                    $(".showModal2").click(function() {
                                                        var rank = $(this).children().val();
                                                        $("#modalrank" + rank).dialog("open");
                                                    });
                                                    $(".showModal3").click(function() {
                                                        var speaker = $(this).children().val();
                                                        $("#modaldelete" + speaker).dialog("open");
                                                    });

                                                });
                        </script>
    </body>
</html>