$(function() {
    $("input").autoinline();
});
$(function() {
    $("#modalDialog").dialog({
        resizable: false,
        height: 240,
        width: 700,
        modal: true,
        buttons: {
            "Take a Survey": function() {
                $(this).dialog("close");
                window.location = '../employee/surveylist.jsp';
            },
            "Don't take Survey": function() {
                $("#thanksDialog").dialog({
                    height: 140,
                    width: 500,
                    buttons: {
                        "Ok": function() {
                            $(this).dialog("close");
                        }
                    }
                });
                $(this).dialog("close");

            }
        }
    });
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