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
	
	public func getAll() async throws -> [UserSummary] {
		return try await http.send(
			method: .get,
			path: "/users",
			response: [UserSummary].self
		)
	}
	
	public func me() async throws -> User{
		let resp: UserResponse = try await http.send(method: .get, path: "/auth/me", response: UserResponse.self)
		return User(id: resp.id, username: resp.username, email: resp.email, firstName: resp.firstName, lastName: resp.lastName, isActive: resp.isActive, roles: resp.roles, permissions: resp.permissions)
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

struct UserResponse: Decodable, Sendable {
	let id: UUID
	let firstName: String
	let lastName: String
	let email: String
	let username: String
	let phone: String
	let isActive: Bool
	let roles: [Role]?
	let permissions: [Permission]?
}
