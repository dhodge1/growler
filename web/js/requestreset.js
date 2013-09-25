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
    var pattern = /(([a-zA-Z0-9\-?\.?]+)@(([a-zA-Z0-9\-_]+\.)+)([a-z]{2,3}))+$/;
    var scripps = new RegExp("scrippsnetworks.com");
    var city = new RegExp('cityeats.com');
    var cook = new RegExp('cookingchanneltv.com');
    var diy = new RegExp('diynetwork.com');
    var food = new RegExp('foodnetwork.com');
    var foodUK = new RegExp('foodnetwork.co.uk');
    var gac = new RegExp('gactv.com');
    var real = new RegExp('realgravity.com');
    var trav = new RegExp('travelchannel.com');
    var travUK = new RegExp('travelchannel.co.uk');
    var testValue = $("#tip").val();
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
    else if (scripps.test(testValue) || city.test(testValue) || cook.test(testValue)
    || diy.test(testValue) || food.test(testValue) || foodUK.test(testValue) || gac.test(testValue)
    || real.test(testValue) || trav.test(testValue) || travUK.test(testValue)) {
        $("#tip").css("border", "1px solid red");
        $("#error_scripps").show();
        event.preventDefault();
    }
    else {
        $("#error_final").show();
        event.preventDefault();
    }
});