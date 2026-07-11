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
		
	) async throws -> Client {
		return .preview
	}
	
	public func getAll(
		page: Int = 1,
		pageLimit: Int = 10
	) async throws -> PaginatedResponse<Client>{
		let response = try await http.send(method: .get, path: "/clients/?page=\(page)&pageLimit=\(pageLimit)", response: PaginatedResponse<Client>.self)
		
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
}

struct ClientResponse: Decodable, Sendable {
	let id: UUID
	let first_name: String
	let last_name: String
	let email: String
	let phone: String
}
