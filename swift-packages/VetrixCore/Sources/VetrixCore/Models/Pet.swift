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
}
