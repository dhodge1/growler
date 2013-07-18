function updateSessions(page) {
    var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState === 4)
        {
            document.getElementById("tablebody").innerHTML = xmlhttp.responseText;
        }
    };
    xmlhttp.open("POST", "../../action/updateSessions.jsp?pageNo=" + page, true);
    xmlhttp.send();
}