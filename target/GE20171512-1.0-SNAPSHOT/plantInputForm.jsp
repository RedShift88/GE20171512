<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>Plant Input Form</title>
	</head>
	<body>
		<h1>Plant Input Form</h1>

		<p>Please enter the details of the plant below</p>
		
		<form action="/createPlant" method="post">
			Description:<br>
			<input type="text" name="description"><br>
			Status:<br>
			<select name="status">
				<option value="Seed">Seed</option>
				<option value="Seedling">Seedling</option>
				<option value="Transplant">Transplant</option>
			</select><br>
			Type:<br>
			<select name="type">
				<option value="Microgreen">Microgreen</option>
				<option value="Plant">Plant</option>
			</select><br>
			Brand:<br>
			<input type="text" name="brand"><br>
			Soil:<br>
			<input type="text" name="soil"><br>
			Batch:<br>
			<input type="number" step="1" min="0" name="batchNum"><br>
			Location:<br>
			<select name="location">
				<option value="Garden Rack">Garden Rack</option>
				<option value="Northeast Raised Bed">Northeast Raised Bed</option>
			</select><br>
			Notes:<br>
			<textarea rows="5" cols="75" name="notes"></textarea><br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>