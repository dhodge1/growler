// JavaScript Document
function checkRange(form) {

	if (form.newrank.value < 0.00 || form.newrank.value > 5.00) {
		alert("Ranks must be between 0.00 and 5.00!");
		form.newrank.focus();
		return (false);
	}
	//If a number in the count boxes is a double, take care of it
	form.newcount.value = Math.floor(form.newcount.value);
	if (form.newcount.value < 0 || form.newrank.value > 100) {
		alert("Counts must be between 0 and 100!");
		form.newcount.focus();
		return (false);
	}
	return (true);


}
