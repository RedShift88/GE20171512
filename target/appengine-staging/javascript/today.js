function todayDate(){
	var dateField = document.getElementById("date");
	var options = {year: 'numeric', month: 'numeric', day: 'numeric'};
	var now = new Date();
	dateField.value = now.getFullYear()+"-"+now.getMonth()+"-"+now.getDate();
}