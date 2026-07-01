//
//  UserService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public final class UserService{
	private let http: HTTPClient
	
	init(http: HTTPClient){
		self.http = http
	}
	
	public func create(
		username: String,
		email: String,
		password: String,
		firstName: String,
		lastName: String? = nil
	) async throws -> User {
		let request: CreateUserRequest = CreateUserRequest(
			username: username,
			email: email,
			password: password,
			firstName: firstName,
			lastName: lastName
		)
		
		return try await http.send(method: .post, path: "/users", body: request, response: User.self)
	}
	
	public func get(
		id: UUID
	) async throws -> User{
		let response = try await http.send(method: .get, path: "/users/\(id)", response: User.self)
		return response
	}
	
	public func getAll() async throws -> [User] {
		return try await http.send(
			method: .get,
			path: "/users",
			response: [User].self
		)
	}
}

//Request Structs

private struct CreateUserRequest: Encodable, Sendable {
	let username: String
	let email: String
	let password: String
	let firstName: String
	let lastName: String?
}

private struct UpdateUserRequest: Encodable, Sendable {
	let password: String?
	let isActive: String?
}

