$(function() {
    $("#tip, #tip2").autoinline();
});
$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#error_id").hide();
    $("#tip2").css("border", "1px solid #CCC");
    $("#error_email").hide();
    var emptyString = "";
    if ($("#tip").val() === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_id").show();
        event.preventDefault();
    }
    if ($("#tip2").val() === emptyString) {
        $("#tip2").css("border", "1px solid red");
        $("#error_email").show();
        event.preventDefault();
    }
});