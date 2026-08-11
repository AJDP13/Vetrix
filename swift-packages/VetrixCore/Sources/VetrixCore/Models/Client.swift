//
//  Client.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct Client: Codable, Sendable, Identifiable, Hashable {
	public let id: UUID
	public let firstName: String
	public let lastName: String
	public let email: String
	public let phone: String
	
	public let addressLine1: String
	public let addressLine2: String
	public let addressLine3: String
	public let addressCity: String
	public let addressPostcode: String
	
	public var fullName: String {
		firstName + " " + lastName
	}
	
	public let pets: [Pet]?
	
	public static let preview = Client(
		id: UUID(),
		firstName: "John",
		lastName: "Smith",
		email: "joyn@smih.com",
		phone: "07817202247",
		addressLine1: "Line 1",
		addressLine2: "Line 2",
		addressLine3: "Line 3",
		addressCity: "City",
		addressPostcode: "Postcode",
		pets: nil
	)
}
