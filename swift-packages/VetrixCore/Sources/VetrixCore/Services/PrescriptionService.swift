//
//  PrescriptionService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 08/07/2026.
//

import Foundation

public final class PrescriptionService{
	private let http: HTTPClient
	
	init(http: HTTPClient){
		self.http = http
	}
	
	public func getAll(
		page: Int = 1,
		pageLimit: Int = 10
	) async throws -> PaginatedResponse<Prescription>{
		let response = try await http.send(method: .get, path: "/prescriptions/?page=\(page)&pageLimit=\(pageLimit)", response: PaginatedResponse<Prescription>.self)
		
		return response
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

private struct PetResponse: Decodable, Sendable {
	let id: UUID
	let name: String
	let dob: Date
	let age_string: String
	
	let owner: ClientResponse
}
