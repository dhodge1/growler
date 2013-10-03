<%-- 
    Document   : sessionschedule
    Created on : Jun 11, 2013, 8:40:30 AM
    Author     : 162107
    Purpose    : Shows the user a schedule of the events taking place this year, 
                allowing them to register interest in any number of those events.
                Uses registerinterest.jsp to process data.
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
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>View Session Schedule</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <style>
            .ie-dialog-button {
                background-color: #0067B1;
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
                top: 30px;
            }
            .modals{
                display:none;
            }
            h1 {
                font-weight: normal;
            }
            .showModal, .like, .unlike  {
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
            .pager li{
                cursor: pointer;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
        </style>
    </head>
    <body id="growler1">  
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%
            //Get the year
            int year = 2013;
            try {
                year = Integer.parseInt(request.getParameter("year"));
            } catch (Exception e) {
            }
            SessionPersistence sp = new SessionPersistence();
            RegistrationPersistence rp = new RegistrationPersistence();

            LocationPersistence lp = new LocationPersistence();
            ArrayList<Session> sessions = sp.getThisYearSessions(year, " order by session_date, start_time, name ");
            Calendar today = Calendar.getInstance();
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li class='ieFix'>Session Schedule</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>2013 Session Schedule</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <span>Below is the latest session schedule for this year's Techtoberfest event.</span>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Schedule Details</span><span class="pullRight"><a href='../../public/Techtoberfest_Schedule2013.pdf' target='blank'>View as PDF</a></span></h2>
            </div>
            <div class="row largeBottomMargin">
                <form onsubmit="return false;">
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='15' />
                    <input type='hidden' id='total' value='<%= sessions.size()%>'/>
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder" id="sessionTable">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th style="width: 70px;">Time</th>
                                <th>Topic</th>
                                <th>Description</th>
                                <th>Speaker(s)</th>
                                <th>Session Duration</th>
                                <th>Location</th>
                                <% if (today.get(Calendar.MONTH) != 8) {%><th>Like Session?</th><% }%>
                            </tr>
                        </thead>
                        <tbody id='tablebody'>
                            <%
                                for (int i = 0; i < sessions.size(); i++) {
                                    out.print("<tr id='row" + (i) + "'>");
                                    out.print("<td>");
                                    SimpleDateFormat dates = new SimpleDateFormat("MM/dd/yyyy");
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
                                    out.print("<div class='modals' id='modal" + sessions.get(i).getId() + "' title='Topic Description'>");
                                    out.print("<strong>" + sessions.get(i).getName() + "</strong><br/><br/>");
                                    out.print(sessions.get(i).getDescription());
                                    out.print("</div>");
                                    out.print("</td>");
                                    out.print("<td>");
                                    ArrayList<Speaker> speakers = sp.getSpeakersForSession(sessions.get(i).getId());
                                    for (int j = 0; j < speakers.size(); j++) {
                                        //Commented out the Speaker Dialogs, since we don't have relevant BIO data (9/16/13)
                                        //out.print("<a class='showModal'>");
                                        out.print(speakers.get(j).getFullName());
                                        out.print("<br/>");
                                        //out.print("<input type='hidden' value='" + speakers.get(j).getId() + "' /></a><br/>");
                                        //out.print("<div class='modals' id='modalspk" + speakers.get(j).getId() + "' title='" + speakers.get(j).getFullName() + "'>");
                                        //out.print(""); //The Bio information goes here?
                                        //out.print("</div>");
                                    }
                                    out.print("</td>");
                                    out.print("<td>");
                                    SimpleDateFormat fmt2 = new SimpleDateFormat("mm 'minutes'");
                                    out.print(fmt2.format(sessions.get(i).getDuration()));
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(lp.getLocationById(sessions.get(i).getLocation()).getDescription() + "<br/>" + lp.getLocationById(sessions.get(i).getLocation()).getBuilding());
                                    out.print("</td>");
                                    if (today.get(Calendar.MONTH) != 8) {
                                        out.print("<td>");
                                        if (rp.isUserRegistered(user, sessions.get(i).getId())) {
                                            out.print("<div class='unlike' id='unlike" + sessions.get(i).getId() + "'><a>Undo</a></div>");
                                            out.print("<div style='display:none' class='like' id='like" + sessions.get(i).getId() + "'><a><i class='icon16-approve' style='margin-right: 3px;'></i>Like</a></div>");
                                        } else {
                                            out.print("<div style='display:none' class='unlike' id='unlike" + sessions.get(i).getId() + "'><a>Undo</a></div>");
                                            out.print("<div class='like' id='like" + sessions.get(i).getId() + "'><a><i class='icon16-approve' style='margin-right: 3px;'></i>Like</a></div>");
                                        }

                                        out.print("</td>");
                                    }
                                    out.print("</tr>");
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="pager">
                        <ul>

                            <li class="pager-arrow"><a onclick="first();"><i class="icon12-first"></i></a></li>
                            <li class="pager-arrow"><a onclick="prev();"><i class="icon12-previous"></i></a></li>
                                    <% int rows = sp.getThisYearSessionCount(year);
                                        int pages = 0;
                                        if (rows % 15 == 0) {
                                            pages = (rows / 15);
                                        } else {
                                            pages = (rows / 15) + 1;
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
        <%@ include file="../../includes/footer.jsp" %>        
        <script src="../../js/libs/sniui.dialog.1.2.0.min.js"></script>
        <script src="../../js/pagination.js"></script>
        <script>
                    $('form').submit(function(event) {
                        pageJump();
                        return false; // without this you go to google.com
                    });

                    $(".like").click(function() {
                        var session = this.id;

                        session = session.substring(4);

                        $.post("../../action/likeSession.jsp", {sid: session}, function(data, success) {
                            $("#like" + session).hide();
                            $("#unlike" + session).show();
                        });
                    });

                    $(".unlike").click(function() {
                        var session = this.id;

                        session = session.substring(6);

                        $.post("../../action/unlikeSession.jsp", {sid: session}, function(data, success) {
                            $("#unlike" + session).hide();
                            $("#like" + session).show();
                        });
                    });
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
                        $(".modals").dialog({
                            autoOpen: false,
                            draggable: false,
                            resizable: false,
                            height: 300,
                            width: 500,
                            dialogClass: "no-close",
                            buttons: {
                                'ok': {
                                    'class': 'button button-primary ie-dialog-button',
                                    click: function() {
                                        $(this).dialog('close');
                                    }, text: "OK"}, modal: true
                            }});
                        $(".showModal").click(function() {
                            var session = $(this).children().val();
                            $("#modal" + session).dialog("open");
                            var speaker = $(this).children().val();
                            $("#modalspk" + speaker).dialog("open");
                        });


                    });
        </script>
    </body>
</html>