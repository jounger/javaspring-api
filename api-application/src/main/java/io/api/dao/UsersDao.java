package io.api.dao;

import java.util.HashMap;
import java.util.Map;

import io.api.model.Users;

public class UsersDao {
	
	public Map<String, Object> userObject(Users user) {
		Map<String, Object> userJson = new HashMap<>();
		userJson.put("username", user.getUsername());
		userJson.put("password", user.getPassword());
		userJson.put("createdAt", user.getCreatedAt());
		return userJson;
	}
}
