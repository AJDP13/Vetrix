//
//  UserDetailViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 01/07/2026.
//

import Foundation
import VetrixCore

@Observable
public final class UserDetailViewModel{
	public var user: User?
	private var userId: UUID
	private let api: VetrixAPI
	
	public var isLoading: Bool = false
	
	init(_ userId: UUID, api: VetrixAPI){
		self.userId = userId
		self.api = api
	}
	
	func reload() async {
		isLoading = true
		
		defer{
			isLoading = false
		}
		
		do{
			user = try await api.user.get(id: self.userId)
		}catch{
			api.errorManager.present(error)
		}
	}
		
	//PW Funcs
	func resetPassword(){
		
	}
	
	func setPassword(newPw: String){
		
	}
	
	//User Demographics funcs
	func updateDetails(firstName: String, lastName: String, email: String, phone: String){
		
	}
	
	
	 //Role Funcs
	
	func removeRole(id: String){
		
	}
	
	func loadUserRoles(){
		
	}
}
