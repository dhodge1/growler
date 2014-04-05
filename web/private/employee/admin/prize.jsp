<%-- 
    Document   : prize
    Created on : Apr 5, 2014, 5:40:26 AM
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page import="com.google.gson.Gson" %>
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
        <title>Prize Drawing</title>
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
            #recessed{
                    //color: #555;
                    font-size: 38px;
                    margin: 25px auto;
                    margin-top: 40px;
                    padding: 100px 0 100px;
                    width: 650px;
                    position:relative;
                    min-height: 90px;
                    text-shadow:1px 1px 0 rgba(255,255,255,0.5);
                    border: 1px inset #ddd;
                    border-bottom: 1px inset #eee;
                    background-color: #fff;
                    border-radius:15px;
                    box-shadow: inset 0 1.5px 4px #ccc;
                    text-align: center;
            }

            /*#recessed:before{
                    content: ">";
                    font-size: 50px;
                    left: -40px;
                    opacity: 0.25;
                    position: absolute;
                    text-shadow: 1px 1px 0 white;
                    top: 200px;
            }*/
            
            .buttons {
                text-align: center;
            }

            .buttons button {
                width: 150px;
                height: 50px;
                margin: 10px 5px;
                margin-bottom: 40px;
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
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
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
                    <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
                    <li class='ieFix'>Prize Drawing</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Prize Drawing</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Randomly select an eligible prize winner by clicking draw below. Administrators can also marked prizes as claimed and view the audit trail.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Select a Winner at Random</span></h2>
            </div>
            <div class="dynamic">
                <div id="recessed">
                    And the winner is...
                </div>
                <div class="buttons">
                    <button class="button button-primary" id="claim">Claim</button>
                    <button class="button button-primary" id="draw">Draw</button>
                    <button class="button button-primary" id="audit">Audit</button>
                </div>
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
        <script src="${pageContext.request.contextPath}/js/jquery.shuffleLetters.js"></script>
        <script>
            var container = $("#recessed");
            _winner = '';
            url1 = "../../../action/getWinner.jsp";
            url2 = "../../../action/insertWinner.jsp";
            url3 = "../../../action/claimPrize.jsp";
    
            $(function() {
                
                jQuery.fn.extend({
                    disable: function(state) {
                        return this.each(function() {
                            this.disabled = state;
                        });
                    }
                });
                
                $('#claim').disable(true);
                
                function draw(){
                    return $.ajax({
                      url: url1,
                      dataType:'json',
                      type: 'GET'
                    });
                }
                /*draw().done(function(data){
                    _winner = data;
                });*/
                
                //container.shuffleLetters();

                $("#draw").on("click", function(event) {
                   event.preventDefault();
                   
                   draw().done(function(data){
                       _winner = data;
                   });
                   //draw();
                   container.shuffleLetters({
                       "text": _winner.name
                   });
                   $.post(url2, {winner: JSON.stringify(_winner)});
                   $('#claim').disable(false);
                });

                $("#claim").on("click", function(event) {
                    event.preventDefault();
                    $.post(url3, {winner: JSON.stringify(_winner)});
                    container.shuffleLetters({
                       "text": _winner.name + " prize claimed."
                    });
                });
                
                $("#audit").on("click", function(event) {
                    event.preventDefault();
                    window.location = "./prizeAudit.jsp";
                });

            });
        </script>
    </body>
</html>
