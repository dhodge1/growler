$("#send").click(function(event) {
    var sessionId = $("#sessionId");
    $.ajax(
            {url: "../../../action/checkSession.jsp",
                data: {id: sessionId},
                type: "POST",
                success: function(data) {
                    $('#modalWarning').html(data);
                    $('#modalWarning').dialog({
                        autoOpen: true,
                        dialogClass: "no-close",
                        buttons: {
                            Ok: function() {
                                $(this).dialog("close");
                            }
                        }
                    });
                },
                error: errorFunction
            });
    $("#tip").css("border", "1px solid #CCC");
    $("#tip2").css("border", "1px solid #CCC");
    $("#tip3").css("border", "1px solid #CCC");
    $("#datepicker").css("border", "1px solid #CCC");
    $("#time").css("border", "1px solid #CCC");
    $("#error_name").hide();
    $("#error_description").hide();
    $("#error_speaker").hide();
    $("#error_date").hide();
    $("#error_time").hide();
    var emptyString = "";
    var str1 = $("#tip").val();
    var str2 = $("#tip2").val();
    var str3 = $("#datepicker").val();
    var str4 = $("#time").val();
    if ($.trim(str1) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_name").show();
        event.preventDefault();
    }
    if ($.trim(str2) === emptyString) {
        $("#tip2").css("border", "1px solid red");
        $("#error_description").show();
        event.preventDefault();
    }
    if (str3 === null) {
        $("#datepicker").css("border", "1px solid red");
        $("#error_date").show();
        event.preventDefault();
    }
});
function successFunction(data) {

}
function errorFunction() {

}
