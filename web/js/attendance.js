$(function() {
    $("input").autoinline();
});
$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#error_key").hide();
    var emptyString = "";
    if ($("#tip").val() === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_key").show();
        event.preventDefault();
    }
    else {
        $("#action").attr("action", "../../action/processThemeSuggestion.jsp");
    }
});