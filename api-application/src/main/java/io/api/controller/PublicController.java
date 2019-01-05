package io.api.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import io.api.dao.UsersDao;
import io.api.dao.UsersRepository;
import io.api.model.Users;

@RestController
public class PublicController {

	@Autowired
	UsersRepository usersRepository;

	UsersDao userDao = new UsersDao();

	@GetMapping("/api/users")
	public List<Users> getUser() {
		return usersRepository.findAll();
	}

	private Map<String, Object> jsonObject(Boolean success, String typeRes, String messageRes, Users user) {
		Map<String, Object> json = new HashMap<String, Object>();
		json.put("success", success);
		json.put("type", typeRes);
		json.put("message", messageRes);
		if (success) {
			json.putAll(userDao.userObject(user));
		}
		return json;
	}

	@PostMapping(value = "/api/users", produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> addUser(HttpServletRequest request) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Users user = new Users(username, password);
		try {

			if (username.equals("an"))
				throw new Exception();
			usersRepository.save(user);
			return jsonObject(true, "alert-success", "this is success mess", user);
		} catch (Exception e) {
			return jsonObject(false, "alert-danger", "this is danger mess", null);
		}
	}
}
