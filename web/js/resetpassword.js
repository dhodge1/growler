$(function() {
    $("#tip, #tip2, #tip3").autoinline();
});
$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#error_verification").hide();
    $("#tip2").css("border", "1px solid #CCC");
    $("#error_password").hide();
    $("#tip3").css("border", "1px solid #CCC");
    $("#error_password2").hide();
    var emptyString = "";
    if ($("#tip").val() === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_verification").show();
        event.preventDefault();
    }
    if ($("#tip2").val() === emptyString) {
        $("#tip2").css("border", "1px solid red");
        $("#error_password").show();
        event.preventDefault();
    }
    if ($("#tip3").val() === emptyString) {
        $("#tip3").css("border", "1px solid red");
        $("#error_password2").show();
        event.preventDefault();
    }
});
    