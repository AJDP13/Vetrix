//
//  Pet.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct Pet: Codable, Sendable, Identifiable, Hashable {
	public let id: UUID
	public let name: String
	public let dob: Date
	public let ageString: String
	public let archived: Bool
	
	public let owner: Client
	
	public var displayName: String {
		if self.archived{
			return "DELETED PET - \(self.name)"
		}else{
			return name
		}
	}
	
	public static let preview = Pet(id: UUID(), name: "Pet", dob: Date(), ageString: "12 Years 2 Days", archived: false, owner: .preview)
	
	public func withArchived(_ archived: Bool) -> Pet {
		Pet(
			id: id,
			name: name,
			dob: dob,
			ageString: ageString,
			archived: true,
			owner: owner
		)
	}
}
