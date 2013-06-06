<%-- 
    Document   : register
    Created on : Apr 17, 2013, 9:46:22 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The purpose of register is to gather user information
                for those who wish to register for the Growler application.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Register</title>

        <link rel="stylesheet" href="../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
    </head>
    <body id="growler1">
        <%@ include file="../includes/header.jsp" %> 
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/>
            </div>
            <div class="span5">
                <h1 class = "bordered largeBottomMargin">Register Your Scripps ID for Techtoberfest</h1>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content" role="main">
                <!-- Begin Content -->
                <form method="POST" id="action" action="../model/adduser.jsp" onSubmit="return validateFields();">
                    <div class="span5 offset3">
                        <fieldset>
                            
                            <div class="form-group">
                                <label class="required">Corporate ID</label>
                                <input name="corporate" class="input-xlarge" type="text" id="tip1" data-content="Your 6 digit SNI Id" maxlength="6"/>
                            </div>
                            <div class="form-group">
                                <label class="required">First Name</label>
                                <input name="firstname" class="input-xlarge" type="text" id="tip2" data-content="Your First name, 20 characters or less please" maxlength="20"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Last name</label>
                                <input name="lastname" class="input-xlarge" type="text" id="tip3" data-content="Your Last name, 20 characters or less please" maxlength="20"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Password</label>
                                <input name="password" class="input-xlarge" type="password" id="tip4" data-content="Your password, 20 characters or less" maxlength="20"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Email</label>
                                <input name="password" class="input-xlarge" type="text" id="tip5" data-content="Your email" maxlength="50"/>
                            </div>
                            <div class="form-actions">
                                <input id="send" class="button button-primary" value="Submit" type="submit">
                                <a class="button" id="cancel" href="../index.jsp">Cancel</a>
                            </div>
                        </fieldset>
                    </div>   
                </form>		
            </div><!-- /.content -->
        </div><!-- /.container-fluid -->

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="../js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="../js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="../js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

        <!--Additional Script-->
        <script>


                    $(function() {
                        $("input").autoinline();
                    });

                    function validateFields() {
                        //Starts with alphanumeric characters, can have a dot and more characters, must have an @, followed by "domain.00x"
                        var corporate = $("#tip1").val();
                        var first = $("#tip2").val();
                        var last = $("#tip3").val();
                        var password = $("#tip4").val();
                        var email = $("#tip5").val();
                        var emptyString = "";
                        
                        if (password === emptyString || corporate === emptyString || first === emptyString || last === emptyString || email === emptyString) {
                            alert("Please fill in all information");
                            return false;
                        }
                        else {
                            return true;
                        }
                    }
        </script>
    </body>
</html>
