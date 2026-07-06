//
//  WorkspaceItem.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 26/06/2026.
//

import Foundation
import VetrixCore

struct WorkspaceItem: Identifiable {
	let id: Workspace
	let title: String
	let systemImage: String
	let requiredPermissionId: PermissionId?
}
