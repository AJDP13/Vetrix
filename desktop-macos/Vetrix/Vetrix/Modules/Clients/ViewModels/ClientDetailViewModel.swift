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
			
			if let client = client{
				firstName = client.firstName
				lastName = client.lastName
				email = client.email
				phone = client.phone
				address1 = client.addressLine1
				address2 = client.addressLine2
				address3 = client.addressLine3
				addressCity = client.addressCity
				addressPostcode = client.addressPostcode
			}
			
		}catch{
			api.errorManager.present(error)
		}
	}
	
	func saveChanges() async -> Client? {
		isLoading = true
		
		do{
			let updatedClient = try await api.client.edit(id: self.clientId, firstName: self.firstName, lastName: self.lastName, email: self.email, phone: self.phone, address1: self.address1, address2: self.address2, address3: self.address3, city: self.addressCity, postcode: self.addressPostcode)
			
			self.client = updatedClient
			
			return updatedClient
		}catch{
			api.errorManager.present(error)
			return nil
		}
	}
}
