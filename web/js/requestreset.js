$(function() {
    $("#tip").autoinline();
});
$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #CCC");
    $("#error_email").hide();
    $("#error_valid").hide();
    $("#error_scripps").hide();
    $("#error_global").hide();
    var emptyString = "";
    var pattern =  /(([a-zA-Z0-9\-?\.?]+)@(([a-zA-Z0-9\-_]+\.)+)([a-z]{2,3}))+$/;
    var scripps = new RegExp("scrippsnetworks.com");
    //Make sure it's not blank
    if ($.trim($("#tip").val()) === emptyString) {
        $("#tip").css("border", "1px solid red");
        $("#error_email").show();
        $("#error_global").show();
        event.preventDefault();
    }
    //make sure it's a valid email
    else if (!pattern.test($("#tip").val())) {
        $("#tip").css("border", "1px solid red");
        $("#error_valid").show();
        $("#error_global").show();
        event.preventDefault();
    }
    //Test for the scripps email extension
    else if (scripps.test($("#tip").val())){
        $("#tip").css("border", "1px solid red");
        $("#error_scripps").show();
        event.preventDefault();
    }
    else {
        $("#error_final").show();
        event.preventDefault();
    }
});