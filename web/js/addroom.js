$("#send").click(function(event) {
    $("#tip").css("border", "1px solid #ccc");
    $("#error_id").hide();
    $("#tip1").css("border", "1px solid #ccc");
    $("#error_name").hide();
    $("#tip2").css("border", "1px solid #ccc");
    $("#error_capacity").hide();
    $("#building").css("border", "1px solid #ccc");
    $("#error_building").hide();
    if ($("#tip").val() === "") {
        $("#tip").css("border", "1px solid red");
        $("#error_id").show();
        event.preventDefault();
    }
    if ($("#tip1").val() === "") {
        $("#tip1").css("border", "1px solid red");
        $("#error_name").show();
        event.preventDefault();
    }
    if ($("#tip2").val() === "" || $("#tip2").val() <= 0) {
        $("#tip2").css("border", "1px solid red");
        $("#error_capacity").show();
        event.preventDefault();

    }
    if ($("#building").val() === "0") {
        $("#building").css("border", "1px solid red");
        $("#error_building").show();
        event.preventDefault();

    }
});
        