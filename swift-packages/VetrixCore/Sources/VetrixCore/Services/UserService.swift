//
//  UserService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public final class UserService{
	private let http: HTTPClient
	
	init(http: HTTPClient){
		self.http = http
	}
}

//Request Structs

private struct CreateUserRequest: Encodable, Sendable {
	let username: String
	let email: String
	let password: String
	let firstName: String
	let lastName: String?
}
