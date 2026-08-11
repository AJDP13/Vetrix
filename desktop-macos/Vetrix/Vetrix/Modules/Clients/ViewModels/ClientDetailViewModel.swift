//
//  ClientDetailViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 11/08/2026.
//
import Foundation
import VetrixCore

@Observable
public final class ClientDetailViewModel{
	public var client: Client?
	private var clientId: UUID
	private let api: VetrixAPI
	
	public var isLoading: Bool = false
	
	//Client Mutable details
	public var firstName: String = ""
	public var lastName: String = ""
	public var email: String = ""
	public var phone: String = ""
	public var address1: String = ""
	public var address2: String = ""
	public var address3: String = ""
	public var addressCity: String = ""
	public var addressPostcode: String = ""
	
	init(_ clientId: UUID, api: VetrixAPI){
		self.clientId = clientId
		self.api = api
	}
	
	func reload() async {
		isLoading = true
		
		defer{
			isLoading = false
		}
		
		do{
			client = try await api.client.get(id: self.clientId)
		}catch{
			api.errorManager.present(error)
		}
	}
}
