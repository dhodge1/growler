$(function() {
    $("input").autoinline();
});
$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    $("#tip3").css("border", "1px solid #CCC");
    $("#tip4").css("border", "1px solid #CCC");
    $("#error_topic").hide();
    $("#error_description").hide();
    $("#error_duration").hide();
    $("#error_theme").hide();
    var emptyString = "";
    var str1 = $.trim($("#tip").val());
    var str2 = $.trim($("#tip2").val());
    var str3 = $("#tip3").val();
    var str4 = $("#tip4").val();
    if ($.trim(str1) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_topic").show();
        event.preventDefault();
    }
    if ($.trim(str2) === emptyString) {
        $("#tip2").css("border", "1px solid red");
        $("#error_description").show();
        event.preventDefault();
    }
    if (str3 === "0"){
        $("#tip3").css("border", "1px solid red");
        $("#error_duration").show();
        event.preventDefault();
    }
    if (str4 === "0") {
        $("#tip4").css("border", "1px solid red");
        $("#error_theme").show();
        event.preventDefault();
    }
});