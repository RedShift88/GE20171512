<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>Location Input Form</title>
	</head>
	<body>
		<h1>Location Input Form</h1>

		<p>Please enter the details of the location below</p>
		
		<form action="/createLocation" method="post">
			Description:<br>
			<input type="text" name="description"><br>
			Top Level Quantity:<br>
			<input type="number" step="1" min="0" name="topQuantity"><br>
			Low Level Quantity:<br>
			<input type="number" step="1" min="0" name="lowQuantity"><br>
			Watering Method:<br>
			<select name="waterMethod">
				<option value="Automatic Drip Irrigation">Automatic Drip Irrigation</option>
				<option value="Spray Bottle">Spray Bottle</option>
			</select><br>
			Light Source:<br>
			<select name="lightSource">
				<option value="Sunlight">Sunlight</option>
				<option value="LED">LED</option>
			</select><br>
			Notes:<br>
			<textarea rows="5" cols="75" name="notes"></textarea><br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>