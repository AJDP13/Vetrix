//
//  VetrixAPI.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

@Observable
public final class VetrixAPI {
	
	public var serverService: ServerService

	public let user: UserService
	public let auth: AuthenticationService
	public let client: ClientService
	public let pet: PetService
	public let prescription: PrescriptionService

	public let appSession: SessionManager
	public let errorManager: ErrorManager
	private let http: HTTPClient

	public init(configuration: APIConfiguration) {
		let serverService = ServerService()

		
		self.serverService = serverService

		self.appSession = SessionManager()
		self.errorManager = ErrorManager()
		let config = APIConfiguration(baseURL: serverService.selectedServer?.url ?? URL(string: "")!)

		self.http = HTTPClient(
			serverService: serverService,
			session: .shared,
			appSession: appSession
		)

		self.user = UserService(http: http)
		self.auth = AuthenticationService(http: http, appSession: appSession)
		self.client = ClientService(http: http)
		self.pet = PetService(http: http)
		self.prescription = PrescriptionService(http: http)
	}
}
