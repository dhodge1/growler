<%-- 
    Document   : template
    Created on : Feb 26, 2013, 11:58:57 PM
    Author     : Justin Bauguess
    Purpose    : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.scripps.growler.*" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title> </title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@ include file="../includes/indexheader.jsp" %> 
        <div class="container-fixed">
            <div class="row">
                <br/>
                <div class="span8">
                    <h1>Techtoberfest Information System (TIS)</h1>
                    <h3>TIS allows Scripps Employees the ability to not only stay abreast 
                        of all Techtoberfest sessions, but also the opportunity to provide 
                        valuable session feedback before, during, and after the event!</h3>
                </div>
            </div>
            <br/><br/><br/>
            <div class="row">
                <div class='span8'>
                    <h2 class="bordered"><img src='../images/Techtoberfest2013small.png'/>Login to TIS</h2>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="span8">
                    <form>
                        <div class="form-group">
                            <label>User ID</label>
                            <input type="text" name="username" />
                            <label>Password</label>
                            <input type="password" name="password"/>
                        </div>
                        <div class="form-actions">
                            <button class="button button-primary" type="submit">Login</button>
                            <a href="">Forgot Password?</a>
                        </div>
                        <div class="form-actions">
                            <span>Not Registered? <a href="">Click here to register</a></span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <br/>
        <br/>
        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
