package io.tracking.dao;

import java.util.HashMap;
import java.util.Map;

import io.tracking.sdk.aftership.Classes.Courier;
import io.tracking.sdk.aftership.Classes.Tracking;

public class ConvertObjectToJson {
	public Map<String, Object> couriersToJson(Courier courier) {
		Map<String, Object> courierJson = new HashMap<>();
		courierJson.put("slug", courier.getSlug());
		courierJson.put("name", courier.getName());
		courierJson.put("phone", courier.getPhone());
		courierJson.put("othername", courier.getOther_name());
		courierJson.put("weburl", courier.getWeb_url());
		return courierJson;
	}

	public Map<String, Object> trackingsToJson(Tracking tracking) {
		Map<String, Object> trackingJson = new HashMap<>();
		trackingJson.put("id", tracking.getId());
		trackingJson.put("trackingNumber", tracking.getTrackingNumber());
		trackingJson.put("slug", tracking.getSlug());
		trackingJson.put("emails", tracking.getEmails());
		trackingJson.put("smses", tracking.getSmses());
		trackingJson.put("title", tracking.getTitle());
		trackingJson.put("customerName", tracking.getCustomerName());
		trackingJson.put("deliveryTime", tracking.getDeliveryTime());
		trackingJson.put("destinationCountryISO3", tracking.getDestinationCountryISO3());
		trackingJson.put("originCountryISO3", tracking.getOriginCountryISO3());
		trackingJson.put("orderID", tracking.getOrderID());
//		trackingJson.put("orderIDPath", tracking.getOrderIDPath());
		trackingJson.put("createdAt", tracking.getCreatedAt());
		trackingJson.put("updatedAt", tracking.getUpdatedAt());
//		trackingJson.put("expectedDelivery", tracking.getExpectedDelivery());
//		trackingJson.put("shipmentPackageCount", tracking.getShipmentPackageCount());
		trackingJson.put("shipmentType", tracking.getShipmentType());
		trackingJson.put("signedBy", tracking.getSignedBy());
//		trackingJson.put("source", tracking.getSource());
		trackingJson.put("tag", tracking.getTag());
//		trackingJson.put("trackedCount", tracking.getTrackedCount());
//		trackingJson.put("uniqueToken", tracking.getUniqueToken());
//		trackingJson.put("trackingAccountNumber", tracking.getTrackingAccountNumber());
//		trackingJson.put("trackingPostalCode", tracking.getTrackingPostalCode());
//		trackingJson.put("trackingShipDate", tracking.getTrackingShipDate());
		return trackingJson;
	}

}
