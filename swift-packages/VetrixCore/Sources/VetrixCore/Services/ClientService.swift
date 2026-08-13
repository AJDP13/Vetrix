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
	
	public func edit(
		id: UUID,
		firstName: String?,
		lastName: String?,
		email: String?,
		phone: String?,
		address1: String?,
		address2: String?,
		address3: String?,
		city: String?,
		postcode: String?
	) async throws -> Client {
		let request: UpdateClientRequest = UpdateClientRequest(
			first_name: firstName,
			last_name: lastName,
			email: email,
			phone: phone,
			address_line_1: address1,
			address_line_2: address2,
			address_line_3: address3,
			address_city: city,
			address_postcode: postcode
		)
		
		print("Client Edit ID:\(id.uuidString.lowercased())")
		
		let response = try await http.send(
			method: .patch,
			path: "/clients/\(id.uuidString.lowercased())",
			body: request,
			response: Client.self
		)
		
		return response
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
	let first_name: String?
	let last_name: String?
	let email: String?
	let phone: String?
	let address_line_1: String?
	let address_line_2: String?
	let address_line_3: String?
	let address_city: String?
	let address_postcode: String?
}

struct ClientResponse: Decodable, Sendable {
	let id: UUID
	let first_name: String
	let last_name: String
	let email: String
	let phone: String
}
