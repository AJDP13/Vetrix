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
	
	public func create(
		pet_id: UUID,
		prescribed_at: Date,
		expires_at: Date,
		max_repeats: Int,
		repeat_interval_day: Int,
		prescribed_by: String?,
		prescribing_practice: String?,
		notes: String,
		state: PrescriptionState = .active
	) async throws -> Prescription{
		let request: CreatePrescriptionRequest = CreatePrescriptionRequest(
			pet_id: pet_id,
			prescribed_at: prescribed_at,
			expires_at: expires_at,
			max_repeats: max_repeats,
			repeat_interval_days: repeat_interval_day,
			prescribed_by: prescribed_by,
			prescribing_practice: prescribing_practice,
			notes: notes,
			state: state
		)
		
		let response = try await http.send(method: .post, path: "/prescriptions", body: request, response: Prescription.self)
		
		return response
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

private struct CreatePrescriptionRequest: Encodable, Sendable {
	let pet_id: UUID
	let prescribed_at: Date
	let expires_at: Date
	let max_repeats: Int
	let repeat_interval_days: Int
	let prescribed_by: String?
	let prescribing_practice: String?
	let notes: String
	let state: PrescriptionState
}

private struct UpdatePetRequest: Encodable, Sendable {
}
