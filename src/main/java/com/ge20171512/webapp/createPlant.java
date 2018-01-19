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

public class createPlant extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException {
		String description = req.getParameter("description");
		String status = req.getParameter("status");
		String type = req.getParameter("type");
		String brand = req.getParameter("brand");
		String soil = req.getParameter("soil");
		Integer batchNum = Integer.parseInt(req.getParameter("batchNum"));
		String location = req.getParameter("location");
		Text notes = new Text(req.getParameter("notes"));
	
		Key plantKey = KeyFactory.createKey("Plant", "default");
		Entity plant = new Entity("Plant", plantKey);
		
		plant.setUnindexedProperty("Description", description);
		plant.setProperty("Status", status);
		plant.setProperty("Type", type);
		plant.setProperty("Brand", brand);
		plant.setProperty("Soil", soil);
		plant.setUnindexedProperty("Batch Number", batchNum);
		plant.setProperty("Location", location);
		plant.setUnindexedProperty("Notes", notes);
	
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(plant);

		resp.sendRedirect("/plantList.jsp");
	}
}