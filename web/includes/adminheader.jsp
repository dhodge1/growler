<%-- 
    Document   : header
    Created on : Feb 27, 2013, 9:30:50 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
                This file goes above the usernav.jsp file in the web pages and adds the header information to the web pages.
--%>
<header class="pageHeader">
    <div class="pageHeader-portal">
        <div class="pageHeader-logo">
            <a href="/"></a>
        </div>
        <nav class="pageHeader-utility right hidden-phone hidden-tablet"  style='padding-top: 12px;padding-right:12px;'>
            <ul style="margin-top:0px; margin-right:0px;">
                <li class="first" style="color: white">
                    <%//Get the user's info, and post a welcome!
                        if (!String.valueOf(session.getAttribute("user")).isEmpty() || !String.valueOf(session.getAttribute("user")).equals("null")) {
                            String navuser = String.valueOf(session.getAttribute("user"));
                            out.print("    Welcome, " + navuser + "!");
                        }
                    %>
                </li>
                <li><a href="${pageContext.request.contextPath}/private/employee/admin/help.jsp">Help</a></li>
                <!--<li><a href="http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html">Logout</a></li>-->
                <li><a href="${pageContext.request.contextPath}/action/logout.jsp">Logout</a></li>
            </ul>
        </nav> 
    </div>
</header>