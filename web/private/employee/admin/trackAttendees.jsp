<%--
    Document   : trackAttendees
    Created on : Mar 10, 2014, 9:03:26 PM
    Author     : Chelsea Grindstaff
    Purpose    : Allow admin to track attendees, both at local and remote locations
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
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Track Attendees</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tableStyle.css" />
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
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
            } catch (Exception e) {
            }

            AttendeePersistence ap = new AttendeePersistence();
            ArrayList<Attendees> attendees = ap.getAllSessions();



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
                    <li class='ieFix'>Track Attendees</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Track Attendees for Each Session</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Use the table below to add or edit the number of attendees per session.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
            </div>
            <div class="row largeBottomMargin">
                <form onsubmit="return false;">
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='15' />
                    <input type='hidden' id='total' value='<%= attendees.size()%>'/>
                    <table class="tablesorter table table-alternatingRow table-border table-columnBorder table-rowBorder" id="reportTable">
                        <thead>
                            <tr>
                                <th>Topic</th>
                                <th>Local Attendees</th>
                                <th>Remote Attendees</th>
                                <th><!-- Actions --></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < attendees.size(); i++) {

                                    
                                    out.print("<tr id='row" + i + "'>");
                                    out.print("<input type='hidden' id='rowfor" + attendees.get(i).getId() + "'/>");
                                    out.print("<td>");
                                    out.print(attendees.get(i).getSessionName());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(attendees.get(i).getLocalAttendees());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(attendees.get(i).getRemoteAttendees());
                                    out.print("</td>");
                                    out.print("<td>");        
                                    out.print("<div class='actionMenu'><a class='actionMenu-toggle' data-toggle='dropdown' href='#'>Actions<b class='caret'></b></a>");
                                    out.print("<ul class='actionMenu-menu' role='menu'>");
                                    if (attendees.get(i).getLocalAttendees() == 0) {
                                        out.print("<li><a href='" + request.getContextPath() + "/private/employee/admin/trackAttendeesForm.jsp?sessionId=" + attendees.get(i).getId() + "'><i class='icon16-edit'></i>Add</a></li>");
                                    }
                                    else {
                                        out.print("<li><a href='" + request.getContextPath() + "/private/employee/admin/trackAttendeesFormEdit.jsp?sessionId=" + attendees.get(i).getId() + "'><i class='icon16-edit'></i>Edit</a></li>");
                                    }
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
                                    <% int rows = attendees.size();
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
        <script src="${pageContext.request.contextPath}/js/libs/jquery-1.8.3.min.js"></script>  
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js"></script>  
        <script src="${pageContext.request.contextPath}/js/libs/jquery.wijmo-complete.all.2.3.2.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery.wijmo-open.all.2.3.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery.wijmo-open.all.2.3.2.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-dropdown.2.0.4.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.tablesorter.js"></script>               
        <script>
                    $('form').submit(function(event) {
                        pageJump();
                        return false; // without this you go to google.com
                    });
                    
                    $(document).ready(function() {
                        $("#reportTable").tablesorter();
                        
                        var clicks = 0;
                        $("#filter").click(function() {
                            clicks++;
                            if (clicks === 1) {
                                $("#filter").val("");
                            }
                        });

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

