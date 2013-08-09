<%-- 
    Document   : session
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of session(admin) is to show a list of session keys.
                The session keys are derived from using the sha1 hash algorithm
                on the session id and taking the first 4 letters.
--%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Manage Session Schedule</title><!-- Title -->
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
                top: 24px;
            }
            .showModal, .showModal2, .showModal3 {
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
            h1, h3 {
                font-weight: normal;
            }
            .modals{
                display:none;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
            .pager li {
                cursor: pointer;
            }
            .button-primary {
                margin-right: 12px;
            }
            .modalCloser {
                margin-left: 12px;
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
            } catch (Exception e) {
            }
            //Get the year
            int year = 2013;
            try {
                year = Integer.parseInt(request.getParameter("year"));
            } catch (Exception e) {
            }
            SessionPersistence sp = new SessionPersistence();
            ArrayList<Session> sessions = sp.getThisYearSessions(year, " order by session_date, start_time, name ");
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/home.jsp">Home</a></li>
                    <li class='ieFix'>Manage Session Schedule</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Manage Session Schedule</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Use the table below to add, edit or delete existing sessions.</h3>
            </div>
            <div class="row largeBottomMargin"></div>
            <div class="row smallBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Schedule Details</span><a href="../../../private/employee/admin/sessionScheduler.jsp" class="pullRight button button-primary">Schedule Sessions</a></h2>
            </div>
            <div class='row smallBottomMargin'>
                <label class="inline"><strong>Select Year:</strong></label>
                    <select name="year" id="year">
                        <option value="2013" <% if (year == 2013) {
                                out.print(" selected ");
                            }
                                %>>2013</option>
                                <option value="2012" <% if (year == 2012) {
                                        out.print(" selected ");
                                    }%>>2012</option>
                        <!--Provisioned for future years! -->
                    </select>
            </div>
            <div class="row largeBottomMargin">
                <form>
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='15' />
                    <input type='hidden' id='total' value='<%= sessions.size()%>'/>
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Topic</th>
                                <th>Description</th>
                                <th>Speaker(s)</th>
                                <th>Session Duration</th>
                                <th>Location</th>
                                <th>Capacity</th>
                                <th><!-- Actions --></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

                                LocationPersistence lp = new LocationPersistence();
                                for (int i = 0; i < sessions.size(); i++) {
                                    out.print("<tr id='row" + (i + 1) + "'>");
                                    out.print("<td>");
                                    SimpleDateFormat dates = new SimpleDateFormat("MM/dd/yyyy");
                                    SimpleDateFormat dates2 = new SimpleDateFormat("MM/dd");
                                    out.print(dates.format(sessions.get(i).getSessionDate()));
                                    out.print("</td>");
                                    out.print("<td>");
                                    SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                                    try {
                                        out.print(fmt.format(sessions.get(i).getStartTime()));
                                    } catch (Exception e) {
                                        out.print("No Time");
                                    }
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(sessions.get(i).getName());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print("<a class='showModal'><input type='hidden' value='" + sessions.get(i).getId() + "' />View</a>");
                                    out.print("<div class='modals' id='modal" + sessions.get(i).getId() + "' title='" + sessions.get(i).getName() + "'>");
                                    out.print(sessions.get(i).getDescription());
                                    out.print("</div>");
                                    out.print("</td>");
                                    out.print("<td>");
                                    ArrayList<Speaker> speakers = sp.getSpeakersForSession(sessions.get(i).getId());
                                    if (speakers.size() != 0) {
                                    for (int j = 0; j < speakers.size(); j++) {
                                        out.print("<a class='showModal'>");
                                        out.print(speakers.get(j).getFullName() + "<input type='hidden' value='" + speakers.get(j).getId() + "' /></a><br/>");
                                        out.print("<div class='modals' id='modalspkr" + speakers.get(j).getId() + "' title='" + speakers.get(j).getFullName() + "'>");
                                        out.print(""); //The Bio information goes here?
                                        out.print("</div>");
                                    }
                                    } else {
                                        out.print("<a href='../../../private/employee/admin/assignsession.jsp?sessionId=" + sessions.get(i).getId() + "'>Assign a Speaker</a>");
                                    }
                                    
                                    out.print("</td>");
                                    out.print("<td>");
                                    SimpleDateFormat fmt2 = new SimpleDateFormat("K ' hours, ' mm ' minutes'");
                                    out.print(fmt2.format(sessions.get(i).getDuration()));
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(lp.getLocationById(sessions.get(i).getLocation()).getDescription() + "<br/>" + lp.getLocationById(sessions.get(i).getLocation()).getBuilding());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(lp.getLocationById(sessions.get(i).getLocation()).getCapacity());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print("<div class='actionMenu'><a class='actionMenu-toggle' data-toggle='dropdown' href='#'>Actions<b class='caret'></b></a>");
                                    out.print("<ul class='actionMenu-menu' role='menu'>");
                                    out.print("<li><a href='../../../private/employee/admin/editsession.jsp?id=" + sessions.get(i).getId() + "'><i class='icon16-edit'></i>Edit</a></li>");
                                    out.print("<li><a class='showModal3'><input type='hidden' name='delete' value='" + sessions.get(i).getId() + "' />");
                                    out.print("<div class='modalDelete' id='modaldelete" + sessions.get(i).getId() + "' title='Delete Confirmation'>");
                                    out.print("Is it ok to delete this session?<br/><br/>");
                                    out.print(sessions.get(i).getName() + " | " + dates2.format(sessions.get(i).getSessionDate()) + " | " + fmt.format(sessions.get(i).getStartTime()));
                                    out.print("</div>");
                                    out.print("<i class='icon16-pageRemove'></i>Delete</a></li>");
                                    out.print("</ul>");
                                    out.print("</td>");
                                    out.print("</tr>");
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="pager">
                        <ul>
                            <li class="pager-arrow"><a onclick="first();"><i class="icon12-first"></i></a></li>
                            <li class="pager-arrow"><a onclick="prev();"><i class="icon12-previous"></i></a></li>
                                    <% int rows = sessions.size();
                                        int pages = 0;
                                        if (rows % 15 == 0) {
                                            pages = (rows / 15);
                                        } else {
                                            pages = (rows / 15) + 1;
                                        }
                                        for (int f = 0; f < pages; f++) {
                                            out.print("<li id=\"page" + (f + 1) + "\"><a onclick='page(" + (f + 1) + ");'>" + (f + 1) + "</a></li>");
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
                                    for (var i = 15; i < total + 1; i++) {
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
                                    $(".deleteModalLink").click(function() {
                                        $(this).parent().close();
                                    });
                                    $(".modalDelete").dialog({
                                        autoOpen: false,
                                        dialogClass: "no-close",
                                        buttons: {
                                            'ok': {
                                                'class': 'button button-primary',
                                                click: function() {
                                                    var session = $(this).prop("id");
                                                    session = session.substring(11);
                                                    $.post("../../../action/removeSession.jsp", {id: session}, function(data, success) {
                                                    });
                                                    $("#rowfor" + session).remove();
                                                    $(this).dialog('close');
                                                },
                                                text: 'Yes'
                                            }
                                        }
                                    }).parent().find('.ui-dialog-buttonset').append('<a href="#" id="modalCloser">No, return to manage sessions table</a>');
                                    $("#year").change(function(){
                                        var year = (parseInt($("#year").val()));
                                        window.location.href = "http://snit.scrippsnetworks.com/private/employee/admin/session.jsp?year=" + year;
                                    });
                                    $(".showModal").click(function() {
                                        var session = $(this).children().val();
                                        $("#modal" + session).dialog("open");
                                    });
                                    $(".showModal2").click(function() {
                                        var speaker = $(this).children().val();
                                        $("#modalspkr" + speaker).dialog("open");
                                    });
                                    $(".showModal3").click(function() {
                                        var session = $(this).children().val();
                                        $("#modaldelete" + session).dialog("open");
                                    });

                                });
        </script>
    </body>
</html>
