$("#send").click(function(event) {
    var emptyString = "";
    $("#error_userid").hide();
    $("#error_password").hide();
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    if ($("#tip").val() === emptyString)
     {
        event.preventDefault();
        $("#error_userid").show();
        $("#tip").css("border", "1px solid red");
    }
    else if ($("#tip2").val() === emptyString) {
        event.preventDefault();
        $("#error_password").show();
        $("#tip2").css("border", "1px solid red");
    }
    else {
        //$("#action").attr("action", "action/login.jsp");
    }
});
