$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    $("#tip3").css("border", "1px solid #CCC");
    $("#error_theme_name").hide();
    $("#error_theme_type").hide();
    $("#error_theme_description").hide();
    var emptyString = "";
    var str1 = $.trim($("#tip").val());
    var str2 = $("#tip2").val();
    var str3 = $("#tip3").val();
    if ((str1) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_theme_name").show();
        event.preventDefault();
    }
    if ((str2) === "0") {
        $("#tip2").css("border", "1px solid red");
        $("#error_theme_type").show();
        event.preventDefault();
    }
    if ((str3) === emptyString) {
        $("#tip3").css("border", "1px solid red");
        $("#error_theme_description").hide();
        event.preventDefault();
    }
});