//
//  Permission.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public enum PermissionId: String, CaseIterable, Codable, Sendable {
	case createRoles = "roles.create"
	case viewRoles = "roles.view"
	case editRoles = "roles.edit"
	case deleteRoles = "roles.delete"

	case manageUserRoles = "roles.manage_users"

	case createUsers = "users.create"
	case viewUsers = "users.view"
	case editUsers = "users.edit"
	case deactivateUsers = "users.deactivate"

	case createClients = "clients.create"
	case viewClients = "clients.view"
	case editClients = "clients.edit"
	case archiveClients = "clients.archive"

	case createPets = "pets.create"
	case viewPets = "pets.view"
	case editPets = "pets.edit"
	case archivePets = "pets.archive"

	case createDrugs = "drugs.create"
	case viewDrugs = "drugs.view"
	case editDrugs = "drugs.edit"
	case deleteDrugs = "drugs.delete"

	case createPrescriptions = "prescriptions.create"
	case viewPrescriptions = "prescriptions.view"
	case editPrescriptions = "prescriptions.edit"
	case deletePrescriptions = "prescriptions.delete"
}

public struct Permission: Codable, Sendable{
	public let id: PermissionId
	public let description: String
}
