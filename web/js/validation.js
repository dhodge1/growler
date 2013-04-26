function checkRange() {
var num=document.entry.newrank.value
if (num>0 && num<5){
	return true;
}
else alert ("Must be number between 0-5")
	document.entry.newrank.focus()
}
