<%-- 
    Document   : surveyReport
    Created on : Jun 10, 2013, 2:18:37 PM
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
        <title>Survey Report</title>
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
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
                response.sendRedirect("../../../index.jsp");
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
            ReportGenerator rg = new ReportGenerator();
            ArrayList<SurveyReport> surveys = rg.generateSurveyReport(date);
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
                    <li><a href="${pageContext.request.contextPath}/private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Survey Report</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Survey Report</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>The table below displays a detailed listing of all user surveys submitted.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Report Details</span><span class='pullRight'><a id='print' onclick='window.print();'>Print</a></span></h2>
            </div>
            <div class='row largeBottomMargin'>
                <form>
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='15' />
                    <input type='hidden' id='total' value='<%= surveys.size()%>'/>
                    <span><strong>Show me all session surveys for:</strong></span>
                    <select name='date' id='date' style='margin-bottom: 6px;' onchange='switchDate();'>
                        <option value='2013-10-10' <% if (date.getDate() == 10) {
                                out.print(" selected ");
                            }%> >10/10/2013</option>
                        <option value='2013-10-11' <% if (date.getDate() == 11) {
                                out.print(" selected ");
                            }%> >10/11/2013</option>
                    </select>
                    <span style='float: right; position: relative;'>Total per day: <%= surveys.size()%></span>
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <thead>
                            <tr>
                                <th>Survey Submitted</th>
                                <th>User ID</th>
                                <th>Session Details</th>
                                <th>Eligible for Raffle</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                                SimpleDateFormat dates = new SimpleDateFormat("MM/dd");
                                SimpleDateFormat timestamps = new SimpleDateFormat("MM/dd h:mm a");
                                if (surveys.size() == 0) {
                                    out.print("<tr>");
                                    out.print("<td>");
                                    out.print("No data is available at this time.");
                                    out.print("</td>");
                                    out.print("</tr>");
                                }
                                for (int i = 0; i < surveys.size(); i++) {
                                    Calendar survey = Calendar.getInstance();
                                    survey.set(Calendar.HOUR_OF_DAY, surveys.get(i).getAttendance().getSurveySubmitTime().getHours());
                                    survey.set(Calendar.MINUTE, surveys.get(i).getAttendance().getSurveySubmitTime().getMinutes());
                                    java.util.Date submitted = survey.getTime();
                                    
                                    Calendar durationCal = Calendar.getInstance();
                                    durationCal.set(Calendar.HOUR_OF_DAY, surveys.get(i).getSession().getStartTime().getHours());
                                    durationCal.set(Calendar.MINUTE, surveys.get(i).getSession().getStartTime().getMinutes());
                                    java.util.Date start = durationCal.getTime();
                                    durationCal.add(Calendar.HOUR_OF_DAY, surveys.get(i).getSession().getDuration().getHours());
                                    durationCal.add(Calendar.MINUTE, surveys.get(i).getSession().getDuration().getMinutes());
                                    durationCal.add(Calendar.MINUTE, 30);
                                    
                                    java.util.Date duration = durationCal.getTime();
                                    
                                    
                                    out.print("<tr id='row" + i + "'>");
                                    out.print("<td class='" + surveys.get(i).getSession().getSessionDate() + "'>");
                                    out.print(timestamps.format(surveys.get(i).getAttendance().getSurveySubmitTime()));
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(surveys.get(i).getUser().getId());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(surveys.get(i).getSession().getName() + "<br/>");
                                    out.print(fmt.format(surveys.get(i).getSession().getStartTime()) + " - ");
                                    Calendar today = Calendar.getInstance();
                                    today.set(Calendar.HOUR_OF_DAY, surveys.get(i).getSession().getStartTime().getHours());
                                    today.set(Calendar.MINUTE, surveys.get(i).getSession().getStartTime().getMinutes());
                                    today.add(Calendar.MINUTE, surveys.get(i).getSession().getDuration().getMinutes());
                                    out.print(today.get(Calendar.HOUR) + ":" + today.get(Calendar.MINUTE) + " ");
                                    if (today.get(Calendar.AM_PM) == 1) {
                                        out.print("PM");
                                    } else {
                                        out.print("AM");
                                    }
                                    out.print("</td>");
                                    out.print("<td>");
                                    if (surveys.get(i).getAttendance().getIsKeyGiven() && (!submitted.after(duration) && !submitted.before(start) )) {
                                        out.print("<i class='icon16-check'></i>");
                                    } else {
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
                                    <% int rows = surveys.size();
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
        <script>

                    $('form').submit(function(event) {
                        pageJump();
                        return false;
                    });

                    function switchDate() {
                        var date = $('#date').val();
                        window.location = 'surveyReport?date=' + date;
                    }

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


                    });
        </script>
    </body>
</html>
