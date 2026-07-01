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
	
	private let api: VetrixAPI
	
	
	init(api: VetrixAPI){
		self.api=api
	}
	
	func canSubmit() -> Bool{
		return !(firstName.isEmpty && lastName.isEmpty && email.isEmpty && username.isEmpty && phone.isEmpty)
	}
	
	func createUser() async throws {
		
	}
}
