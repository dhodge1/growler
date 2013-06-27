$(function() {
    $("input").autoinline();
});
 $('#modalDialog').dialog({
        autoOpen: false,
        buttons: {
            'ok': {
                'class': 'button button-primary',
                click: function() {
                    $(this).dialog('close');
                },
                text: 'Ok'
            }
        },
        height: 200,
        modal: true,
        resizable: false
    });
$("#send").click(function(event) {
    var emptyString = "";
    if ($("#tip").val() === emptyString || $("#tip2").val() === emptyString) {
        event.preventDefault();
        $("#modalDialog").dialog("open");
    }
    else {
        $("#action").attr("action", "model/login.jsp");
    }
});
