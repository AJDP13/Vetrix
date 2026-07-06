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
	public let roles: [Role]?
	public let permissions: [Permission]?
	
	public static let preview = User(
		id: UUID(),
		username: "jdoe",
		email: "john@example.com",
		firstName: "John",
		lastName: "Doe",
		isActive: true,
		roles:[
			Role(
				id: UUID(),
				name: "Test Role",
				description: "Testng Preview Role",
				permissions: [
					Permission(
						id: "users.create",
						description: "Test"
					),
					Permission(
						id: "users.view",
						description: "test"
					)
				],
				priority: 2
			)
		],
		permissions: [
			Permission(
				id: "users.create",
				description: "Test"
			),
			Permission(
				id: "users.view",
				description: "test"
			)
		]
	)
	
	public func hasPermission(perm_id: String) -> Bool{
		guard self.permissions != nil else {return false} //Ensure there are perms in the object
		
		for permission in self.permissions! {
			if(permission.id == perm_id){
				return true
			}
		}
		
		return false
	}
}
