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
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/wijmo/jquery.wijmo-complete.2.3.2.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/wijmo/jquery.wijmo-complete.all.2.3.2.min.css"/>
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tableStyle2.css" />
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            .ui-widget-content {
                background: #FFF;
            }
            .table {
                margin-bottom: 0px;
            }
            .pullRight {
                float:right;
                font-weight: normal;
                font-family: Arial;
                font-size: 11px;
                position: relative;
                top: 24px;
            }
            .modals{
                display:none;
            }
            .showModal, .showModal2, .showModal3 {
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
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
            .modalCloser {
                margin-left: 12px;
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
            /*.toolbar {
                padding-left: 10px;
            }*/
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            String sort = "";
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
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
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/adminnav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/adminnav.jsp" %>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
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
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Room Details</span><a href="${pageContext.request.contextPath}/private/employee/admin/addroom.jsp" class="pullRight button button-primary">Add Room</a></h2>
            </div>
            <div class="row largeBottomMargin">
                <form onsubmit="return false;">
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='100' />
                    <input type='hidden' id='total' value='<%= locations.size()%>'/>
                    <div class="toolbar">
                        <a class="button" id="filterButton" href="#" title="Filter Assigned" data-content="Filters out assigned rooms from the list."><i class="icon16-filter"></i></a>
                        <a class="button" id="filterButton2" href="#" title="Filter Unassigned" data-content="Filters out unassigned rooms from the list."><i class="icon16-view"></i></a>
                    </div>
                    <table class="tablesorter table table-alternatingRow table-border table-columnBorder table-rowBorder" id="roomTable">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Name</th>
                                <th>Capacity</th>
                                <th>Building</th>
                                <th>Assigned to Session?</th>
                                <th>Mapped to Remote Room?</th>
                                <th><!-- Actions --></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < locations.size(); i++) {
                            %>
                            <tr <% out.print("id='row" + i + "'");%>>
                                <td> <% out.print(locations.get(i).getId());%>
                                </td>
                                <td><% out.print(locations.get(i).getDescription());%>
                                    <input type="hidden" <% out.print("id='rowfor" + locations.get(i).getId() + "'");%> />
                                </td>
                                <td><% out.print(locations.get(i).getCapacity());%></td>
                                <td><% out.print(locations.get(i).getBuilding());%></td>
                                <td><% if (locationPersist.getRoomAssignments(locations.get(i).getId()).size() != 0) {
                                        out.print("<i class='icon16-check assigned'></i>");
                                    } else {
                                        out.print("<span class='unassigned'></span>");
                                    }%>
                                </td>
                                <td><% if (locationPersist.getRemoteRoomForLocation(locations.get(i).getId()).size() != 0) {
                                        out.print("<i class='icon16-check'></i>");
                                    } else {
                                        out.print("");
                                    }%>
                                </td>
                                <td>
                                    <div class="actionMenu">
                                        <a class="actionMenu-toggle" data-toggle="dropdown" href="#">Actions<b class="caret"></b></a>
                                        <ul class="actionMenu-menu" role="menu">
                                            <li><a <% out.print("href='../../../private/employee/admin/assignroom.jsp?roomId=" + locations.get(i).getId() + "'");%>><i class="icon16-reconcile"></i>Assign</a></li>
                                            <li><a <% out.print("href='../../../private/employee/admin/maproom.jsp?roomId=" + locations.get(i).getId() + "'");%>><i class="icon16-pageAdd"></i>Map</a></li>
                                            <li><a <% out.print("href='../../../action/removemapping.jsp?roomId=" + locations.get(i).getId() + "'");%>><i class="icon16-pageRemove"></i>Clear Mappings</a></li>
                                            <li><a <% out.print("href='../../../private/employee/admin/editroom.jsp?id=" + locations.get(i).getId() + "'");%>><i class="icon16-edit"></i>Edit</a></li>
                                            <li><a class="showModal3"><% out.print("<input type='hidden' name='delete' value='" + locations.get(i).getId() + "' />");%>
                                                    <% out.print("<div class='modalDelete' id='modaldelete" + locations.get(i).getId() + "' title='Delete Confirmation'>");
                                                        out.print("Are you sure want to delete the following room?<br/><br/>");
                                                        out.print(locations.get(i).getDescription());
                                                        out.print("</div>");
                                                    %>
                                                    <i class="icon16-trash"></i>Delete</a></li>
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
                            <span>Page <input class="input-mini" type="text" id="pagejump"/> of <%= pages%></span>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-1.8.3.min.js"></script>  
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js"></script>  
        <script src="${pageContext.request.contextPath}/js/libs/jquery.wijmo-complete.all.2.3.2.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery.wijmo-open.all.2.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery.wijmo-open.all.2.3.2.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-dropdown.2.0.4.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"> </script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.tool-tip.3.0.0.min.js" type="text/javascript"> </script>
        <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.tablesorter.js"></script> 
        <script>

                    $('form').submit(function(event) {
                        pageJump();
                        return false; // without this you go to google.com
                    });

                    $(document).ready(function() {
                        $("#roomTable").tablesorter(); 
                        $('#filterButton').click(function(event) {
                            event.preventDefault();
                            //$('td:contains("Yes")').parent().toggle();
                            $('.assigned').closest('tr').toggle();
                        }); 
                        $('#filterButton2').click(function(event) {
                            event.preventDefault();
                            //$('td:contains("No")').parent().toggle();
                            $('.unassigned').closest('tr').toggle();
                        }); 
                        var clicks = 0;
                        $("#filter").click(function() {
                            clicks++;
                            if (clicks === 1) {
                                $("#filter").val("");
                            }
                        });
                        //test
                        var page = 1;
                        $("#current_page").val(page);
                        var total = parseInt($("#total").val());
                        var pages = Math.floor((total / parseInt($("#show_per_page").val())) + 1);
                        for (var i = 100; i < total + 1; i++) {
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
                            }
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
                        $(".deleteModalLink").click(function() {
                            $(this).parent().close();
                        });

                    });
        </script>
    </body>
</html>