$("#send").click(function(event) {
    var emptyString = "";
    $("#error_userid").hide();
    $("#error_password").hide();
    $("#error_global").hide();
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    if ($.trim($("#tip").val()) === emptyString)
     {
        event.preventDefault();
        $("#error_userid").show();
        $("#error_global").show();
        $("#tip").css("border", "1px solid red");
    }
    if ($.trim($("#tip2").val()) === emptyString) {
        event.preventDefault();
        $("#error_password").show();
        $("#error_global").show();
        $("#tip2").css("border", "1px solid red");
    }
    else {
        //$("#action").attr("action", "action/login.jsp");
    }
});
