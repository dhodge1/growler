<%-- 
    Document   : speaker
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The purpose of speaker(admin) is the page where administrators 
                can edit speaker information.  It uses the rank_2012 table and 
                the speaker table.  The editable data includes: rating, count of 
                ratings, and visibility to users.  It uses the validation.js file
                to ensure data entered is within a certain range of values.
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="upersist" class="com.scripps.growler.UserPersistence" scope="page" />
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
        <title>Manage Speakers</title><!-- Title -->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
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
        </style>
    </head>
    <body id="growler1">
        <%
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            }
            SpeakerPersistence persist = new SpeakerPersistence();
            ArrayList<Speaker> speakers = persist.getAllSpeakers(" order by last_name");
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
                            <div class="row mediumBottomMargin"></div>
                            <div class="row">
                                <ul class="breadcrumb">
                                    <li><a href="../../../private/employee/home.jsp">Home</a></li>
                                    <li>Manage Speakers</li>
                                </ul>
                            </div>
                            <div class="row mediumBottomMargin">
                                <h1>Manage Speakers</h1>
                            </div>
                            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
                            <div class="row largeBottomMargin">
                                <span>Use the table below to add, edit or delete existing speakers.</span>
                            </div>
                            <div class="row mediumBottomMargin">
                                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Speaker Details</span><a href="../../../private/employee/speakerentry.jsp" class="pullRight button button-primary">Add Speaker</a></h2>
                            </div>
                            <div class="row">
                                <form action="../../../action/admintheme.jsp" >
                                    <input type='hidden' id='current_page' value="1" />
                                    <input type='hidden' id='show_per_page' value='20' />
                                    <input type='hidden' id='total' value='<%= speakers.size()%>'/>
                                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Type</th>
                                                <th>Added By</th>
                                                <th>Visible</th>
                                                <th>Ranking Details</th>
                                                <th>Assigned to Session?</th>
                                                <th><!-- Actions --></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (int i = 0; i < speakers.size(); i++) {
                                            %>
                                            <tr <% out.print("id='row" + i + "'");%>>
                                                <td><% out.print(speakers.get(i).getFullName()); %>
                                                    <input type="hidden" <% out.print("id='rowfor" + speakers.get(i).getId() + "'");%> />
                                                </td>
                                                <td><% out.print(speakers.get(i).getType());%></td>
                                                <td><% out.print(speakers.get(i).getSuggestedBy());%></td>
                                                <td><% if (speakers.get(i).getVisible()) {
                                                        out.print("<i class='icon16-check'></i>");
                                                    } else {
                                                        out.print("");
                                                    }
                                                    %></td>
                                                <td><a class="showModal2"><% out.print("<input type='hidden' value='" + speakers.get(i).getId() + "' />");%>View</a>
                                                    <% out.print("<div class='modals' id='modalrank" + speakers.get(i).getId() + "' title='" + speakers.get(i).getFullName() + "'>");
                                                        out.print(speakers.get(i).getRank() + " points out of " + speakers.get(i).getCount() + " votes");
                                                        out.print("</div>");
                                                    %>    
                                                </td>
                                                <td><% if (persist.getSpeakersAssignments(speakers.get(i).getId()) != 0) {
                                                        out.print("<i class='icon16-check'></i>");
                                                    } else {
                                                        out.print("");
                                                    }%>

                                                </td>
                                                <td>
                                                    <div class="actionMenu">
                                                        <a class="actionMenu-toggle" data-toggle="dropdown" href="#">Actions<b class="caret"></b></a>
                                                        <ul class="actionMenu-menu" role="menu">
                                                            <li><a <% out.print("href='../../../private/employee/admin/assignspeaker.jsp?sessionId=" + speakers.get(i).getId() + "'");%>><i class="icon16-userAdd"></i>Assign</a></li>
                                                            <li><a <% out.print("href='../../../private/employee/admin/editspeaker.jsp?id=" + speakers.get(i).getId() + "'");%>><i class="icon16-approve"></i>Edit</a></li>
                                                            <li><a class="showModal3"><% out.print("<input type='hidden' name='delete' value='" + speakers.get(i).getId() + "' />");%>
                                                                    <% out.print("<div class='modalDelete' id='modaldelete" + speakers.get(i).getId() + "' title='Delete Confirmation'>");
                                                                        out.print("Is it ok to delete this speaker?<br/><br/>");
                                                                        out.print(speakers.get(i).getFullName());
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
                                                    <% int rows = speakers.size();
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
                                                    $(".modals").dialog({autoOpen: false});
                                                    $(".modalDelete").dialog({
                                                        autoOpen: false,
                                                        buttons: {
                                                            'ok': {
                                                                'class': 'button button-primary',
                                                                click: function() {
                                                                    var speaker = $(this).prop("id");
                                                                    speaker = speaker.substring(11);
                                                                    $.post("../../../action/removeSpeaker.jsp", {id: speaker}, function(data, success) {
                                                                    });
                                                                    $("#rowfor" + speaker).parent().parent().remove();
                                                                    $(this).dialog('close');
                                                                },
                                                                text: 'Yes'
                                                            },
                                                            'cancel': {
                                                                click: function() {

                                                                    $(this).dialog('close');
                                                                },
                                                                text: 'No, return to manage speakers table'
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
