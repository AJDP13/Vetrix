//
//  Role.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public struct Role: Codable, Sendable{
	public let id: UUID
	public let name: String
	public let description: String
	public let permissions: [Permission]
	public let priority: Int
}
