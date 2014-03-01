<%-- 
    Document   : systemFeatures
    Created on : Feb 23, 2014, 6:53:17 PM
    Author     : David
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
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>System Features</title><!-- Title -->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <style>
            .table {
                margin-bottom: 0px;
            }
            h1, h3 {
                font-weight: normal;
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
            .pager li {
                cursor: pointer;
            }
            .showModal, .showModal2, .showModal3 {
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
            #modalCloser {
                margin-left: 12px;
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            FeaturePersistence fp1 = new FeaturePersistence();
            ArrayList<Feature> features = fp1.getFeatureSet();
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
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>System Features</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>System Features</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Use the table below to enable or disable existing features.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered smallBottomMargin"><img style="padding-bottom:0;padding-left:0;" src='http://growler.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Feature Details</span></h2>
            </div>
            <div class="row">
                <form>
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='20' />
                    <input type='hidden' id='total' value='<%= features.size()%>'/>
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Status</th>
                                <th><!-- Actions --></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < features.size(); i++) {
                            %>
                            <tr <% out.print("id='row" + i + "'");%>>
                                <td><%= features.get(i).getId() %></td>
                                <td><%= features.get(i).getFeatureName() %></td>
                                <td>
                                    <%
                                        if (features.get(i).getFeatureState()) {
                                            out.print("Enabled");
                                        }
                                        else {
                                            out.print("Disabled");
                                        }
                                    %>
                                </td>
                                <td>
                                    <div class="actionMenu">
                                        <a class="actionMenu-toggle" data-toggle="dropdown" href="#">Actions<b class="caret"></b></a>
                                        <ul class="actionMenu-menu" role="menu">
                                            <li><a <% out.print("href='#' class='enableLink' id='" + features.get(i).getId() + "'");%>><i class="icon16-check"></i>Enable</a></li>
                                            <li><a <% out.print("href='#' class='disableLink' id='" + features.get(i).getId() + "'");%>><i class="icon16-trash"></i>Disable</a></li>
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
                                    <% int rows = features.size();
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
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-dropdown.2.0.4.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
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
                                                    var theme = $(this).prop("id");
                                                    theme = theme.substring(11);
                                                    $.post("../../../action/removeTheme.jsp", {id: theme}, function(data, success) {
                                                    });
                                                    $("#rowfor" + theme).parent().parent().remove();
                                                    $(this).dialog('close');
                                                },
                                                text: 'Yes'
                                            },
                                            'cancel': {'class': 'modalCloser',
                                                click: function() {
                                                    $(this).dialog('close');
                                                }, text: 'No, return to manage themes table'
                                            }
                                        },
                                    });
                                    $("#modalCloser").click(function() {
                                        $(".modalDelete").dialog("close");
                                    });
                                    $(".showModal").click(function() {
                                        var theme = $(this).children().val();
                                        $("#modal" + theme).dialog("open");
                                    });
                                    $(".showModal2").click(function() {
                                        var rank = $(this).children().val();
                                        $("#modalrank" + rank).dialog("open");
                                    });
                                    $(".showModal3").click(function() {
                                        var theme = $(this).children().val();
                                        $("#modaldelete" + theme).dialog("open");
                                    });
                                    
                                    $(".enableLink").on("click", function(event) {
                                        event.preventDefault();
                            
                                        var featureId = $(this).attr("id");

                                        $.ajax({
                                            type: "POST",
                                            url: '../../../action/enablefeature.jsp',
                                            data: {feature_ID: featureId},
                                            success: function(){
                                                window.location.href = "./systemFeatures.jsp";
                                            }
                                        });
                                    });
                                    
                                    $(".disableLink").on("click", function(event) {
                                        event.preventDefault();
                            
                                        var featureId = $(this).attr("id");

                                        $.ajax({
                                            type: "POST",
                                            url: '../../../action/disablefeature.jsp',
                                            data: {feature_ID: featureId},
                                            success: function(){
                                                window.location.href = "./systemFeatures.jsp";
                                            }
                                        });
                                    });

                                });
        </script>
    </body>
</html>


