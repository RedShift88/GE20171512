<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Text" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Plant List</title>
	</head>
	<body>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key plantKey = KeyFactory.createKey("Plant", "default");
	Query plantQuery = new Query("Plant", plantKey).addSort("Location", Query.SortDirection.ASCENDING);
	List<Entity> plantList = datastore.prepare(plantQuery).asList(FetchOptions.Builder.withDefaults());
	String location = "";
	String locationTest = "";
	for(Entity plant : plantList){
		locationTest = (String) plant.getProperty("Location");
		if(!location.equals(locationTest)){
			location = locationTest;
			pageContext.setAttribute("groupHeading", locationTest);
%>
		<h3>${fn:escapeXml(groupHeading)}</h3>
<%
		}
		pageContext.setAttribute("plantDescription", plant.getProperty("Description") + " - " + plant.getProperty("Batch Number"));
		pageContext.setAttribute("plantStatus", plant.getProperty("Status"));
		pageContext.setAttribute("plantType", plant.getProperty("Type"));
		pageContext.setAttribute("plantBrand", plant.getProperty("Brand"));
		pageContext.setAttribute("plantSoil", plant.getProperty("Soil"));
		Text plantNotes = (Text) plant.getProperty("Notes");
		pageContext.setAttribute("plantNotes", plantNotes.getValue());
%>
		<details>
			<summary>${fn:escapeXml(plantDescription)}</summary>
			<p>Status: ${fn:escapeXml(plantStatus)}</p>
			<p>Type: ${fn:escapeXml(plantType)}</p>
			<p>Brand: ${fn:escapeXml(plantBrand)}</p>
			<p>Soil: ${fn:escapeXml(plantSoil)}</p>
			<p>Notes: ${fn:escapeXml(plantNotes)}</p>
		</details><br>
<%
	}
%>
	</body>
</html>