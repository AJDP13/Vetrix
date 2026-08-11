//
//  ClientService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 06/07/2026.
//

import Foundation

public final class ClientService{
	private let http: HTTPClient
	
	init(http: HTTPClient){
		self.http = http
	}
	
	public func create(
		firstName: String,
		lastName: String,
		email: String,
		phone: String
	) async throws -> Client {
		let request: CreateClientRequest = CreateClientRequest(
			first_name: firstName, last_name: lastName, email: email, phone: phone
		)
		
		let response = try await http.send(
			method: .post,
			path: "/clients",
			body:request,
			response: Client.self
		)
		
		return response
	}
	
	public func search(
		search: String = "",
		page: Int = 1,
		pageLimit: Int = 10
	) async throws -> PaginatedResponse<Client>{
		let response = try await http.send(method: .get, path: "/clients/?page=\(page)&pageLimit=\(pageLimit)&search=\(search)", response: PaginatedResponse<Client>.self)
		
		return response
	}
	
	public func get(
		id: UUID
	) async throws -> Client {
		let response = try await http.send(
			method: .get,
			path: "/clients/\(id)",
			response: Client.self
		)
		
		return response
	}
	
	public func archive(
		id: UUID
	) async throws {
		let response = try await http.send(
			method: .delete,
			path: "/clients/\(id.uuidString.lowercased())"
		)
		
		return
	}
}

//Request Structs

private struct CreateClientRequest: Encodable, Sendable {
	let first_name: String
	let last_name: String
	let email: String
	let phone: String
}

private struct UpdateClientRequest: Encodable, Sendable {
}

struct ClientResponse: Decodable, Sendable {
	let id: UUID
	let first_name: String
	let last_name: String
	let email: String
	let phone: String
}
