//
//  User.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct User: Codable{
	public let id: UUID
	public let username: String
	public let email: String
	public let firstName: String
	public let lastName: String
	public let isActive: Bool
}
