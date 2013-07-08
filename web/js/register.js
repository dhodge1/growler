$(function() {
    $("input").autoinline();
});

$("#send").click(function(event) {

    $("#tip").css("border", "1px solid #CCC");
    $("#error_corporate").hide();
    $("#tip2").css("border", "1px solid #CCC");
    $("#error_first").hide();
    $("#tip3").css("border", "1px solid #CCC");
    $("#error_last").hide();
    $("#tip4").css("border", "1px solid #CCC");
    $("#error_password").hide();
    $("#tip5").css("border", "1px solid #CCC");
    $("#error_email").hide();

    var corporate = $("#tip").val();
    var first = $("#tip2").val();
    var last = $("#tip3").val();
    var password = $("#tip4").val();
    var email = $("#tip5").val();
    var emptyString = "";

    if ($.trim(corporate) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_corporate").show();
        event.preventDefault();
    }
    if ($.trim(first) === emptyString) {
        $("#tip2").css("border", "1px solid red");
        $("#error_first").show();
        event.preventDefault();
    }
    if ($.trim(last) === emptyString) {
        $("#tip3").css("border", "1px solid red");
        $("#error_last").show();
        event.preventDefault();
    }
    if ($.trim(password) === emptyString) {
        $("#tip4").css("border", "1px solid red");
        $("#error_password").show();
        event.preventDefault();
    }
    if ($.trim(email) === emptyString) {
        $("#tip5").css("border", "1px solid red");
        $("#error_email").show();
        event.preventDefault();
    }

});