//
//  LoginViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation
import VetrixCore

@Observable
final class LoginViewModel{
	var username = ""
	var password = ""
	
	var isLoading = false
	var errorMessage: String?
	
	var canLogin: Bool {
		!username.isEmpty &&
		!password.isEmpty &&
		!isLoading
	}
	
	private let api: VetrixAPI
	
	init(api: VetrixAPI){
		self.api = api
	}
	
	func login() async {
		guard !isLoading else {return}
		
		errorMessage = nil
		isLoading = true
		
		defer{
			isLoading = false
		}
		
		do{
			let user = try await api.auth.login(username: username, password: password)
			print("User: \(user)")
		} catch let error as APIError{
			errorMessage = error.displayMessage
		} catch{
			errorMessage = error.localizedDescription
		}
	}
}
