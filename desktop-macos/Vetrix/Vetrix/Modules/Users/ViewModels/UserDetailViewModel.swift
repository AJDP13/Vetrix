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
	public var user: User
	
	init(user: User){
		self.user = user
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
