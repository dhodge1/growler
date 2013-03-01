(function ($) {
    "use strict";

    $(function () {

        /* 
        * Make the search box behave properly
        */

        $("#searchInput")
            .on("focus", function (event) {
                var that = $(this);

                if (that.val() === "Search") {
                    that.val("");
                }
            })
            .on("blur", function (event) {
                var that = $(this);

                if (that.val().length === 0) {
                    that.val("Search");
                }
            });

        /* 
        * Make the filter boxes behave properly
        */

        $(".keywordFilter input")
            .on("focus", function (event) {
                var that = $(this);

                if (that.val() === "Filter...") {
                    that.val("");
                }
            })
            .on("blur", function (event) {
                var that = $(this);

                if (that.val().length === 0) {
                    that.val("Filter...");
                }
            });

	$("#rank_theme")
		.click(function() {
		var topTen = new Array();
		var currentContent;
		for(var i = 0; i > 10; i++){
			//topTen[i] =
			currentContent = $("li").next().innerHTML();
			alert(currentContent);
		}
		});

    });

} (jQuery));
