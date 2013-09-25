function updateSessionList(selectBox) {
    //get the Select Box and the selected value
    var select = selectBox;
    var index = select.selectedIndex;
    var options = select.options;
    var id = options[index].value;
    var time = select.getAttribute("title");
    var name = select.getAttribute("name");
    var date;
    var location;
    if (name === "list1") {
        date = "2013-10-10";
        location = "E130";
    }
    else if (name === "list2") {
        date = "2013-10-10";
        location = "D304";
    }
    else if (name === "list3") {
        date = "2013-10-11";
        location = "E130";
    }
    else if (name === "list4") {
        date = "2013-10-11";
        location = "D304";
    }
    var xmlhttp;
    var xmlhttp2;

    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
        xmlhttp2 = new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState === 4)
        {
            xmlhttp2.open("GET", "../../../action/updateUnscheduled.jsp", true);
            xmlhttp2.send();
            document.getElementById("unscheduled").innerHTML = "";
        }
    };
    xmlhttp2.onreadystatechange = function () {
            if (xmlhttp2.readyState === 4) {
                document.getElementById("unscheduled").innerHTML = xmlhttp2.responseText;
            }  
    };
    xmlhttp.open("POST", "../../../action/updateSessionLive.jsp?id=" + id + "&date=" + date + "&time=" + time + "&location=" + location, true);
    xmlhttp.send();
}