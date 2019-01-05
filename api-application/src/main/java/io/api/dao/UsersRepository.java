package io.api.dao;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import io.api.model.Users;

public interface UsersRepository extends MongoRepository<Users, String>{
	
	List<Users> findAll();
}
