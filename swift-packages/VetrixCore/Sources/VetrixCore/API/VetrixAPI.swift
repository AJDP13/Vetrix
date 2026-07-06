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
	public let client: ClientService
	public let pet: PetService

	public let appSession: SessionManager
	public let errorManager: ErrorManager
	private let http: HTTPClient

	public init(configuration: APIConfiguration) {

		self.appSession = SessionManager()
		self.errorManager = ErrorManager()

		self.http = HTTPClient(
			configuration: configuration,
			session: .shared,
			appSession: appSession
		)

		self.user = UserService(http: http)
		self.auth = AuthenticationService(http: http, appSession: appSession)
		self.client = ClientService(http: http)
		self.pet = PetService(http: http)
	}
}
