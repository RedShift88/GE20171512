<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>Service Tech Form</title>
	</head>
	<body>
		<h1>Service Tech Form</h1>

		<p>Please enter the details of the Service Tech below</p>
		
		<form action="/createServiceTech" method="post">
			Name:<br>
			<input type="text" name="name"><br>
			Company:<br>
			<input type="text" name="company"><br>
			Notes:<br>
			<textarea rows="5" cols="75" name="notes"></textarea><br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>