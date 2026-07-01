//
//  SessionManager.swift
//  VetrixCore
//
//  Created by Arun Dutta-Plummer on 25/06/2026.
//

import Foundation

@Observable
public final class SessionManager{
	public var accessToken: String?
	public var refreshToken: String?
	public var expiry: Date?
	public var user: User?
	
	
	init(){}
	
	public var isExpired: Bool{
		guard let expiry else{return true}
		return expiry <= Date()
	}
	
	public func reset(){
		self.accessToken = nil
		self.refreshToken = nil
		self.expiry = nil
		self.user = nil
	}
	
	public func update(accessToken: String, refreshToken: String, user: User){
		self.accessToken = accessToken
		self.refreshToken = refreshToken
		self.user = user
	}
	
	public var isAuthenticated: Bool {
		accessToken != nil
	}
}
