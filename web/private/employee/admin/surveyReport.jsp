<%-- 
    Document   : surveyReport
    Created on : Jun 10, 2013, 2:18:37 PM
    Author     : 162107
--%>
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

        <title>Techtoberfest Report</title>

        <link rel="stylesheet" href="../../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->

        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
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
                
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Surveys By Submission Time</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <tr>
                            <th>Entry Number</th>
                            <th>User Name</th>
                            <th>Session Name</th>
                        </tr>
                        <%  ReportGenerator rg = new ReportGenerator();
                            ArrayList<SurveyReport> report = rg.generateSurveyReport();

                            for (int i = 0; i < report.size(); i++) {
                                out.print("<tr>");
                                out.print("<td>");
                                out.print(i + 1);
                                out.print("</td>");
                                out.print("<td>");
                                out.print(report.get(i).getUser().getUserName());
                                out.print("</td>");
                                out.print("<td>");
                                out.print(report.get(i).getSession().getName());
                                out.print("</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                    <label><a href="../../../SurveyReportServlet">Download a PDF<i class="icon16-document"></i></a></label>
                
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>
