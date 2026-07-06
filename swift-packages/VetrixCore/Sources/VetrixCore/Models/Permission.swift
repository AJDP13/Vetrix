//
//  Permission.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public enum PermissionId: String, CaseIterable, Codable, Sendable {
	case viewUsers = "users.view"
	case createUsers = "users.create"
	case editUsers = "users.edit"
	case archiveUsers = "users.archive"
}

public struct Permission: Codable, Sendable{
	public let id: PermissionId
	public let description: String
}
