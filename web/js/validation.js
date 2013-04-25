function prepareEventHandlers() {
	document.getElementById("entry").onsubmit = function() {
	//There are 4 input fields in the form: hidden(id), newrank, newcount, visible
        var formdata = document.getElementById("entry");
        
        //Go through the ranks, which are the 2nd input field in the form
	for (var i = 1; i < formdata.length; i+=4) {
		var rank = formdata.elements[i].val;
                alert(formdata.elements[i].val);
		if (i % 2 == 0) {
			rank = parseFloat(rank);
			if (rank > 5.0 || rank < 0.0) {
				alert("Bad Rank value: \"" + rank + "\"");
				return false;
			}
            }
        }
        //Go through the counts which are the 3rd input in the form
        for (var i = 2; i < formdata.length; i+=4) {
            var rank = formdata.elements[i].val;
		if (i % 2 == 1) {
			rank = parseInt(rank);
			if (rank > 100 || rank < 0) {
				alert("Band Count value");
				return false;
			}
		}
	}
	return true;
	};
}


window.onload = function() {
	prepareEventHandlers();
}