//
//  User.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct User: Identifiable, Codable, Sendable {
	public let id: UUID
	public let username: String
	public let email: String
	public let firstName: String
	public let lastName: String
	public let isActive: Bool
	
	public static let preview = User(
		id: UUID(),
		username: "jdoe",
		email: "john@example.com",
		firstName: "John",
		lastName: "Doe",
		isActive: true
	)
}
