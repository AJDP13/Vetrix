//
//  PetService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 06/07/2026.
//

import Foundation

public final class PetService{
	private let http: HTTPClient
	
	init(http: HTTPClient){
		self.http = http
	}
	
	public func create(
		name: String,
		date_of_birth: Date,
		owner: Client
	) async throws -> Pet {
		let request: CreatePetRequest = CreatePetRequest(
			name: name,
			dob: date_of_birth,
			owner_id: owner.id
		)
		
		return try await http.send(method: .post, path: "/pets", body: request, response: Pet.self)
	}
	
	public func get(
		id: UUID
	) async throws -> Pet{
		let response = try await http.send(method: .get, path: "/pets/\(id)", response: Pet.self)
		return response
	}
	
	public func getAll(searchQuery: String, page: Int, pageLimit: Int) async throws ->  PaginatedResponse<Pet> {
		return try await http.send(
			method: .get,
			path: "/pets?page=\(page)&pageLimit=\(pageLimit)",
			response:  PaginatedResponse<Pet>.self
		)
	}
}

//Request Structs

private struct CreatePetRequest: Encodable, Sendable {
	let name: String
	let dob: Date
	let owner_id: UUID
}

private struct UpdatePetRequest: Encodable, Sendable {
}

struct PetResponse: Decodable, Sendable {
	let id: UUID
	let name: String
	let dob: Date
	let age_string: String
	
	let owner: ClientResponse
}
