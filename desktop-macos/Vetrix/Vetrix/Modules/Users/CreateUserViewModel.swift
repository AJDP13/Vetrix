//
//  CreateUserViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import Foundation
import VetrixCore

@Observable
public final class CreateUserViewModel{
	public var firstName: String = ""
	public var lastName: String = ""
	public var email: String = ""
	public var username: String = ""
	public var password: String = ""
	public var phone: String = ""
	public var isActive: Bool = true
	
	public var errorMessage: String?
	
	public var isLoading: Bool = false
	
	private let api: VetrixAPI
	
	
	init(api: VetrixAPI){
		self.api=api
	}
	
	var isPasswordValid: Bool {
		return !self.password.isEmpty && self.password.count >= 8
	}
	
	func canSubmit() -> Bool{
		return !(firstName.isEmpty && lastName.isEmpty && email.isEmpty && username.isEmpty && phone.isEmpty) && self.isPasswordValid
	}
	
	func createUser() async -> Bool {
		isLoading = true
		
		defer {
			isLoading = false
		}
		do{
			let _ = try await self.api.user.create(username: self.username, email: self.email, password: self.password, firstName: self.firstName, lastName: self.lastName)
			return true
		} catch let error as APIError{
			self.errorMessage = error.displayMessage
		}catch {
			self.errorMessage = error.localizedDescription
		}
		
		return false
	}
}
