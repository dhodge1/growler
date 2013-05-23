<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
    $(function() {
        $("#datepicker").datepicker({minDate: new Date(2013, 10 - 1, 1), maxDate: new Date(2013, 10 - 1, 31)}).change(function() {
            $("#datepicker").datepicker("option", "dateFormat", "yy-mm-dd");
        });
        ;
    });
</script>
