<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Maintenance Event Form</title>
		<script type="text/JavaScript" src="/javascript/today.js"></script>
	</head>
	<body onload="todayDate()">
		<h1>Maintenance Event Form</h1>

		<p>Please enter the details of the Maintenance Event below</p>
		
		<form action="/createMaintenanceEvent" method="post">
			Date:<br>
			<input type="date" id="date" name="date" min="2017-01-01" max="2020-04-30"><br>
			Description:<br>
			<input type="text" name="description"><br>
			Equipment:<br>
			<select name="equipment">
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key equipmentKey = KeyFactory.createKey("Equipment", "default");
	Query equipmentQuery = new Query("Equipment", equipmentKey);
	List<Entity> equipmentList = datastore.prepare(equipmentQuery).asList(FetchOptions.Builder.withDefaults());
	for(Entity equipment : equipmentList){
		pageContext.setAttribute("equipment", equipment.getProperty("Description") + " - " + equipment.getProperty("Make") + " - " + equipment.getProperty("Model"));
		pageContext.setAttribute("equipment_key", KeyFactory.keyToString(equipment.getKey()));
%>
				<option value="${fn:escapeXml(equipment_key)}">${fn:escapeXml(equipment)}</option>
<%
	}
%>
			</select><br>
			Service Tech:<br>
			<select name="serviceTech">
<%
	Key serviceTechKey = KeyFactory.createKey("ServiceTech", "default");
	Query serviceTechQuery = new Query("ServiceTech", serviceTechKey);
	List<Entity> serviceTechList = datastore.prepare(serviceTechQuery).asList(FetchOptions.Builder.withDefaults());
	for(Entity serviceTech : serviceTechList){
		pageContext.setAttribute("serviceTech", serviceTech.getProperty("Name") + " - " + serviceTech.getProperty("Company"));
		pageContext.setAttribute("serviceTech_key", KeyFactory.keyToString(serviceTech.getKey()));
%>
				<option value="${fn:escapeXml(serviceTech_key)}">${fn:escapeXml(serviceTech)}</option>
<%
	}
%>
			</select><br>
			Time (hours):<br>
			<input type="number" step="0.25" min="0" name="time"><br>
			Cost ($):<br>
			<input type="number" step="0.01" min="0" name="cost"><br>
			Notes:<br>
			<textarea rows="5" cols="75" name="notes"></textarea><br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>