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
		<title>Equipment List</title>
	</head>
	<body>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key equipmentKey = KeyFactory.createKey("Equipment", "default");
	Query equipmentQuery = new Query("Equipment", equipmentKey);
	List<Entity> equipmentList = datastore.prepare(equipmentQuery).asList(FetchOptions.Builder.withDefaults());
	String location = "";
	String locationTest = "";
	for(Entity equipment : equipmentList){
		locationTest = (String) equipment.getProperty("Location");
		if(!location.equals(locationTest)){
			location = locationTest;
			pageContext.setAttribute("groupHeading", locationTest);
%>
		<h3>${fn:escapeXml(groupHeading)}</h3>
<%
		}
		pageContext.setAttribute("equipment", equipment.getProperty("Description") + " - " + equipment.getProperty("Make") + " - "  + equipment.getProperty("Model"));
%>
		<p>${fn:escapeXml(equipment)}</p><br>
<%
	}
%>
	</body>
</html>