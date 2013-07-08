$(function() {
    $("input").autoinline();
});
$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    $("error_theme_name").hide();
    $("error_theme_description").hide();
    var emptyString = "";
    var str1 = $("#tip").val();
    var str2 = $("#tip2").val();
    if ($.trim(str1) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_theme_name").show();
        event.preventDefault();
    }
    if ($.trim(str2) === emptyString) {
        $("#tip2").css("border", "1px solid red");
        $("#error_theme_description").show();
        event.preventDefault();
    }
});