<%-- 
    Document   : header
    Created on : Feb 27, 2013, 9:30:50 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
				 This file goes above the usernav.jsp file in the web pages and adds the header information to the web pages.
				 This file also adds the "welcome <user> !" text to the header and will also send users who aren't logged in to the
                 log in page.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
  <header class="pageHeader">
    <div class="pageHeader-portal">
      <div class="pageHeader-logo">
      </div>
    </div>
      <nav class="pageHeader-utility"><label class="hidden-tablet hidden-phone" style="color:white">Techtoberfest Information System</label>
      <label class="hidden-desktop" style="color:white;font-size:6px">Techtoberfest Information System</label></nav>
  </header><!-- /.pageHeader -->
<script src="../js/respond.min.js"></script>