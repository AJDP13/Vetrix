//
//  UserViewModel.swift
//  Vetrix
//
//  Created by Arun Dutta-Plummer on 26/06/2026.
//

import Foundation
import VetrixCore

@Observable
public final class UsersViewModel{
	
	
	public var isLoading: Bool = false
	public var error: Error?
	public var userSearchText: String = ""
	public var users: [User] = []
	public var filteredUsers: [User] {
		guard !userSearchText.isEmpty else {
			return users
		}
		
		return users.filter{user in
			user.firstName.localizedCaseInsensitiveContains(userSearchText) ||
			user.lastName.localizedCaseInsensitiveContains(userSearchText) ||
			user.username.localizedCaseInsensitiveContains(userSearchText) ||
			user.email.localizedCaseInsensitiveContains(userSearchText)
		}
	}
	
	public let api: VetrixAPI
	
	init(api: VetrixAPI, users: [User] = []){
		self.api = api
		self.users = users
	}
	
	func loadUsers() async {
		isLoading = true
		defer {
			isLoading = false
		}
		
		do{
			users = try await api.user.getAll()
			
		}catch {
			self.error = error
		}
	}
}
