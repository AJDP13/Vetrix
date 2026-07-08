//
//  Pet.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct Pet: Codable, Sendable {
	public let id: UUID
	public let name: String
	public let dob: Date
	public let ageString: String
	
	public let owner: Client
	
	public static let preview = Pet(id: UUID(), name: "Pet", dob: Date(), ageString: "12 Years 2 Days", owner: .preview)
}
