//
//  VetrixAPI.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

public final class VetrixAPI {

	public let user: UserService

	private let authentication: AuthenticationManager
	private let http: HTTPClient

	public init(configuration: APIConfiguration) {

		self.authentication = AuthenticationManager()

		self.http = HTTPClient(
			configuration: configuration,
			session: .shared,
			authentication: authentication
		)

		self.user = UserService(http: http)
	}
	
	public var isAuthenticated: Bool {
		self.authentication.accessToken != nil
	}
	
	
}
