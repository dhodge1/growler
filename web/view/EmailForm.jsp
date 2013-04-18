<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title></title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
    <link rel="stylesheet" href="../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
 
  <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body>
        <%@ include file="includes/header.jsp" %> 

    <form action="EmailSendingServlet" method="post">
        <table border="0" width="35%" align="center">
            <caption><h2>Password Recovery</h2></caption>
            <tr>
                <td style="font-size: 24"></td>
                <td>Please Enter Your Email: <input colspan="3" type="text" name="recipient" align="center" size="60"/></td>
            </tr>
            <tr>
                <td><textarea rows="10" cols="39" name="subject" style="display:none;">Password change</textarea> </td>
            </tr>
            <tr>
                <td><textarea rows="10" cols="39" name="content" style="display:none;">http://ps11.pstcc.edu:8584/ProjectGrowler/view/resetpassword.jsp
                    </textarea> </td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Send"/></td>
            </tr>
        </table>
         
    </form>
        <%@ include file="includes/footer.jsp" %> 
 
    <script src="../../js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
</body>
</html>
