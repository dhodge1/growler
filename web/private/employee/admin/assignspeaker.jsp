<%-- 
    Document   : assignspeaker
    Created on : Jun 10, 2013, 10:52:05 AM
    Author     : 162107
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
        <title>Assign a Speaker to a Session</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            h1, h3 {
                font-weight: normal;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
            .keywordFilter-clear {
                cursor: pointer;
            }
            .pullRight {
                float: right;
                top:10px;
                position:relative;
            }
            #sessions {
                list-style-type: none;
                height: 345px;
                overflow-y: auto;
                border: 1px solid #ccc;
                margin:0;
                margin-bottom: 24px;
            }
            input[type="radio"] {
                position:relative;
                bottom: 5px;
                margin-right: 6px;
            }
            #additional {
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
            .modals{
                display:none;
            }
            #list {
                font-weight: bold;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            int speakerPassed = 0;
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
                speakerPassed = Integer.parseInt(request.getParameter("speakerId"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <jsp:include page="../../../includes/supernav.jsp" flush="true"/>
        <% } else {%>
            <jsp:include page="../../../includes/adminnav.jsp" flush="true"/>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Assign A Speaker</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Assign A Speaker</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>To assign a speaker to a session, choose an available session from the list and press the <strong>Assign</strong> button.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left:12px;">Assign Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <%
                    SessionPersistence sessionPersist = new SessionPersistence();
                    SpeakerPersistence speakerPersist = new SpeakerPersistence();
                    Speaker speaker = speakerPersist.getSpeakerByID(speakerPassed);
                    ArrayList<Speaker> speakers = speakerPersist.getAllSpeakers(" order by last_name, first_name");
                    ArrayList<Session> sessions = sessionPersist.getThisYearSessions(2013, " order by session_date");
                %>
                <form id="action" action="${pageContext.request.contextPath}/action/processSessionAssign.jsp" method="post">
                    <div class="form-group"><% out.print("<span id='list'>" + speaker.getLastName() + ", " + speaker.getFirstName() + "<strong> | Current ranking: </strong>" + speakerPersist.getSpeakersRank(speaker.getId()) + "</span>"
                                + "<span class='pullRight' id='additional'><a>Assign a second speaker</a><div class='modals' title='Assign Additional Speaker'><span id='addhere'>");
                        out.print("<select multiple=multiple id=extra height=350>");
                        for (int i = 0; i < speakers.size(); i++) {
                            if (speakers.get(i).getId() != speakerPassed) {
                                out.print("<option value=" + speakers.get(i).getId() + ">" + speakers.get(i).getLastName() + ", " + speakers.get(i).getFirstName() + "<strong> | Current ranking: </strong>" + speakerPersist.getSpeakersRank(speakers.get(i).getId()) + "</option>");
                            }
                        }
                        out.print("</select>");
                        out.print("</span></div></span>");%>
                        <input type="hidden" name="speaker" value="<%= speaker.getId()%>"/>
                    </div>
                    <div class="form-group" style="margin-bottom:6px;">
                        <span class="keywordFilter">
                            <i class="icon16-magnifySmall"></i>
                            <span class="keywordFilter-wrapper">
                                <input type="search" id="filter" value="Filter..." />
                            </span>
                            <a class="keywordFilter-clear" onclick="clearFilter();"><i class="icon16-close"></i></a>
                        </span><span class="pullRight"><a href="#">Refresh List</a></span></div>
                    <div class="form-group">
                        <ol id="sessions">
                            <%
                                SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                                SimpleDateFormat dates = new SimpleDateFormat("MM/dd");
                                //Get a list of all sessions
                                for (int i = 0; i < sessions.size(); i++) {
                                    out.print("<li>");
                                    if (speakerPersist.getSpeakersBySession(sessions.get(i).getId()).size() == 0) {
                                        out.print("<input type='radio' name='session' value=\"" + sessions.get(i).getId() + "\">");
                                    } else {
                                        out.print("<i class='icon16-success'></i>");
                                    }
                                    out.print(dates.format(sessions.get(i).getSessionDate()) + ", " + fmt.format(sessions.get(i).getStartTime()) + ", " + sessions.get(i).getName());
                                    out.print("</li>");
                                }
                            %>
                        </ol>
                    </div>
                    <div class="largeBottomMargin"><i class='icon16-success'></i> Indicates a session already has a speaker</div>
                    <div class="form-actions">
                        <input id="send" type="submit" class="button button-primary" value="Assign Speaker"/>
                        <a id="cancel" href="${pageContext.request.contextPath}/private/employee/admin/speaker.jsp">Cancel</a>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="${pageContext.request.contextPath}/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/sniui.user-inline-help.1.2.0.min.js" type="text/javascript"></script>
        <script>
                                $().ready(function() {
                                    jQuery.expr[":"].icontains = jQuery.expr.createPseudo(function(arg) {
                                        return function(elem) {
                                            return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
                                        };
                                    });
                                    $(".modals").dialog({autoOpen: false, dialogClass: "no-close",height: 400, width: 400,
                                        buttons: {
                                            'ok': {
                                                'class': 'button button-primary',
                                                click: function() {
                                                    dealWithAdditional();
                                                    $(this).dialog('close');
                                                },
                                                text: 'Ok'
                                            },
                                            'cancel': {
                                                click: function() {
                                                    $(this).dialog('close');
                                                },
                                                text: "Cancel"
                                            }}
                                    });
                                    $("#filter").on("keyup", function() {
                                        var text = $("#filter").val();
                                        if (text !== "") {
                                            $("#sessions li").filter(":icontains('" + text + "')").show();
                                            $("#sessions li").filter(":not(:icontains('" + text + "'))").hide();
                                        }
                                        else if (text === "") {
                                            $("#sessions li").show();
                                        }
                                    });
                                    $('#additional').click(function() {
                                        $('.modals').dialog('open');
                                    });
                                });
                                function dealWithAdditional() {
                                    var speaker = $("#extra").val();
                                    $('#list').append("<br>" + $("#extra option:selected").text());
                                    $('#list').append("<input type='hidden' name='speaker2' value='" + speaker + "'/>");
                                    $('#additional').hide();
                                }
                                function clearFilter() {
                                    $("#filter").val("");
                                    $("#sessions li").show();
                                }
        </script>
    </body>
</html>
