package io.api.model;

import java.io.Serializable;
import java.util.Date;

import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

@Document("users")
public class Users implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1225528927136044876L;

	private String username;
	private String password;
	private String role;
	@Indexed(name = "createdAtIndex", expireAfterSeconds = 3600)
	private Date createdAt;

	public Users() {
	}

	public Users(String username, String password) {
		this.username = username;
		this.password = password;
		this.createdAt = new Date();
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public String getRole() {
		return role;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

}
