$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    $("#error_theme_name").hide();
    $("#error_theme_type").hide();
    var emptyString = "";
    var str1 = $.trim($("#tip").val());
    var str2 = $("#tip2").val();
    if ((str1) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_theme_name").show();
        event.preventDefault();
    }
    if ((str2) === "null") {
        $("#tip2").css("border", "1px solid red");
        $("#error_theme_type").show();
        event.preventDefault();
    }
});