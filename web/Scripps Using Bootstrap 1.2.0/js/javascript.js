(function ($) {
    "use strict";
 
    $(function () {
    
        /* 
        * Initialize the datatable
        */
        var table1 = $('#table1').dataTable({
            'aocolumns': [
                { 'bsortable': true },  // #
                {'bsortable': true },  // First Name
                {'bsortable': true },  // Last Name
                {'bsortable': true}   // Username
            ],
            'aaSorting': [[0, 'asc']],
            'fnHeaderCallback': Scripps.DataTables.fnHeaderCallback,
            'bFilter': false,
            'bLengthChange': false,
            'sPaginationType': 'scripps'
        });
        /*
         * Initialize the date-picker demo
         */
        $(function () {
            $('#datePicker').inputdate();
            $("#datePickerRange").inputdate({
               
                minDate: '01/05/2013',
                maxDate: '12/06/2013',
            });  
        });

        /*
         * Initialize the Determinate Progress bar
         */
        $(function() {
            $( "#determinateProgressBarGreen" ).determinateProgressBar({
                value: 60
            });
            $( "#determinateProgressBarBlue" ).determinateProgressBar({
                value: 60,
                color: "blue",
                content: "data displayed through content option" 
            });
        });
		 /*
         * Initialize the dialog demo
         */
        $('#modalDialog').dialog({
            autoOpen: false,
            buttons: {
                'ok': {
                    'class': 'button button-primary',
                    click: function () {
                        $(this).dialog('close');
                    },
                    text: 'Save'
                },
                'cancel': {
                    click: function () {
                        $(this).dialog('close');
                    },
                    text: 'Cancel'
                }
            },
            height: 200,
            modal: true,
            resizable: false
        });

        $('#showDialog').on('click', function (event) {
            event.preventDefault();

            $('#modalDialog').dialog('open');
        });
        /* 
         * Initialize the basic tabs demo
         */
        var basicTabs = $('#basicTabs').tabs();
        /*
         * Initialize the tabs demo
         */
        $( ".inlineTabs" ).tabs();
         /*
         * Initialize the tag demo
         */
        $('#tags').tagit();
 
    
        /*
         * Initialize the tool-tip demo
         */
        $("#toolTipTarget").toolTip();
        /*
         * Initialize the tree-view demo
         */               
        $(document).ready(function () {
            var tv = $("#tree").wijtree({
                showCheckBoxes: true,
                allowEdit: true
            });
            var tv = $("#otherIconTree").wijtree({
                showCheckBoxes: false,
                allowEdit: true
            });
            $("#otherIconTree li.folder").wijtreenode({collapsedIconClass : 'icon16-folder',expandedIconClass:'icon16-folder'});  
            $("#otherIconTree li.msword").wijtreenode({itemIconClass: 'icon16-msword'}); 
            $("#otherIconTree li.xml").wijtreenode({itemIconClass: 'icon16-xml'}); 
            $("#otherIconTree li.msvisio").wijtreenode({ itemIconClass: 'icon16-msvisio'}); 
            $("#otherIconTree li.msppoint").wijtreenode({itemIconClass: 'icon16-msppoint'}); 
            $("#otherIconTree li.flash").wijtreenode({itemIconClass: 'icon16-flash'}); 
            $("#otherIconTree li.file").wijtreenode({itemIconClass: 'icon16-document'}); 
            $("#otherIconTree li.msexcel").wijtreenode({itemIconClass: 'icon16-msexcel'}); 
            var tv = $("#textTree").wijtree({                
            });
        });		
        /*
         * Initialize the user-activated-inline-help demo
         */
        $('#userInlineHelp').userInlineHelp(); 
        /*
        * Initialize the calendar demo
        */
        $("#calendarControl").wijcalendar();
        /*
         * Initialize the auto-inline-help demo
         */
        $(function () {
            $("#emailid").autoinline();
            $("#password").autoinline();
        }); 
        /*
         * Initialize the Indeterminate Progress Indicator demo
         */		
        $(function () {
            $("#indicator").indeterminateProgressIndicator({
                    //determines if the widget should be shown as modal or not
                    modal: false,
                    //default position of the widget
                    position: {
                        my: "left top",
                        at: "right top",
                        of: "#emailaddress"
                    }
            });
            $("#emailaddress").keyup(function(){
                if($(this).val() == '') {
                    $("#indicator").indeterminateProgressIndicator("hide");
                } else {
                    $("#indicator").indeterminateProgressIndicator("show");
                }
            });
        });
        /*
         * Initialize the Multi Select Drop Down demo
         */	
        $("select").multiselect({
            selectedList: 100, // 0-based index
            noneSelectedText: '',
            checkAllText: 'Check All',
            uncheckAllText: 'Uncheck All'
        });
        /*
         * Initialize autocomplete demo
        */
        $(function() {
        var availableTags = [
            "ActionScript",
            "AppleScript",
            "Asp",
            "BASIC",
            "C",
            "C++",
            "Clojure",
            "COBOL",
            "ColdFusion",
            "Erlang",
            "Fortran",
            "Groovy",
            "Haskell",
            "Java",
            "JavaScript",
            "Lisp",
            "Perl",
            "PHP",
            "Python",
            "Ruby",
            "Scala",
            "Scheme"
        ];
        $( "#autocomplete" ).autocomplete({
            source: availableTags
        });
                                       
    });
});
} (jQuery));