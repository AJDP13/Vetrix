//
//  VetrixAPI.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

@Observable
public final class VetrixAPI {

	public let user: UserService
	public let auth: AuthenticationService

	public let appSession: SessionManager
	private let http: HTTPClient

	public init(configuration: APIConfiguration) {

		self.appSession = SessionManager()

		self.http = HTTPClient(
			configuration: configuration,
			session: .shared,
			appSession: appSession
		)

		self.user = UserService(http: http)
		self.auth = AuthenticationService(http: http, appSession: appSession)
	}
}
