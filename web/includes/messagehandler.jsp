<%-- 
    Document   : messagehandler
    Created on : Jun 14, 2013, 9:07:20 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  //Displaying error or success messages -- clear it out when done
    String message = (String) session.getAttribute("message");
    if (message != null && message.startsWith("Success:")) {
        message = message.substring(8, message.length() - 1);
        out.print("<p class=feedbackMessage-success>" + message + "</p>");
        session.removeAttribute("message");
    } else if (message != null && message.startsWith("Error:")) {
        message = message.substring(6, message.length() - 1);
        out.print("<p class=feedbackMessage-error>" + message + "</p>");
        session.removeAttribute("message");
    } else if (message != null && message.startsWith("Success: Attendance")) {
        out.print("<p id=\"topMessage\" class=feedbackMessage-success>" + message + "</p>");
        String sessionName = (String) session.getAttribute("sessionName");
        out.print("<div id=\"modalDialog\" title=\"Successfully Acknowledged Attendance for " + sessionName + "\"><p>Please take a survey.</p><p>This will enter you in a drawing for a fantastic prize.</p></div>");
        out.print("<div id=\"thanksDialog\" title=\"Thanks Anyway\"><p>Thanks anyway. You can always take a survey later.</p></div>");
        session.removeAttribute("message");
    } else if (message != null) {
        out.print("<p class=feedbackMessage-info>" + message + "</p>");
        session.removeAttribute("message");
    }
%>
<script>
    $(function() {
        $("#modalDialog").dialog({
            resizable: false,
            height: 240,
            width: 700,
            modal: true,
            buttons: {
                "Take a Survey": function() {
                    $(this).dialog("close");
                    window.location = '../employee/surveylist.jsp';
                },
                "Don't take Survey": function() {
                    $("#thanksDialog").dialog({
                        height: 140,
                        width: 500,
                        buttons: {
                            "Ok": function() {
                                $(this).dialog("close");
                            }
                        }
                    });
                    $(this).dialog("close");

                }
            }
        });
    });
</script>
<script src='../../js/sniui.dialog.1.2.0.min.js'></script>