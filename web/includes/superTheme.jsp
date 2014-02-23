<%-- 
    Document   : superTheme
    Created on : Feb 23, 2014, 12:21:20 PM
    Author     : David
--%>

<li class="brand_nav <%= themeTab%>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
    <ul class="child-menu child-menu-ul firstnav" style="left:11px;">
        <li><a href="${pageContext.request.contextPath}/private/employee/theme.jsp">Rank Preferred Themes</a></li>
        <li><a href="${pageContext.request.contextPath}/private/employee/admin/theme.jsp">Manage Themes</a></li>
        <li><a href="${pageContext.request.contextPath}/private/employee/admin/themeentry.jsp">Suggest a New Theme</a></li>
    </ul>
</li>