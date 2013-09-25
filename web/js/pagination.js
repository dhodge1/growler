/* ============================================================
 * Pagination for Tecthoberfest pages
 * ============================================================
 * Usage directions:
 * 1. Include the following hidden inputs in your HTML:
 *      a. current_page
 *          i. Set the value to 1
 *      b. show_per_page
 *          i. Set the value to desired
 *          ii. You could also use a select box to get values
 *      c. total
 *          i.  Use server-side values to implement the total for dynamic pages
 * 2. Use the following IDs for elements: rows in the pagination : row${number}
 * 3. Use the Scripps Bootstrap pagination feature
 *      a. for the onclick attribute of links, use the functions below as needed
 * ============================================================ */

/**
 * Goes to the next page, as long as it's not on the last page
 */
function next() {
    var page = $("#current_page").val();
    if (parseInt($("#total").val()) % parseInt($("#show_per_page").val()) != 0) {
        var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())) + 1);
    }
    else {
        var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())));
    }
    if (parseInt(page) === parseInt(pages)) {
        //do nothing
    } else {
        var newPage = parseInt(page) + 1;
        for (var i = 0; i < $("#total").val() + 1; i++) {
            $("#row" + i).hide();
        }
        var startingPoint = ((parseInt(newPage) - 1) * parseInt($("#show_per_page").val()));
        for (var i = startingPoint; i < startingPoint + parseInt($("#show_per_page").val()); i++) {
            $("#row" + i).show();
        }
        $("#current_page").val(newPage);
        unActive();
        $("#page" + newPage).addClass("active");

    }
}
/**
 * Goes to the last page
 * 
 */
function last() {
    if (parseInt($("#total").val()) % parseInt($("#show_per_page").val()) != 0) {
        var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())) + 1);
    }
    else {
        var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())));
    }
    for (var i = 0; i < parseInt($("#total").val()) + 1; i++) {
        $("#row" + i).hide();
    }
    for (var i = (parseInt($("#show_per_page").val()) * (pages - 1)); i < (parseInt($("#show_per_page").val()) * pages); i++) {
        $("#row" + i).show();
    }
    $("#current_page").val(pages);
    unActive();
    $("#page" + pages).addClass("active");
}
/**
 * As long as it's not on the first page, goes to the previous page
 */
function prev() {
    var page = parseInt($("#current_page").val());
    var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())) + 1);
    if (parseInt(page) === 1) {
        //do nothing
    } else {
        var newPage = parseInt(page) - 1;
        for (var i = 0; i < parseInt($("#total").val()) + 1; i++) {
            $("#row" + i).hide();
        }
        var startingPoint = 1 + ((parseInt(newPage) - 1) * parseInt($("#show_per_page").val()));
        for (var i = startingPoint; i < startingPoint + parseInt($("#show_per_page").val()); i++) {
            $("#row" + i).show();
        }
        unActive();
        $("#current_page").val(newPage);
        $("#page" + newPage).addClass("active");
    }
}
/**
 * Goes to the first page
 */
function first() {
    var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())) + 1);
    for (var i = 0; i < parseInt($("#total").val()) + 1; i++) {
        $("#row" + i).hide();
    }
    for (var i = (0); i < parseInt($("#show_per_page").val()); i++) {
        $("#row" + i).show();
    }
    $("#current_page").val(1);
    unActive();
    $("#page1").addClass("active");
}
/**
 * Goes to a specific page
 * @param {integer} number The page to display
 */
function page(number) {
    var pages = Math.floor((parseInt($("#total").val()) / $("#show_per_page").val()) + 1);
    for (var i = 0; i < parseInt($("#total").val()) + 1; i++) {
        $("#row" + i).hide();
    }
    for (var i = (parseInt($("#show_per_page").val()) * (number - 1)); i < (parseInt($("#show_per_page").val()) * number); i++) {
        $("#row" + i).show();
    }
    unActive();
    $("#current_page").val(number);
    var page = $("#current_page").val();
    active(page);
}

/**
 * removes the active classes from all pages
 */
function unActive() {
    var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())) + 1);
    for (var i = 1; i < pages + 1; i++) {
        $("#page" + i).removeClass("active");
    }
}
/**
 * Adds the "active" class to the current page
 * @param {integer} page The page to make "active"
 */
function active(page) {
    $("#page" + page).addClass("active");
}

function pageJump() {
    var p = parseInt($("#pagejump").val(), 10);
    var pages = Math.floor((parseInt($("#total").val()) / parseInt($("#show_per_page").val())) + 1);
    if (p > pages || isNaN(p)) {
        //do nothing
    } else if (p <= 0) {
        page(1);
    }
    else {
        page(p);
    }
}