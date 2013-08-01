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
<jsp:useBean id="persist" class="com.scripps.growler.SpeakerPersistence" scope="page" />
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

        <title>Admin Speaker</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/demo.css" />  
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../../css/speaker.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            String sort = "";
            if (null == session.getAttribute("id")) {
               // response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("role").equals("admin")) {
              //  response.sendRedirect("../../../index.jsp");
            }
            try {
                sort = request.getParameter("sort");
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

                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Speakers</span></h2>

            </div>
            <br/>
            <div class="row">

                <%
                    ArrayList<Speaker> speakers = persist.getAllSpeakers(" order by rating desc, last_name");
                    try {
                        if (sort.equals("name_desc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by last_name desc");
                        }
                        else if (sort.equals("name_asc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by last_name asc");
                        }
                        else if (sort.equals("curvotes_asc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by votes asc, id");
                        }
                        else if (sort.equals("curvotes_desc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by votes desc, id");
                        }
                        else if (sort.equals("curpoints_asc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by points asc, id");
                        }
                        else if (sort.equals("curpoints_desc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by points desc, id");
                        }
                        else if (sort.equals("rating_asc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by rating asc, last_name");
                        }
                        else if (sort.equals("rating_desc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by rating desc, last_name");
                        }
                        else if (sort.equals("times_asc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by count asc, last_name");
                        }
                        else if (sort.equals("times_desc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by count desc, last_name");
                        }
                        else if (sort.equals("suggest_asc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by suggested_by asc, last_name");
                        }
                        else if (sort.equals("suggest_desc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by suggested_by desc, last_name");
                        }
                        else if (sort.equals("visible_asc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by visible asc, last_name");
                        }
                        else if (sort.equals("visible_desc") && !sort.isEmpty()) {
                            speakers = persist.getAllSpeakers(" order by visible desc, last_name");
                        }
                    } catch (Exception e) {
                        speakers = persist.getAllSpeakers(" order by rating desc, last_name");
                    }
                %>


                <form id="entry" name="entry" action="../../../action/adminspeaker.jsp" method="post" onSubmit="return checkRange();">
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <tr>
                            <th>Speaker Name
                                <a href="speaker.jsp?sort=name_asc"><i class="icon12-sortUp"></i></a>
                                <a href="speaker.jsp?sort=name_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Current Votes
                                <a href="speaker.jsp?sort=curvotes_asc"><i class="icon12-sortUp"></i></a>
                                <a href="speaker.jsp?sort=curvotes_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Current Points
                                <a href="speaker.jsp?sort=curpoints_asc"><i class="icon12-sortUp"></i></a>
                                <a href="speaker.jsp?sort=curpoints_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>2012 Rating
                                <a href="speaker.jsp?sort=rating_asc"><i class="icon12-sortUp"></i></a>
                                <a href="speaker.jsp?sort=rating_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Times Ranked
                                <a href="speaker.jsp?sort=times_asc"><i class="icon12-sortUp"></i></a>
                                <a href="speaker.jsp?sort=times_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>New Rating</th>
                            <th>New Times Ranked</th>
                            <th>Visible?
                                <a href="speaker.jsp?sort=visible_asc"><i class="icon12-sortUp"></i></a>
                                <a href="speaker.jsp?sort=visible_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Ranked in 2012?</th>
                            <th>Suggested By
                                <a href="speaker.jsp?sort=suggest_asc"><i class="icon12-sortUp"></i></a>
                                <a href="speaker.jsp?sort=suggest_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Remove Speaker</th>
                        </tr>
                        <%
                            for (int i = 0; i < speakers.size(); i++) {
                        %>
                        <tr>
                            <td><% out.print(speakers.get(i).getLastName() + ", " + speakers.get(i).getFirstName());%>
                                <input name="list" type="hidden" value="<% out.print(speakers.get(i).getId());%>" />
                                <%
                                    double d = speakers.get(i).getRank2012();
                                    java.text.DecimalFormat df = new java.text.DecimalFormat("0.00");
                                    String decimal = df.format(d);
                                %><br/>
                                Last Name:<input name="last" value="<% out.print(speakers.get(i).getLastName());%>"><br/>
                                First Name:<input name="first" value="<% out.print(speakers.get(i).getFirstName());%>">
                            </td>
                            <td><% out.print(speakers.get(i).getCount());%></td>
                            <td><% out.print(speakers.get(i).getRank());%></td>
                            <td><% out.print(decimal);%></td>
                            <td><% out.print(speakers.get(i).getCount2012());%></td>
                            <td>
                                <%

                                    out.print("<input id=\"" + speakers.get(i).getId() + "\" type=\"number\" maxlength=\"4\" min=\"0\" max=\"5\" step=\".01\" name=\"newrank\" value=" + decimal + " />");
                                %>
                            </td>
                            <td>
                                <%
                                    int c = speakers.get(i).getCount2012();
                                    out.print("<input id=\"" + speakers.get(i).getId() + "\" type=\"number\" min=\"0\" max=\"100\" name=\"newcount\" value=" + c + " />");
                                %>
                            </td>
                            <td><input name="visible" type="checkbox" value="<% out.print(speakers.get(i).getId());%>"
                                       <%
                                           if (speakers.get(i).getVisible() == true) {
                                               out.print("checked");
                                           }
                                       %> />
                            </td>
                            <td><input name="lastyear" type="checkbox" value="<% out.print(speakers.get(i).getId());%>"
                                       <%
                                           if (speakers.get(i).getRank2012() > 0) {
                                               out.print("checked");
                                           }
                                       %>/></td>
                            <td>
                                <% out.print(upersist.getUserByID(speakers.get(i).getSuggestedBy()).getUserName());%>
                                <% if (upersist.getUserByID(speakers.get(i).getSuggestedBy()).getId() == 202300) {
                                        out.print("<br/><a href=\"../../../action/changeSpeaker.jsp?id=" + speakers.get(i).getId() + "\" >Change Default to Suggested</a>");
                                    }%>

                            </td>
                            <td><%out.print("<a href=\"../../../action/removeSpeaker.jsp?id=" + speakers.get(i).getId() + "\">Remove</a></td>");%></td>
                        </tr>
                        <% } //close the for loop
%>
                    </table>
                        <input type="submit" value="Submit" class="button button-primary" />
                </form>

            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script>
                    function checkRange() {
                        var lastyear = document.getElementsByName("lastyear");
                        var newranks = document.getElementsByName("newrank");
                        for (var i = 0; i < newranks.length; i++) {
                            if ((newranks[i].value > 5.0 || newranks[i].value < 0.01 || isNaN(newranks[i].value)) && lastyear[i].checked == true) {
                                alert('Ranks must be between 0 and 5');
                                newranks[i].focus();
                                return false;
                            }
                            if (lastyear[i].checked == true && newranks[i].value == 0) {
                                alert('Speakers who spoke last year must have a Rank value.')
                                newranks[i].focus();
                                return false;
                            }
                        }
                        var newcounts = document.getElementsByName("newcount");
                        for (var j = 0; j < newcounts.length; j++) {
                            newcounts[j].value = Math.floor(newcounts[j].value);
                            //newcounts[j] = Math.floor(newcounts[j]);
                            if (newcounts[j].value > 100 || newcounts[j].value < 0 || isNaN(newcounts[j].value)) {
                                alert('Counts must be between 0 and 100');
                                newcounts[j].focus();
                                return false;
                            }
                            if (lastyear[j].checked == true && newcounts[j].value == 0) {
                                alert('Speakers who spoke last year must have a Count value.')
                                newcounts[j].focus();
                                return false;
                            }
                        }
                        return true;
                    }

        </script><!--Validation-->

    </body>
</html>
