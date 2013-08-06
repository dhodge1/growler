$(function() {
    $("input").autoinline();
});
$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    $("#tip3").css("border", "1px solid #CCC");
    $("#tip4").css("border", "1px solid #CCC");
    $("#error_first").hide();
    $("#error_last").hide();
    $("#error_type").hide();
    $("#error_creator").hide();
    var emptyString = "";
    var str1 = $("#tip").val();
    var str2 = $("#tip2").val();
    var str3 = $("#tip3").val();
    var str4 = $("#tip4").val();
    if ($.trim(str1) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_first").show();
        event.preventDefault();
    }
    if ($.trim(str2) === emptyString) {
        $("#tip2").css("border", "1px solid red");
        $("#error_last").show();
        event.preventDefault();
    }
    if (str3 === "null"){
        $("#tip3").css("border", "1px solid red");
        $("#error_type").show();
        event.preventDefault();
    }
    if (str4 === emptyString) {
        $("#tip4").css("border", "1px solid red");
        $("#error_creator").show();
        event.preventDefault();
    }
});