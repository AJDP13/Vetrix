//
//  UserSummary.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 10/08/2026.
//

import Foundation

public struct UserSummary: Identifiable, Codable, Sendable {
	public let id: UUID
	public let username: String
	public let firstName: String
	public let lastName: String
	public let email: String
	public let isActive: Bool
	
	public var fullName: String {
		return firstName + " " + lastName
	}
	
	public static let preview = UserSummary(
		id: UUID(),
		username: "jdoe",
		firstName: "John",
		lastName: "Doe",
		email: "jdoe@test.com",
		isActive: true,
	)
}
