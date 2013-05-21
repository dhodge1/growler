// JavaScript Document
function checkRange() {
    var newranks = document.getElementsByName("newrank");
    for (var i = 0; i < newranks.length; i++) {
        if (newranks[i].value > 5.0 || newranks[i].value < 0.0) {
            alert('Ranks must be between 0 and 5');
            return false;
        }
    }
    var newcounts = document.getElementsByName("newcount");
    for (var j = 0; j < newranks.length; j++){
        if (newranks[j].value > 100 || newranks[j].value < 0) {
            alert('Counts must be between 0 and 100');
            return false;
        }
    }
    return true;
}
