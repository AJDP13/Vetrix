//
//  AuthenticationService.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public final class AuthenticationService{
	private let http: HTTPClient
	private let appSession: SessionManager
	
	init(http: HTTPClient, appSession: SessionManager){
		self.http = http
		self.appSession = appSession
	}
	
	public func login(
		username: String,
		password: String
	) async throws -> User {
		let request: LoginRequest = LoginRequest(username: username, password: password)
		
		let response:LoginResponse = try await http.send(method: .post, path: "/auth/login", body: request, response: LoginResponse.self)
		
		self.appSession.update(accessToken: response.accessToken, refreshToken: response.refreshToken, user: response.user)
		
		return response.user
	}
	
	public func logout() async throws{
		if let token = self.appSession.refreshToken{
			let body: LogoutRequest = LogoutRequest(refreshToken: token)
			try await http.send(method: .post, path: "/auth/logout", body: body)
		}
		self.appSession.reset()
	}
}

//Request Structs

private struct LoginRequest: Encodable, Sendable {
	let username: String
	let password: String
}


private struct LoginResponse: Decodable {
	let user: User
	let permissions: [Permission]?
	let accessToken: String
	let refreshToken: String
}

private struct LogoutRequest: Encodable, Sendable {
	let refreshToken: String
}
