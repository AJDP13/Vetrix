//
//  Client.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct Client: Codable, Sendable {
	public let id: UUID
	public let firstName: String
	public let lastName: String
	public let email: String
	public let phone: String
	
	public let pets: [Pet]?
}
