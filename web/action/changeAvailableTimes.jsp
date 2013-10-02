<%-- 
    Document   : changeAvailableTimes
    Created on : Sep 12, 2013, 8:11:05 PM
    Author     : 162107
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.scripps.growler.*"%>

<%

    java.sql.Date date = java.sql.Date.valueOf(request.getParameter("date"));
    SessionPersistence sp = new SessionPersistence();
    Map<String, String> map = new TreeMap<String, String>();
    map.put("08:00:00a", "<option value='08:00:00a'>08:00 am - 08:25 am</option>");
    map.put("08:00:00b", "<option value='08:00:00b'>08:00 am - 08:50 am</option>");
    map.put("08:30:00a", "<option value='08:30:00a'>08:30 am - 08:55 am</option>");
    map.put("09:00:00a", "<option value='09:00:00a'>09:00 am - 09:25 am</option>");
    map.put("09:00:00b", "<option value='09:00:00b'>09:00 am - 09:50 am</option>");
    map.put("09:30:00a", "<option value='09:30:00a'>09:30 am - 09:55 am</option>");
    map.put("10:00:00a", "<option value='10:00:00a'>10:00 am - 10:25 am</option>");
    map.put("10:00:00b", "<option value='10:00:00b'>10:00 am - 10:50 am</option>");
    map.put("10:30:00a", "<option value='10:30:00a'>10:30 am - 10:55 am</option>");
    map.put("11:00:00a", "<option value='11:00:00a'>11:00 am - 11:25 am</option>");
    map.put("11:00:00b", "<option value='11:00:00b'>11:00 am - 11:50 am</option>");
    map.put("11:30:00a", "<option value='11:30:00a'>11:30 am - 11:55 am</option>");
    map.put("12:00:00a", "<option value='12:00:00a'>12:00 pm - 12:25 pm</option>");
    map.put("12:00:00b", "<option value='12:00:00b'>12:00 pm - 12:50 pm</option>");
    map.put("12:30:00a", "<option value='12:30:00a'>12:30 pm - 12:55 pm</option>");
    map.put("13:00:00a", "<option value='13:00:00a'>01:00 pm - 01:25 pm</option>");
    map.put("13:00:00b", "<option value='13:00:00b'>01:00 pm - 01:50 pm</option>");
    map.put("13:30:00a", "<option value='13:30:00a'>01:30 pm - 01:55 pm</option>");
    map.put("14:00:00b", "<option value='14:00:00b'>02:00 pm - 02:50 pm</option>");
    map.put("14:30:00a", "<option value='14:30:00a'>02:30 pm - 02:55 pm</option>");
    map.put("15:00:00a", "<option value='15:00:00a'>03:00 pm - 03:25 pm</option>");
    map.put("15:00:00b", "<option value='15:00:00b'>03:00 pm - 03:50 pm</option>");
    map.put("15:30:00a", "<option value='15:30:00a'>03:30 pm - 03:55 pm</option>");
    map.put("16:00:00a", "<option value='16:00:00a'>04:00 pm - 04:25 pm</option>");
    map.put("16:00:00b", "<option value='16:00:00b'>04:00 pm - 04:50 pm</option>");
    map.put("16:30:00a", "<option value='16:30:00a'>04:30 pm - 04:55 pm</option>");
    map.put("17:00:00a", "<option value='17:00:00a'>05:00 pm - 05:25 pm</option>");
    map.put("17:00:00b", "<option value='17:00:00b'>05:00 pm - 05:50 pm</option>");
    map.put("17:30:00a", "<option value='17:30:00a'>05:30 pm - 05:55 pm</option>");
    List<String> list = new ArrayList<String>();
    ArrayList<Session> sessionList = sp.checkAvailableTimes(date);
    String placeHolder;
    response.getWriter().println("<option value='null'> - No Time - </option>");
    for (int i = 0; i < sessionList.size(); i++) {
        if (sessionList.get(i).getDuration().getMinutes() == 50) {
            placeHolder = sessionList.get(i).getStartTime().toString().concat("b");
        } else {
            placeHolder = sessionList.get(i).getStartTime().toString().concat("a");
        }
        if (list.contains(placeHolder)) {
            map.remove(placeHolder);
        } else {
            list.add(placeHolder);
        }
    }

    Collection<String> goodValues = map.values();
    Iterator<String> iterator = goodValues.iterator();
    while (iterator.hasNext()) {
        response.getWriter().println(iterator.next());
    }

%>