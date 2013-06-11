<%-- 
    Document   : test
    Created on : Jun 4, 2013, 10:49:25 AM
    Author     : 162107
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String[] scrippsHeaders = new String[4];
scrippsHeaders[0] = "SN-USER";
scrippsHeaders[1] = "SN-AD-FIRST-NAME";
scrippsHeaders[2] = "SN-AD-LAST-NAME";
scrippsHeaders[3] = "SN-AD-EMAIL";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Calendar today = Calendar.getInstance();
            java.sql.Time longTime = null;
            java.sql.Time shortTime = null;
        String dateString = today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH) + 1) + "-" + today.get(Calendar.DATE);
        String timeString = today.get(Calendar.HOUR_OF_DAY) + ":" + today.get(Calendar.MINUTE) + ":" + today.get(Calendar.SECOND);
        java.sql.Date date = java.sql.Date.valueOf(dateString);
        java.sql.Time time = java.sql.Time.valueOf(timeString);
        out.print(time + "<br/>");
        try {
            DataConnection dc = new DataConnection();
            Connection connection = dc.sendConnection();
            PreparedStatement statement = connection.prepareStatement("select id, name, duration, start_time from session where session_date = ?");
            statement.setDate(1, date);
            ResultSet result = statement.executeQuery();
            HashMap<Integer, String> map = new HashMap();
            while (result.next()) {
                String stime = (String.valueOf(result.getTime("start_time")));
                map.put(result.getInt("duraton"), stime);
            }
                int mapsize = map.size();
                int duration = result.getInt("duration");
                int hours = duration / 60;
                int minutes = duration % 60;
                String durString = hours + ":" + minutes + ":00";
                out.print(duration + "<br/>");
                out.print(durString + "<br/>");
                shortTime = java.sql.Time.valueOf(durString);
                out.print(shortTime + "<br/>");
                int leeway = 15;
                int end = duration + leeway;
                int endhours = end / 60;
                int endmin = end % 60;
                String endString = endhours + ":" + endmin + ":00";
                out.print(endString + "<br/>");
                longTime = java.sql.Time.valueOf(endString);
                out.print(longTime + "<br/>");
            
                PreparedStatement ps = connection.prepareStatement("select id, name from session where session_date =  ? " +
                        "and addtime(start_time, ?) <= ? and addtime(start_time, ?) >= ?");
                ps.setDate(1, date);
                ps.setTime(2,shortTime);
                ps.setTime(3, time);
                ps.setTime(4, longTime);
                ps.setTime(5,time);
                out.print(ps.toString() + "<br/>");
                ResultSet result2 = ps.executeQuery();
                while (result2.next()) {
                    Session s = new Session();
                    s.setId(result2.getInt("id"));
                    s.setName(result2.getString("name"));
                    out.print(s.getName() + "<br/>");
                }
                result2.close();
                ps.close();
            
        } catch (Exception e) {
        }
            %>
            
            <%
        
        FirstPdf pdfer = new FirstPdf();
        
        
            ReportGenerator rg = new ReportGenerator();
            rg.createReport();
            %>
    </body>
</html>
