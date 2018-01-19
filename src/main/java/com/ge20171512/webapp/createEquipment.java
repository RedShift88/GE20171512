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

public class createEquipment extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		String description = req.getParameter("description");
		String status = req.getParameter("status");
		String type = req.getParameter("type");
		String make = req.getParameter("make");
		String model = req.getParameter("model");
		Integer year = Integer.parseInt(req.getParameter("year"));
		String location = req.getParameter("location");
		Text notes = new Text(req.getParameter("notes"));
	
		Key equipmentKey = KeyFactory.createKey("Equipment", "default");
		Entity equipment = new Entity("Equipment", equipmentKey);
		
		equipment.setUnindexedProperty("Description", description);
		equipment.setProperty("Status", status);
		equipment.setProperty("Type", type);
		equipment.setUnindexedProperty("Make", make);
		equipment.setUnindexedProperty("Model", model);
		equipment.setUnindexedProperty("Year", year);
		equipment.setProperty("Location", location);
		equipment.setUnindexedProperty("Notes", notes);
	
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(equipment);

		resp.sendRedirect("/");
	}
}