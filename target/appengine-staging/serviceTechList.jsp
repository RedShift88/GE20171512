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
		<title>Service Tech List</title>
	</head>
	<body>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	Key serviceTechKey = KeyFactory.createKey("ServiceTech", "default");
	Query serviceTechQuery = new Query("ServiceTech", serviceTechKey);
	List<Entity> serviceTechList = datastore.prepare(serviceTechQuery).asList(FetchOptions.Builder.withDefaults());
	String company = "";
	String companyTest = "";
	for(Entity serviceTech : serviceTechList){
		companyTest = (String) serviceTech.getProperty("Company");
		if(!company.equals(companyTest)){
			company = companyTest;
			pageContext.setAttribute("groupHeading", companyTest);
%>
		<h3>${fn:escapeXml(groupHeading)}</h3>
<%
		}
		pageContext.setAttribute("serviceTech", serviceTech.getProperty("Name"));
%>
		<p>${fn:escapeXml(serviceTech)}</p><br>
<%
	}
%>
	</body>
</html>