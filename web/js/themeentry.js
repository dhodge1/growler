$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    $("#tip3").css("border", "1px solid #CCC");
    $("#tip4").css("border", "1px solid #CCC");
    $("#error_theme_name").hide();
    $("#error_theme_type").hide();
    $("#error_too_long").hide();
    $("#error_theme_description").hide();
    $("#error_creator").hide();
    $("#error_creator_length").hide();
    var emptyString = "";
    var str1 = $("#tip").val();
    var str2 = $("#tip2").val();
    var str3 = $("#tip3").val();
    var str4 = $("#tip4").val();
    if ($.trim(str1) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_theme_name").show();
        event.preventDefault();
    }
    if (str1.length > 30) {
        $("#error_too_long").show();
        $("#tip").css("border", "1px solid red");
        event.preventDefault();
    }
    if ((str2) == "0") {
        $("#tip2").css("border", "1px solid red");
        $("#error_theme_type").show();
        event.preventDefault();
    }
    if ((str3) === emptyString) {
        $("#tip3").css("border", "1px solid red");
        $("#error_theme_description").show();
        event.preventDefault();
    }
    if ((str4) === emptyString){
        $("#tip4").css("border", "1px solid red");
        $("#error_creator").show();
        event.preventDefault();
    }
    if (str4.length > 6){
        $("#error_creator_length").show();
        $("#tip4").css("border", "1px solid red");
        event.preventDefault();
    }
});