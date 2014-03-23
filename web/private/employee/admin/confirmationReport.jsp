<%-- 
    Document   : confirmationReport
    Created on : Oct 1, 2013, 11:25:34 PM
    Author     : 162107
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
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
        <title>Confirmed Attendance Report</title>
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tableStyle.css" />
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
                top: 32px;
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
            .modalCloser, #print {
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
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            java.sql.Date date = java.sql.Date.valueOf("2013-10-10");
            try {
                date = java.sql.Date.valueOf(request.getParameter("date"));
            } catch (Exception e) {
            }
            AttendancePersistence ap = new AttendancePersistence();
            ArrayList<AttendanceReport> report = ap.getAttendancesWithKeys(date);
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
                    <li class='ieFix'>Confirmed Attendance Report</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Confirmed Attendance Report</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>The table below displays a detailed listing of the total number of confirmed attendees per session/per day.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Report Details</span><span class='pullRight'><a id='print' onclick='window.print();'>Print</a></span></h2>
            </div>
            <div class='row largeBottomMargin'>
                <form>
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='15' />
                    <input type='hidden' id='total' value='<%= report.size() %>'/>
                    <span><strong>Session Dates:</strong></span>
                    <select name='date' id='date' style='margin-bottom: 6px;' onchange='switchDate();'>
                        <option value='2013-10-10' <% if (date.getDate() == 10) {
                                out.print(" selected ");
                            }%> >10/10/2013</option>
                        <option value='2013-10-11' <% if (date.getDate() == 11) {
                                out.print(" selected ");
                            }%> >10/11/2013</option>
                    </select>
                    
                    <table class="tablesorter table table-alternatingRow table-border table-columnBorder table-rowBorder" id="reportTable">
                        <thead>
                            <tr>
                                <th># Confirmed Attendees</th>
                                <th>Session Topic</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (report.size() == 0) {
                                    out.print("<tr>");
                                    out.print("<td>");
                                    out.print("No data is available at this time.");
                                    out.print("</td>");
                                    out.print("</tr>");
                                }
                                for (int i = 0; i < report.size(); i++) {
                                    out.print("<tr id='row" + i + "'>");
                                    out.print("<td class='" + report.get(i).getSession_date() + "'>");
                                    out.print(report.get(i).getAttendee_count());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(report.get(i).getSession_name());
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
                                    <% int rows = 10;
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
        <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.tablesorter.js"></script>
        <script>

                    $('form').submit(function(event) {
                        pageJump();
                        return false;
                    });
                    
                    function switchDate() {
                            var date = $('#date').val();
                            //window.location ='http://techtoberfest-dev.elasticbeanstalk.com/private/employee/admin/confirmationReport.jsp?date=' + date;
                            window.location = 'confirmationReport?date=' + date;
                        }

                    $(document).ready(function() {
                        $("#reportTable").tablesorter();
                        var page = 1;
                        $("#current_page").val(page);
                        var total = parseInt($("#total").val());
                        var pages = Math.floor((total / parseInt($("#show_per_page").val())) + 1);
                        for (var i = 20; i < total + 1; i++) {
                            $("#row" + i).hide();
                        }
                        unActive();
                        $("#page1").addClass("active");

                        
                    });
        </script>
    </body>
</html>

