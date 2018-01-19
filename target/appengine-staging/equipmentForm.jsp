<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>Equipment Form</title>
	</head>
	<body>
		<h1>Equipment Form</h1>

		<p>Please enter the details of the equipment below</p>
		
		<form action="/createEquipment" method="post">
			Description:<br>
			<input type="text" name="description"><br>
			Status:<br>
			<select name="status">
				<option value="Active">Active</option>
				<option value="Under Repair">Under Repair</option>
				<option value="Inactive">Inactive</option>
			</select><br>
			Type:<br>
			<select name="type">
				<option value="Ultrasound">Ultrasound</option>
				<option value="Laser">Laser</option>
				<option value="Imaging">Imaging</option>
			</select><br>
			Make:<br>
			<input type="text" name="make"><br>
			Model:<br>
			<input type="text" name="model"><br>
			Year:<br>
			<input type="number" step="1" min="1970" max="2019" name="year"><br>
			Location:<br>
			<select name="location">
				<option value="Schertz">Schertz</option>
				<option value="Westover">Westover</option>
			</select><br>
			Notes:<br>
			<textarea rows="5" cols="75" name="notes"></textarea><br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>