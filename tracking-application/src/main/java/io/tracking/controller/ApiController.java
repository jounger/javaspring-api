package io.tracking.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import io.tracking.dao.ConvertObjectToJson;
import io.tracking.sdk.aftership.Classes.AftershipAPIException;
import io.tracking.sdk.aftership.Classes.ConnectionAPI;
import io.tracking.sdk.aftership.Classes.Courier;
import io.tracking.sdk.aftership.Classes.ParametersTracking;
import io.tracking.sdk.aftership.Classes.Tracking;

@RestController
public class ApiController {

	// https://github.com/AfterShip/aftership-sdk-java
	// Create a connectionAPI with your API Key (you will link it to your account)
	ConnectionAPI connection = new ConnectionAPI("1e750365-0688-4e60-a106-7abe41818735");

	// convert object to json to response client
	ConvertObjectToJson convertToJson = new ConvertObjectToJson();

	private Map<String, Object> responseError(String type, String message) {
		Map<String, Object> res = new HashMap<String, Object>();
		res.put("type", type);
		res.put("message", message);
		return res;
	}

	// get all couriers
	@GetMapping("/api/couriers/all")
	public List<Map<String, Object>> getAllCouriers() {
		List<Courier> couriers = null;
		List<Map<String, Object>> listCouriers = new ArrayList<>();
		try {
			couriers = connection.getAllCouriers();
			for (Courier courier : couriers) {
				listCouriers.add(convertToJson.couriersToJson(courier));
			}
		} catch (Exception e) {
			e.printStackTrace();
			listCouriers.add(responseError("alert-warning", "Cannot load couriers!"));
		}
		return listCouriers;
	}

	// get my couriers
	@GetMapping("/api/couriers")
	public List<Map<String, Object>> getCouriers() {
		List<Courier> couriers = null;
		List<Map<String, Object>> listCouriers = new ArrayList<>();
		try {
			couriers = connection.getCouriers();
			for (Courier courier : couriers) {
				listCouriers.add(convertToJson.couriersToJson(courier));
			}
		} catch (Exception e) {
			e.printStackTrace();
			listCouriers.add(responseError("alert-warning", "Cannot load couriers!"));
		}
		return listCouriers;
	}

	@GetMapping("/api/trackings")
	public List<Map<String, Object>> getTrackings() {
		List<Tracking> trackings = null;
		List<Map<String, Object>> listTrackings = new ArrayList<>();
		try {
			trackings = connection.getTrackings(1);
			for (Tracking tracking : trackings) {
				listTrackings.add(convertToJson.trackingsToJson(tracking));
			}
		} catch (Exception e) {
			e.printStackTrace();
			listTrackings.add(responseError("alert-warning", "Cannot load trackings!"));
		}
		return listTrackings;
	}

	@PostMapping("/api/trackings")
	public Map<String, Object> postTracking(HttpServletRequest request, HttpServletResponse response) {
		String trackingNumber = request.getParameter("trackingNumber");
		String slug = request.getParameter("slug");
		String title = request.getParameter("title");
		String orderID = request.getParameter("orderID");
		String customerName = request.getParameter("customerName");
		String emails = request.getParameter("emails");
		Tracking tracking1 = new Tracking(trackingNumber);
		tracking1.setSlug(slug);
		tracking1.setTitle(title);
		tracking1.setOrderID(orderID);
		tracking1.setCustomerName(customerName);
		tracking1.addEmails(emails);
		Tracking trackingPosted = null;
		try {
			trackingPosted = connection.postTracking(tracking1);
			return convertToJson.trackingsToJson(trackingPosted);
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cannot add new Tracking!");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			return responseError("alert-warning", "Cannot load trackings!");
		}

	}

	// if tracking existed return true;
	private boolean isExistTracking(String trackingNumber, String slug) {
		Tracking trackingToGet = new Tracking(trackingNumber);
		trackingToGet.setSlug(slug);
		Tracking tracking = null;
		try {
			tracking = connection.getTrackingByNumber(trackingToGet);
			if (tracking != null) {
				return true;
			}
		} catch (Exception e) {
		}
		return false;
	}

	@PutMapping("/api/trackings")
	public Map<String, Object> putTracking(HttpServletRequest request, HttpServletResponse response) {
		String trackingNumber = request.getParameter("trackingNumber");
		String slug = request.getParameter("slug");
		if (isExistTracking(trackingNumber, slug)) {
			String title = request.getParameter("title");
			String orderID = request.getParameter("orderID");
			String customerName = request.getParameter("customerName");
			Tracking tracking1 = new Tracking(trackingNumber);
			tracking1.setSlug(slug);
			tracking1.setTitle(title);
			tracking1.setOrderID(orderID);
			tracking1.setCustomerName(customerName);
			Tracking trackingPutted = null;
			try {
				trackingPutted = connection.putTracking(tracking1);
				return convertToJson.trackingsToJson(trackingPutted);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		try {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cannot edit selected tracking 2!");
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return responseError("alert-warning", "Cannot load trackings!");

	}
	
	@DeleteMapping("/api/trackings")
	public Map<String, Object> deleteTracking(HttpServletRequest request, HttpServletResponse response){
		String trackingNumber = request.getParameter("trackingNumber");
		String slug = request.getParameter("slug");
		System.out.println("num"+trackingNumber+"slug"+slug);
		Tracking trackingDelete = new Tracking(trackingNumber);//tracking number
		trackingDelete.setSlug(slug);
		if (isExistTracking(trackingNumber, slug)) {
			try {
				connection.deleteTracking(trackingDelete);
				response.setStatus(200);
				return responseError("alert-success", "Success delete selected trackings!");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cannot delete selected tracking 2!");
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return responseError("alert-warning", "Cannot load trackings!");
		
	}

//
//	public Map<String, Object> toMap(JSONObject object) throws JSONException {
//		Map<String, Object> map = new HashMap<String, Object>();
//		Iterator<String> keysItr = object.keys();
//		while (keysItr.hasNext()) {
//			String key = keysItr.next();
//			Object value = object.get(key);
//			if (value instanceof JSONArray) {
//				value = toList((JSONArray) value);
//			}
//			else if (value instanceof JSONObject) {
//				value = toMap((JSONObject) value);
//			}
//			map.put(key, value);
//		}
//		return map;
//	}
//
//	public List<Object> toList(JSONArray array) throws JSONException {
//		List<Object> list = new ArrayList<Object>();
//		for (int i = 0; i < array.length(); i++) {
//			Object value = array.get(i);
//			if (value instanceof JSONArray) {
//				value = toList((JSONArray) value);
//			}
//			else if (value instanceof JSONObject) {
//				value = toMap((JSONObject) value);
//			}
//			list.add(value);
//		}
//		return list;
//	}
//	

}
