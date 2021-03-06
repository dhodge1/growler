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
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/images/scripps_favicon-32.ico">
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        
        
        <!-- Makes table filterable -->
        <!-- <script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/tablefilter.js"></script> -->

        <style>
            .table {
                margin-bottom: 0px;
            }
            h1, h3 {
                font-weight: normal;
            }
            .showModal, .showModal2, .showModal3 {
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
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
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
            .pager li {
                cursor: pointer;
            }
            #modalCloser {
                margin-left: 12px;
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
            

            
        </style>
        
        <script>
        function filter (term, _id, cellNr){
                var termLC = term.value.toLowerCase();
                var table = document.getElementById(_id);
                var ele;
                for (var r = 1; r < table.rows.length; r++){
                        ele = table.rows[r].cells[cellNr].innerHTML.replace(/<[^>]+>/g,"");
                        if (ele.toLowerCase().indexOf(termLC)>=0 )
			table.rows[r].style.display = '';
                        else table.rows[r].style.display = 'none';
	}
}
            
            
        </script>
            
        
        
        
        
    </head>
    <body id="growler1">
        <%
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            SpeakerPersistence persist = new SpeakerPersistence();
            ArrayList<Speaker> speakers = persist.getAllSpeakers(" order by last_name");
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
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class='ieFix'>Manage Speakers</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Manage Speakers</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Use the table below to add, edit or delete existing speakers.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered">
                    <img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/>
                    <span style="padding-left: 12px;">Speaker Details</span>
                    <span class="keywordFilter" style="margin-bottom:8px;">
                        <i class="icon16-magnifySmall"></i>
                        <span class="keywordFilter-wrapper">
                            <input type="search" name="speakerFilter" value="Filter..." id="speakerFilter" 
                                   onkeyup="filter(this, 'speakerTable', 0)" onclick="this.value='';" 
                                   onfocus="this.select()" onblur="this.value=!this.value?'Filter...' :this.value;" 
                                   style="font-family:Verdana,Tahoma,sans-serif; font-size:11px;"/>
                        </span>
                        <a class="keywordFilter-clear" onclick="speakerFilter.value='';" ><i class="icon16-close"></i></a>
                        </span>
                    <a href="${pageContext.request.contextPath}/private/employee/admin/speakerentry.jsp" class="pullRight button button-primary">Add Speaker</a>
                </h2>
            </div>
            <div class="row">
                <form>
                    <input type='hidden' id='current_page' value="1" />
                    <input type='hidden' id='show_per_page' value='20' />
                    <input type='hidden' id='total' value='<%= speakers.size()%>'/>
                    <table id="speakerTable" class="table table-alternatingRow table-border table-columnBorder table-rowBorder filterable">
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
                                <td><% out.print(speakers.get(i).getFullName());%>
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
                                            <li><a <% out.print("href='" + request.getContextPath() + "/private/employee/admin/assignspeaker.jsp?speakerId=" + speakers.get(i).getId() + "'");%>><i class="icon16-userAdd"></i>Assign</a></li>
                                            <li><a <% out.print("href='" + request.getContextPath() + "/private/employee/admin/editspeaker.jsp?id=" + speakers.get(i).getId() + "'");%>><i class="icon16-edit"></i>Edit</a></li>
                                            <li><a class="showModal3"><% out.print("<input type='hidden' name='delete' value='" + speakers.get(i).getId() + "' />");%>
                                                    <% out.print("<div class='modalDelete' id='modaldelete" + speakers.get(i).getId() + "' title='Delete Confirmation'>");
                                                        out.print("Are you sure you want to delete the following speaker?<br/><br/>");
                                                        out.print(speakers.get(i).getFullName());
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
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-dropdown.2.0.4.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/pagination.js"></script>
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
                                    $(".modalDelete").dialog({
                                        autoOpen: false,
                                        dialogClass: "no-close",
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
                                            'class': 'modalCloser',
                                                    click: function () {
                                                $(this).dialog('close');
                                                    },
                                                            text: 'No, return to manage speakers table'
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
