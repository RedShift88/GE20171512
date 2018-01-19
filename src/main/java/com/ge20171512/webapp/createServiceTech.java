package com.ge20171512.webapp;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class createServiceTech extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		String name = req.getParameter("name");
		String company = req.getParameter("company");
		Text notes = new Text(req.getParameter("notes"));
	
		Key serviceTechKey = KeyFactory.createKey("ServiceTech", "default");
		Entity ServiceTech = new Entity("ServiceTech", serviceTechKey);
		
		ServiceTech.setUnindexedProperty("Name", name);
		ServiceTech.setUnindexedProperty("Company", company);
		ServiceTech.setUnindexedProperty("Notes", notes);
	
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(ServiceTech);

		resp.sendRedirect("/serviceTechForm.jsp");
	}
}