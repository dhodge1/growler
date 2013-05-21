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
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
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
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/speaker.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@include file="../includes/isadmin.jsp" %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/><!-- Techtoberfest logo-->
            </div>
            <div class="span6 largeBottomMargin">
                <h1 class = "bordered">Speakers - Admin View</h1>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->
                    <div class="span6 offset3"><!--span-->
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span1">
                                    </br>
                                    <%
                                        ArrayList<Speaker> speakers = persist.getAllSpeakers(" ");
                                    %>
                                </div>
                                <div class="span2">
                                    <section>
                                        <form id="entry" name="entry" action="../model/adminspeaker.jsp" method="post" onSubmit="return checkRange();">
                                            <table>
                                                <tr>
                                                    <td>Speaker Name</td>
                                                    <td>2012 Rating</td>
                                                    <td>Times Ranked</td>
                                                    <td>New Rating</td>
                                                    <td>New Times Ranked</td>
                                                    <td>Visible?</td>
                                                    <td>Suggested By</td>
                                                </tr>
                                                <%
                                                    for (int i = 0; i < speakers.size(); i++) {
                                                %>
                                                <tr>
                                                    <td><% out.print(speakers.get(i).getLastName() + ", " + speakers.get(i).getFirstName());%>
                                                        <input name="list" type="hidden" value="<% out.print(speakers.get(i).getId());%>" />
                                                    <td><% out.print(speakers.get(i).getRank2012());%></td>
                                                    <td><% out.print(speakers.get(i).getCount2012());%></td>
                                                    <%
                                                        double d = speakers.get(i).getRank2012();
                                                        out.print("<td><input id=\"" + speakers.get(i).getId() + "\" type=\"number\" min=\"0\" max=\"5\" name=\"newrank\" value=" + d + " /></td>");
                                                    %>
                                                    <%
                                                        int c = speakers.get(i).getCount2012();
                                                        out.print("<td><input id=\"" + speakers.get(i).getId() + "\" type=\"number\" min=\"0\" max=\"100\" name=\"newcount\" value=" + c + " /></td>");
                                                    %>
                                                    <td><input name="visible" type="checkbox" value="<% out.print(speakers.get(i).getId());%>"
                                                               <%
                                                                   if (speakers.get(i).getVisible() == true) {
                                                                       out.print("checked");
                                                                   }
                                                               %> />
                                                    </td>
                                                    <td><% out.print(upersist.getUserByID(speakers.get(i).getSuggestedBy()).getUserName());%></td>
                                                </tr>
                                                <% } //close the for loop
%>
                                            </table>

                                    </section>
                                </div>
                                <div class="span7">
                                    <p></p>
                                </div>
                            </div><!--end row-->
                        </div>
                    </div>
                </div><!--end row-->
                <div class="span2 offset3"><!--button div-->
                    <input type="submit" value="Submit" class="button button-primary" />
                </div>
                </form>
            </div><!-- End Content -->	
        </div><!--/.container-fluid-->

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
        <%@ include file="../includes/draganddrop.jsp" %>
        <script>
                                                                                    function checkRange() {
                                                                                        var newranks = document.getElementsByName("newrank");
                                                                                        for (var i = 0; i < newranks.length; i++) {
                                                                                            if (newranks[i].value > 5.0 || newranks[i].value < 0) {
                                                                                                alert('Ranks must be between 0 and 5');
                                                                                                newranks[i].focus();
                                                                                                return false;
                                                                                            }
                                                                                        }
                                                                                        var newcounts = document.getElementsByName("newcount");
                                                                                        for (var j = 0; j < newcounts.length; j++) {
                                                                                            newcounts[j] = Math.floor(newcounts[j]);
                                                                                            if (newcounts[j].value > 100 || newcounts[j].value < 0) {
                                                                                                alert('Counts must be between 0 and 100');
                                                                                                newcounts[j].focus();
                                                                                                return false;
                                                                                            }
                                                                                        }
                                                                                        return true;
                                                                                    }
        </script><!--Validation-->

    </body>
</html>
